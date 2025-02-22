# SRHealthKitManager

A comprehensive Swift framework for simplifying HealthKit integration in iOS and macOS applications.

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2013.0%2B%20%7C%20macOS%2013.0%2B-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yourusername/SRHealthKitManager/blob/main/LICENSE)

## Overview

SRHealthKitManager is a powerful, easy-to-use Swift wrapper around Apple's HealthKit framework. It provides a clean, modern API with both callback and async/await support to simplify health data operations.

Key features include:
- Simplified authorization requests
- Easy reading and writing of health data
- Duplicate detection and filtering
- Comprehensive type definitions for all HealthKit data types
- Support for both callback-based and async/await patterns
- Thread-safe operations

## Requirements
- iOS 13.0+ / macOS 13.0+
- Swift 5.0+
- Xcode 13.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SRHealthKitManager.git", from: "1.0.0")
]
```

Or add the package in Xcode:
1. Go to File > Swift Packages > Add Package Dependency
2. Enter the repository URL: `https://github.com/yourusername/SRHealthKitManager.git`
3. Follow the prompts to complete the installation

## Usage

### Add HealthKit to your app

1. Enable HealthKit capability in your project:
   - Select your project in Xcode
   - Go to "Signing & Capabilities"
   - Click "+" and add "HealthKit"

2. Add privacy descriptions to your Info.plist:
```xml
<key>NSHealthShareUsageDescription</key>
<string>This app needs access to your health data to provide personalized insights.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>This app needs to save health data to track your progress.</string>
```

### Requesting Authorization

```swift
import SRHealthKitManager

// Using callbacks
HealthKitManager.shared.requestAuthorization { result in
    switch result {
    case .success(let success):
        print("Authorization success: \(success)")
    case .failure(let error):
        print("Authorization failed: \(error.localizedDescription)")
    }
}

// Using async/await
Task {
    do {
        let success = try await HealthKitManager.shared.requestAuthorization()
        print("Authorization success: \(success)")
    } catch {
        print("Authorization failed: \(error.localizedDescription)")
    }
}

// For specific types
let typesToRead: Set<HKObjectType> = [
    HealthKitTypes.heartRate,
    HealthKitTypes.stepCount
].compactMap { $0 }

let typesToWrite: Set<HKSampleType> = [
    HealthKitTypes.bodyMass
].compactMap { $0 }

Task {
    do {
        let success = try await HealthKitManager.shared.requestAuthorization(
            toShare: typesToWrite, 
            read: typesToRead
        )
        print("Specific authorization success: \(success)")
    } catch {
        print("Specific authorization failed: \(error.localizedDescription)")
    }
}
```

### Reading Data

```swift
// Using callbacks
HealthKitManager.shared.readSamples(
    ofType: HealthKitTypes.stepCount!,
    predicate: HKQuery.predicateForSamples(
        withStart: Date().addingTimeInterval(-86400),
        end: Date(),
        options: .strictStartDate
    )
) { result in
    switch result {
    case .success(let samples):
        for sample in samples {
            if let quantitySample = sample as? HKQuantitySample {
                let stepCount = quantitySample.quantity.doubleValue(for: HKUnit.count())
                print("Steps: \(stepCount)")
            }
        }
    case .failure(let error):
        print("Failed to read step count: \(error.localizedDescription)")
    }
}

// Using async/await
Task {
    do {
        let samples = try await HealthKitManager.shared.readSamples(
            ofType: HealthKitTypes.heartRate!,
            predicate: HKQuery.predicateForSamples(
                withStart: Date().addingTimeInterval(-86400),
                end: Date(),
                options: .strictStartDate
            ),
            sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
        )
        
        for sample in samples {
            if let quantitySample = sample as? HKQuantitySample {
                let heartRate = quantitySample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                print("Heart rate: \(heartRate) BPM")
            }
        }
    } catch {
        print("Failed to read heart rate: \(error.localizedDescription)")
    }
}
```

### Writing Data

```swift
// Create a step count sample
let stepCountType = HealthKitTypes.stepCount!
let stepCountQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: 1000)
let now = Date()
let stepCountSample = HKQuantitySample(
    type: stepCountType,
    quantity: stepCountQuantity,
    start: now.addingTimeInterval(-3600),
    end: now
)

// Using callbacks
HealthKitManager.shared.save(stepCountSample) { result in
    switch result {
    case .success(let success):
        print("Step count saved successfully: \(success)")
    case .failure(let error):
        print("Failed to save step count: \(error.localizedDescription)")
    }
}

// Using async/await
Task {
    do {
        let success = try await HealthKitManager.shared.save(stepCountSample)
        print("Step count saved successfully: \(success)")
    } catch {
        print("Failed to save step count: \(error.localizedDescription)")
    }
}

// Saving multiple samples
let samples = [stepCountSample, anotherSample, yetAnotherSample]

Task {
    do {
        let success = try await HealthKitManager.shared.saveBatch(samples)
        print("Samples saved successfully: \(success)")
    } catch {
        print("Failed to save samples: \(error.localizedDescription)")
    }
}
```

### Checking Authorization Status

```swift
let typesToCheck: Set<HKSampleType> = [
    HealthKitTypes.heartRate,
    HealthKitTypes.stepCount
].compactMap { $0 }

// Using direct call
let isAuthorized = HealthKitManager.shared.checkAuthorizationStatus(for: typesToCheck)
print("Is authorized: \(isAuthorized)")

// Using async/await
Task {
    let isAuthorized = try await HealthKitManager.shared.checkAuthorizationStatus(for: typesToCheck)
    print("Is authorized (async): \(isAuthorized)")
}
```

## Error Handling

SRHealthKitManager provides a dedicated `HealthKitError` enum for clear error handling:

```swift
public enum HealthKitError: LocalizedError, Sendable {
    case healthKitNotAvailable
    case unauthorizedForType(String)
    case saveFailed(String)
    case invalidData
    case dataNotAvailable
}
```

Example of handling errors:

```swift
Task {
    do {
        let samples = try await HealthKitManager.shared.readSamples(ofType: HealthKitTypes.heartRate!)
        // Process samples
    } catch let error as HealthKitError {
        switch error {
        case .healthKitNotAvailable:
            // HealthKit is not available on this device
            showAlert("HealthKit is not available on this device")
        case .unauthorizedForType(let type):
            // User hasn't authorized access to this type
            requestPermission(for: type)
        case .dataNotAvailable:
            // No data available
            showEmptyState()
        default:
            // Handle other errors
            print("Error: \(error.localizedDescription)")
        }
    } catch {
        // Handle other types of errors
        print("Unexpected error: \(error.localizedDescription)")
    }
}
```

## Advanced Usage

### Custom Predicates for Filtering Data

```swift
// Get samples from the last week
let calendar = Calendar.current
let now = Date()
let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: now)!

let predicate = HKQuery.predicateForSamples(
    withStart: oneWeekAgo,
    end: now,
    options: .strictStartDate
)

Task {
    do {
        let heartRateSamples = try await HealthKitManager.shared.readSamples(
            ofType: HealthKitTypes.heartRate!,
            predicate: predicate
        )
        // Process heart rate samples
    } catch {
        print("Error fetching heart rate data: \(error.localizedDescription)")
    }
}
```

### Working with Workouts

```swift
// Read workouts
let workoutType = HKObjectType.workoutType()
let predicate = HKQuery.predicateForWorkouts(with: .running)

Task {
    do {
        let workouts = try await HealthKitManager.shared.readSamples(
            ofType: workoutType,
            predicate: predicate
        ) as? [HKWorkout]
        
        for workout in workouts ?? [] {
            print("Workout: \(workout.workoutActivityType.name)")
            print("Duration: \(workout.duration) seconds")
            print("Energy burned: \(workout.totalEnergyBurned?.doubleValue(for: HKUnit.kilocalorie()) ?? 0) kcal")
        }
    } catch {
        print("Error fetching workouts: \(error.localizedDescription)")
    }
}
```

## Available HealthKit Types

SRHealthKitManager provides convenient access to all HealthKit data types through the `HealthKitTypes` struct. Some examples:

### Activity & Fitness
- `HealthKitTypes.activeEnergyBurned`
- `HealthKitTypes.stepCount`
- `HealthKitTypes.distanceWalkingRunning`
- `HealthKitTypes.flightsClimbed`

### Vital Signs
- `HealthKitTypes.heartRate`
- `HealthKitTypes.bloodPressureSystolic`
- `HealthKitTypes.bloodPressureDiastolic`
- `HealthKitTypes.respiratoryRate`
- `HealthKitTypes.oxygenSaturation`

### Body Measurements
- `HealthKitTypes.bodyMass`
- `HealthKitTypes.height`
- `HealthKitTypes.bodyFatPercentage`

### Sleep
- `HealthKitTypes.sleepAnalysis`

See `HealthKitTypes.swift` for the complete list of supported data types.

## Thread Safety

SRHealthKitManager uses a dedicated dispatch queue to ensure thread safety for all operations. You can safely call methods from any thread, including the main thread.

## License

SRHealthKitManager is available under the MIT license. See the LICENSE file for more info.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
