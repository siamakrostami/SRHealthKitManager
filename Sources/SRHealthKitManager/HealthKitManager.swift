//
//  HealthKitManager.swift
//  SRHealthKitManager
//
//  Created by Siamak on 2/22/25.
//

import Foundation
import HealthKit

/// Main class for handling HealthKit operations.
///
/// This class provides functionality for requesting authorization,
/// saving health samples with duplicate checking, filtering duplicate samples,
/// and reading samples from HealthKit in both callback-based and async/await styles.
@available(iOS 13.0, macOS 13.0, *)
public final class HealthKitManager: @unchecked Sendable {
    // MARK: Lifecycle

    /// Private initializer to enforce singleton usage.
    private init() {}

    // MARK: Public

    /// Shared instance of the HealthKit manager.
    public static let shared = HealthKitManager()

    // MARK: Internal

    // MARK: - Internal Methods

    // MARK: Authorization Methods

    /// Requests authorization for the specified HealthKit data types.
    ///
    /// - Parameters:
    ///   - typesToShare: The set of HKSampleType objects that the app intends to write.
    ///   - typesToRead: The set of HKObjectType objects that the app intends to read.
    ///   - completion: A completion handler that returns a `Result` with a Boolean indicating success or an `Error`.
    public func requestAuthorization(
        toShare typesToShare: Set<HKSampleType>? = Set(HealthKitTypes.writableTypes.compactMap{$0}),
        read typesToRead: Set<HKObjectType>? = Set(HealthKitTypes.readableTypes.compactMap{$0}),
        completion: @escaping @Sendable (Result<Bool, Error>) -> Void
    ) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(.failure(HealthKitError.healthKitNotAvailable))
            return
        }

        self.typesToRead = typesToRead
        self.typesToShare = typesToShare

        healthStore.requestAuthorization(
            toShare: typesToShare, read: typesToRead
        ) { [weak self] success, error in
            guard let self else {
                return
            }

            queue.async {
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(success))
                }
            }
        }
    }

    /// Async version of `requestAuthorization(toShare:read:completion:)`.
    ///
    /// - Parameters:
    ///   - typesToShare: The set of HKSampleType objects that the app intends to write.
    ///   - typesToRead: The set of HKObjectType objects that the app intends to read.
    /// - Returns: A Boolean value indicating whether authorization was successful.
    /// - Throws: An error of type `HealthKitError` if authorization fails.
    public func requestAuthorization(
        toShare typesToShare: Set<HKSampleType>? = Set(HealthKitTypes.writableTypes.compactMap{$0}),
        read typesToRead: Set<HKObjectType>? = Set(HealthKitTypes.readableTypes.compactMap{$0})
    ) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            requestAuthorization(toShare: typesToShare, read: typesToRead) {
                result in
                continuation.resume(with: result)
            }
        }
    }

    // MARK: Save Methods

    /// Saves a single HealthKit sample after filtering out duplicates.
    ///
    /// - Parameters:
    ///   - sample: The HKSample to save.
    ///   - completion: A completion handler that returns a `Result` with a Boolean indicating save success or an `Error`.
    public func save(
        _ sample: HKSample,
        completion: @escaping @Sendable (Result<Bool, Error>) -> Void
    ) {
        filterDuplicates([sample]) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let uniqueSamples):
                guard !uniqueSamples.isEmpty else {
                    completion(.success(true))  // Sample already exists
                    return
                }

                healthStore.save(uniqueSamples[0]) { success, error in
                    self.queue.async {
                        if let error {
                            completion(
                                .failure(
                                    HealthKitError.saveFailed(
                                        error.localizedDescription)))
                        } else {
                            completion(.success(success))
                        }
                    }
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Saves multiple HealthKit samples after filtering out duplicates.
    ///
    /// - Parameters:
    ///   - samples: An array of HKSample objects to save.
    ///   - completion: A completion handler that returns a `Result` with a Boolean indicating save success or an `Error`.
    public func saveBatch(
        _ samples: [HKSample],
        completion: @escaping @Sendable (Result<Bool, Error>) -> Void
    ) {
        guard !samples.isEmpty else {
            completion(.success(true))
            return
        }

        filterDuplicates(samples) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let uniqueSamples):
                guard !uniqueSamples.isEmpty else {
                    completion(.success(true))  // All samples already exist
                    return
                }

                healthStore.save(uniqueSamples) { success, error in
                    self.queue.async {
                        if let error {
                            completion(
                                .failure(
                                    HealthKitError.saveFailed(
                                        error.localizedDescription)))
                        } else {
                            completion(.success(success))
                        }
                    }
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Async version of `save(_ sample:completion:)`.
    ///
    /// - Parameter sample: The HKSample to save.
    /// - Returns: A Boolean value indicating whether the save was successful.
    /// - Throws: An error of type `HealthKitError` if the save fails.
    public func save(_ sample: HKSample) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            save(sample) { result in
                continuation.resume(with: result)
            }
        }
    }

    /// Async version of `saveBatch(_ samples:completion:)`.
    ///
    /// - Parameter samples: An array of HKSample objects to save.
    /// - Returns: A Boolean value indicating whether the save was successful.
    /// - Throws: An error of type `HealthKitError` if the save fails.
    public func saveBatch(_ samples: [HKSample]) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            saveBatch(samples) { result in
                continuation.resume(with: result)
            }
        }
    }

    // MARK: Read Methods

    /// Reads HealthKit samples for a given sample type with optional filtering.
    ///
    /// - Parameters:
    ///   - sampleType: The HKSampleType to read.
    ///   - predicate: An optional NSPredicate to filter the samples. Defaults to nil.
    ///   - limit: The maximum number of samples to retrieve. Defaults to HKObjectQueryNoLimit.
    ///   - sortDescriptors: Optional sort descriptors to order the results. Defaults to nil.
    ///   - completion: A completion handler that returns a `Result` with an array of HKSample objects on success or an `Error` on failure.
    public func readSamples(
        ofType sampleType: HKSampleType,
        predicate: NSPredicate? = nil,
        limit: Int = HKObjectQueryNoLimit,
        sortDescriptors: [NSSortDescriptor]? = nil,
        completion: @escaping @Sendable (Result<[HKSample], Error>) -> Void
    ) {
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: limit,
            sortDescriptors: sortDescriptors
        ) { [weak self] _, samples, error in
            guard let self else {
                return
            }
            queue.async {
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(samples ?? []))
                }
            }
        }
        healthStore.execute(query)
    }

    /// Async version of `readSamples(ofType:predicate:limit:sortDescriptors:completion:)`.
    ///
    /// - Parameters:
    ///   - sampleType: The HKSampleType to read.
    ///   - predicate: An optional NSPredicate to filter the samples. Defaults to nil.
    ///   - limit: The maximum number of samples to retrieve. Defaults to HKObjectQueryNoLimit.
    ///   - sortDescriptors: Optional sort descriptors to order the results. Defaults to nil.
    /// - Returns: An array of HKSample objects.
    /// - Throws: An error if the query fails.
    public func readSamples(
        ofType sampleType: HKSampleType,
        predicate: NSPredicate? = nil,
        limit: Int = HKObjectQueryNoLimit,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) async throws -> [HKSample] {
        try await withCheckedThrowingContinuation { continuation in
            readSamples(
                ofType: sampleType, predicate: predicate, limit: limit,
                sortDescriptors: sortDescriptors
            ) { result in
                continuation.resume(with: result)
            }
        }
    }

    /// Checks if the app is authorized to access all specified HealthKit sample types.
    ///
    /// - **Parameter** types: A set of HKSampleType objects to check authorization for.
    /// - **Returns**: `true` if the app is authorized for all specified types, `false` otherwise.
    public func checkAuthorizationStatus(for types: Set<HKSampleType>) -> Bool {
        // First check if HealthKit is available
        guard HKHealthStore.isHealthDataAvailable() else {
            return false
        }

        // Check authorization status for all required types
        var array: [HKAuthorizationStatus] = []
        for type in types {
            let status = healthStore.authorizationStatus(for: type)
            array.append(status)
        }

        return array.allSatisfy { $0 == .sharingAuthorized }
    }

    /// Async version of `checkAuthorizationStatus(for:)`.
    ///
    /// - **Parameter** types: A set of HKSampleType objects to check authorization for.
    /// - **Returns**: `true` if the app is authorized for all specified types, `false` otherwise.
    /// - **Throws**: This function is marked as throwing for compatibility with async patterns, though it doesn't throw errors directly.
    public func checkAuthorizationStatus(for types: Set<HKSampleType>) async throws
        -> Bool
    {
        await withCheckedContinuation { continuation in
            continuation.resume(returning: checkAuthorizationStatus(for: types))
        }
    }

    // MARK: Private

    // MARK: - Private Properties

    /// The HealthKit store instance.
    private let healthStore = HKHealthStore()

    /// Dedicated queue for HealthKit operations.
    private let queue = DispatchQueue(
        label: "com.SRHealthkitManager.queue", qos: .userInitiated)

    /// Accumulates unique samples during duplicate filtering.
    private var uniqueSamples: [HKSample] = []

    /// Holds an error encountered during duplicate filtering.
    private var filterDuplicatesError: Error?

    private var typesToShare: Set<HKSampleType>?
    private var typesToRead: Set<HKObjectType>?

    // MARK: - Duplicate Check Methods

    /// Checks for the existence of HealthKit samples within a given time range.
    ///
    /// - Parameters:
    ///   - sampleType: The HKSampleType to check.
    ///   - startDate: The start date of the time range.
    ///   - endDate: The end date of the time range.
    ///   - completion: A completion handler that returns a `Result` with a Boolean indicating existence or an `Error`.
    private func checkExistingSamples(
        type sampleType: HKSampleType,
        start startDate: Date,
        end endDate: Date,
        completion: @escaping @Sendable (Result<Bool, Error>) -> Void
    ) {
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate)

        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: 1,
            sortDescriptors: nil
        ) { _, samples, error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(!(samples?.isEmpty ?? true)))
        }

        healthStore.execute(query)
    }

    /// Async version of `checkExistingSamples(type:start:end:completion:)`.
    ///
    /// - Parameters:
    ///   - sampleType: The HKSampleType to check.
    ///   - startDate: The start date of the time range.
    ///   - endDate: The end date of the time range.
    /// - Returns: A Boolean indicating whether a sample exists in the specified range.
    /// - Throws: An error if the query fails.
    private func checkExistingSamples(
        type sampleType: HKSampleType,
        start startDate: Date,
        end endDate: Date
    ) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            checkExistingSamples(
                type: sampleType, start: startDate, end: endDate
            ) { result in
                continuation.resume(with: result)
            }
        }
    }

    /// Filters duplicate HealthKit samples from an array.
    ///
    /// This function checks each sample within an expanded time window to determine if a duplicate already exists.
    ///
    /// - Parameters:
    ///   - samples: An array of HKSample objects to filter.
    ///   - completion: A completion handler that returns a `Result` with an array of unique HKSample objects or an `Error`.
    private func filterDuplicates(
        _ samples: [HKSample],
        completion: @escaping @Sendable (Result<[HKSample], Error>) -> Void
    ) {
        let group = DispatchGroup()

        for sample in samples {
            group.enter()

            let startDate = sample.startDate.addingTimeInterval(-1)
            let endDate = sample.endDate.addingTimeInterval(1)

            checkExistingSamples(
                type: sample.sampleType, start: startDate, end: endDate
            ) { result in
                // Synchronize mutations to uniqueSamples and filterDuplicatesError.
                self.queue.sync {
                    switch result {
                    case .success(let exists):
                        if !exists {
                            self.uniqueSamples.append(sample)
                        }

                    case .failure(let error):
                        self.filterDuplicatesError = error
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: queue) {
            // Ensure a safe read of our variables.
            self.queue.sync {
                if let error = self.filterDuplicatesError {
                    completion(.failure(error))
                } else {
                    completion(.success(self.uniqueSamples))
                }
            }
        }
    }

    /// Async version of `filterDuplicates(_ samples:completion:)`.
    ///
    /// - Parameter samples: An array of HKSample objects to filter.
    /// - Returns: An array of unique HKSample objects.
    /// - Throws: An error if the filtering fails.
    private func filterDuplicates(_ samples: [HKSample]) async throws
        -> [HKSample]
    {
        var uniqueSamples: [HKSample] = []

        for sample in samples {
            let startDate = sample.startDate.addingTimeInterval(-1)
            let endDate = sample.endDate.addingTimeInterval(1)

            let exists = try await checkExistingSamples(
                type: sample.sampleType,
                start: startDate,
                end: endDate)

            if !exists {
                uniqueSamples.append(sample)
            }
        }

        return uniqueSamples
    }
}
