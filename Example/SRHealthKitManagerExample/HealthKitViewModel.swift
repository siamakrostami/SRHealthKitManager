//
//  HealthKitViewModel.swift
//  SRHealthKitManagerExample
//
//  Created by Siamak Rostami on 2/22/25.
//

import HealthKit
import SRHealthKitManager
import SwiftUI

/// HealthKitViewModel.swift
@MainActor
class HealthKitViewModel: ObservableObject {
    // MARK: Internal

    @Published var isAuthorized = false
    @Published var stepCount: Double = 0
    @Published var heartRate: Double = 0
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var saveSuccessfulMessage: String?
    @Published var showSuccess = false

    func requestAuthorization() async {
        do {
            let typesToRead: Set<HKObjectType> = Set([
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                HKObjectType.workoutType(),
            ])

            let typesToWrite: Set<HKSampleType> = Set([
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.workoutType(),
            ])

            isAuthorized = try await healthKitManager.requestAuthorization(
                toShare: typesToWrite,
                read: typesToRead
            )

            if isAuthorized {
                await fetchStepCount()
                await fetchHeartRate()
            }
        } catch {
            showError(message: error.localizedDescription)
        }
    }

    func fetchStepCount() async {
        do {
            let calendar = Calendar.current
            let now = Date()
            let startOfDay = calendar.startOfDay(for: now)

            let predicate = HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )
            
            
            let samples = try await healthKitManager.readSamples(
                ofType: HealthKitTypes.stepCount!,
                predicate: predicate
            )

            let totalSteps = samples.reduce(0.0) { sum, sample in
                if let steps = sample as? HKQuantitySample {
                    return sum + steps.quantity.doubleValue(for: .count())
                }
                return sum
            }
            stepCount = totalSteps
        } catch {
            showError(message: error.localizedDescription)
        }
    }

    func fetchHeartRate() async {
        do {
            let calendar = Calendar.current
            let now = Date()
            let startOfDay = calendar.startOfDay(for: now)

            let predicate = HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )

            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierEndDate,
                ascending: false
            )

            let samples = try await healthKitManager.readSamples(
                ofType: HealthKitTypes.heartRate!,
                predicate: predicate,
                limit: 1,
                sortDescriptors: [sortDescriptor]
            )

            if let sample = samples.first as? HKQuantitySample {
                heartRate = sample.quantity.doubleValue(
                    for: HKUnit.count().unitDivided(by: .minute())
                )
            }
        } catch {
            showError(message: error.localizedDescription)
        }
    }

    func addTestSteps() async {
        do {
            let stepCountType = HealthKitTypes.stepCount!
            let stepCountQuantity = HKQuantity(unit: .count(), doubleValue: 100)
            let now = Date()

            let stepCountSample = HKQuantitySample(
                type: stepCountType,
                quantity: stepCountQuantity,
                start: now.addingTimeInterval(-60),
                end: now
            )

            let success = try await healthKitManager.save(stepCountSample)
            if success {
                await fetchStepCount()
            }
        } catch {
            showError(message: error.localizedDescription)
        }
    }

    func saveTestWorkout() async {
        do {
            let workoutConfiguration = HKWorkoutConfiguration()
            workoutConfiguration.activityType = .running
            workoutConfiguration.locationType = .outdoor

            let now = Date()
            let startDate = now.addingTimeInterval(-3600)  // 1 hour ago

            let workout = HKWorkout(
                activityType: .running,
                start: startDate,
                end: now,
                duration: 3600,
                totalEnergyBurned: HKQuantity(
                    unit: .kilocalorie(), doubleValue: 400),
                totalDistance: HKQuantity(unit: .meter(), doubleValue: 5000),
                metadata: [HKMetadataKeyIndoorWorkout: false]
            )

            let success = try await healthKitManager.save(workout)
            if success {
                showSuccess(message: "Workout saved successfully!")
            }
        } catch {
            showError(message: error.localizedDescription)
        }
    }

    // MARK: Private

    private let healthKitManager = HealthKitManager.shared

    private func showError(message: String) {
        errorMessage = message
        showError = true
    }

    private func showSuccess(message: String) {
        saveSuccessfulMessage = message
        showSuccess = true
    }
}
