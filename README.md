# 🚀 SRHealthKitManager

A modern Swift framework that streamlines **HealthKit** integration in iOS and macOS applications.

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)  
[![Platform](https://img.shields.io/badge/platform-iOS%2013.0%2B%20%7C%20macOS%2013.0%2B-blue.svg)](https://developer.apple.com/ios/)  
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yourusername/SRHealthKitManager/blob/main/LICENSE)

---

## ✨ Overview

**SRHealthKitManager** is a lightweight, intuitive Swift wrapper around Apple's **HealthKit** framework. It simplifies complex HealthKit operations using **modern Swift APIs**, including `async/await` and completion handlers.

### 🔑 Key Features:
✅ **Effortless HealthKit Authorization** – Request permissions with a single function  
✅ **Seamless Data Management** – Read, write, and update HealthKit data effortlessly  
✅ **Duplicate Detection & Filtering** – Avoid redundant data entries  
✅ **Thread-Safe Operations** – Ensures data integrity and smooth performance  
✅ **Flexible API** – Supports both `async/await` and callback-based execution  

---

## ⚙️ Requirements
- 📱 iOS 13.0+ | 🖥️ macOS 13.0+
- 🛠️ Swift 5.0+
- 🏗️ Xcode 13.0+

---

## 📦 Installation

### 🚀 Swift Package Manager (SPM)
Add SRHealthKitManager to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SRHealthKitManager.git", from: "1.0.0")
]
```

Or install via Xcode:
1. **File** → **Swift Packages** → **Add Package Dependency**
2. Enter: `https://github.com/yourusername/SRHealthKitManager.git`
3. Complete installation 🎉

---

## 🛠️ Setup & Configuration

### 📌 Enable HealthKit in Xcode
1. Open your project settings in Xcode  
2. Go to **Signing & Capabilities**  
3. Click **+ Capability** → Select **HealthKit**  

### 🔐 Add Privacy Descriptions in `Info.plist`
```xml
<key>NSHealthShareUsageDescription</key>
<string>This app needs access to your health data to provide personalized insights.</string>

<key>NSHealthUpdateUsageDescription</key>
<string>This app needs to save health data to track your progress.</string>
```

---

## 🚀 Usage

### 🏥 Requesting Authorization

#### ✅ Using Callbacks
```swift
import SRHealthKitManager

HealthKitManager.shared.requestAuthorization { result in
    switch result {
    case .success(let success):
        print("Authorization success: \(success)")
    case .failure(let error):
        print("Authorization failed: \(error.localizedDescription)")
    }
}
```

#### ✅ Using `async/await`
```swift
Task {
    do {
        let success = try await HealthKitManager.shared.requestAuthorization()
        print("Authorization success: \(success)")
    } catch {
        print("Authorization failed: \(error.localizedDescription)")
    }
}
```

#### ✅ Requesting Authorization for Specific Types
```swift
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

---

### 📊 Reading Data

#### ✅ Using Callbacks
```swift
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
```

#### ✅ Using `async/await`
```swift
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

---

### ✍️ Writing Data

#### ✅ Writing Single Sample
```swift
let stepCountSample = HKQuantitySample(
    type: HealthKitTypes.stepCount!,
    quantity: HKQuantity(unit: HKUnit.count(), doubleValue: 1000),
    start: Date().addingTimeInterval(-3600),
    end: Date()
)

// Using async/await
Task {
    do {
        let success = try await HealthKitManager.shared.save(stepCountSample)
        print("Step count saved successfully: \(success)")
    } catch {
        print("Failed to save step count: \(error.localizedDescription)")
    }
}
```

#### ✅ Saving Multiple Samples
```swift
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

---

### 🔍 Checking Authorization Status

```swift
let typesToCheck: Set<HKSampleType> = [
    HealthKitTypes.heartRate,
    HealthKitTypes.stepCount
].compactMap { $0 }

Task {
    let isAuthorized = try await HealthKitManager.shared.checkAuthorizationStatus(for: typesToCheck)
    print("Is authorized (async): \(isAuthorized)")
}
```

---

## ❌ Error Handling

SRHealthKitManager defines clear, **Swift-native** error types:

```swift
public enum HealthKitError: LocalizedError, Sendable {
    case healthKitNotAvailable
    case unauthorizedForType(String)
    case saveFailed(String)
    case invalidData
    case dataNotAvailable
}
```

---

## 🏃‍♂️ Advanced Usage

### 🏋️‍♂️ Working with Workouts
```swift
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
        }
    } catch {
        print("Error fetching workouts: \(error.localizedDescription)")
    }
}
```

---

## 📜 License

SRHealthKitManager is available under the **MIT License**. See the `LICENSE` file for details.

---

## 🙌 Contributing

Contributions are welcome! Feel free to **submit a pull request** or **open an issue**. 🚀
