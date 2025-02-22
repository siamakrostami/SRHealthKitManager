//
//  HealthKitError.swift
//  SRHealthKitManager
//
//  Created by Siamak on 2/22/25.
//

import Foundation

/// HealthKit related errors
public enum HealthKitError: LocalizedError, Sendable {
    case healthKitNotAvailable
    case unauthorizedForType(String)
    case saveFailed(String)
    case invalidData
    case dataNotAvailable

    // MARK: Public

    public var errorDescription: String? {
        switch self {
        case .healthKitNotAvailable:
            return "HealthKit is not available on this device"
        case .unauthorizedForType(let type):
            return "Unauthorized to access \(type)"
        case .saveFailed(let message):
            return "Failed to save health data: \(message)"
        case .invalidData:
            return "Invalid health data provided"
        case .dataNotAvailable:
            return "Required health data is not available"
        }
    }
}
