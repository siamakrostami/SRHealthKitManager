//
//  HealthKitTypes.swift
//  SRHealthKitManager
//
//  Created by Siamak on 2/22/25.
//

import HealthKit

public struct HealthKitTypes: Sendable {
    // MARK: - Quantity Types

    /// Activity & Fitness
    public static let activeEnergyBurned = HKQuantityType.quantityType(
        forIdentifier: .activeEnergyBurned)
    public static let basalEnergyBurned = HKQuantityType.quantityType(
        forIdentifier: .basalEnergyBurned)
    public static let appleExerciseTime = HKQuantityType.quantityType(
        forIdentifier: .appleExerciseTime)
    public static let appleStandTime = HKQuantityType.quantityType(
        forIdentifier: .appleStandTime)
    public static let distanceWalkingRunning = HKQuantityType.quantityType(
        forIdentifier: .distanceWalkingRunning)
    public static let distanceCycling = HKQuantityType.quantityType(
        forIdentifier: .distanceCycling)
    public static let distanceSwimming = HKQuantityType.quantityType(
        forIdentifier: .distanceSwimming)
    public static let distanceDownhillSnowSports = HKQuantityType.quantityType(
        forIdentifier: .distanceDownhillSnowSports)
    public static let distanceWheelchair = HKQuantityType.quantityType(
        forIdentifier: .distanceWheelchair)
    @available(iOS 16.0, *)
    public static let runningStrideLength = HKQuantityType.quantityType(
        forIdentifier: .runningStrideLength)
    @available(iOS 16.0, *)
    public static let runningVerticalOscillation = HKQuantityType.quantityType(
        forIdentifier: .runningVerticalOscillation)
    @available(iOS 16.0, *)
    public static let runningGroundContactTime = HKQuantityType.quantityType(
        forIdentifier: .runningGroundContactTime)
    @available(iOS 16.0, *)
    public static let runningPower = HKQuantityType.quantityType(
        forIdentifier: .runningPower)
    @available(iOS 16.0, *)
    public static let runningSpeed = HKQuantityType.quantityType(
        forIdentifier: .runningSpeed)
    public static let stepCount = HKQuantityType.quantityType(
        forIdentifier: .stepCount)
    public static let flightsClimbed = HKQuantityType.quantityType(
        forIdentifier: .flightsClimbed)
    public static let nikeFuel = HKQuantityType.quantityType(
        forIdentifier: .nikeFuel)
    public static let pushCount = HKQuantityType.quantityType(
        forIdentifier: .pushCount)
    public static let swimmingStrokeCount = HKQuantityType.quantityType(
        forIdentifier: .swimmingStrokeCount)
    @available(iOS 14.0, *)
    public static let walkingSpeed = HKQuantityType.quantityType(
        forIdentifier: .walkingSpeed)
    @available(iOS 14.0, *)
    public static let walkingStepLength = HKQuantityType.quantityType(
        forIdentifier: .walkingStepLength)
    @available(iOS 14.0, *)
    public static let walkingAsymmetryPercentage = HKQuantityType.quantityType(
        forIdentifier: .walkingAsymmetryPercentage)
    @available(iOS 14.0, *)
    public static let walkingDoubleSupportPercentage =
        HKQuantityType.quantityType(
            forIdentifier: .walkingDoubleSupportPercentage)
    @available(iOS 14.0, *)
    public static let sixMinuteWalkTestDistance = HKQuantityType.quantityType(
        forIdentifier: .sixMinuteWalkTestDistance)
    @available(iOS 14.0, *)
    public static let stairAscentSpeed = HKQuantityType.quantityType(
        forIdentifier: .stairAscentSpeed)
    @available(iOS 14.0, *)
    public static let stairDescentSpeed = HKQuantityType.quantityType(
        forIdentifier: .stairDescentSpeed)
    @available(iOS 14.5, *)
    public static let appleMoveTime = HKQuantityType.quantityType(
        forIdentifier: .appleMoveTime)

    /// Vital Signs
    public static let heartRate = HKQuantityType.quantityType(
        forIdentifier: .heartRate)
    public static let heartRateVariabilitySDNN = HKQuantityType.quantityType(
        forIdentifier: .heartRateVariabilitySDNN)
    public static let restingHeartRate = HKQuantityType.quantityType(
        forIdentifier: .restingHeartRate)
    public static let walkingHeartRateAverage = HKQuantityType.quantityType(
        forIdentifier: .walkingHeartRateAverage)
    @available(iOS 16.0, *)
    public static let heartRateRecoveryOneMinute = HKQuantityType.quantityType(
        forIdentifier: .heartRateRecoveryOneMinute)
    public static let bloodPressureSystolic = HKQuantityType.quantityType(
        forIdentifier: .bloodPressureSystolic)
    public static let bloodPressureDiastolic = HKQuantityType.quantityType(
        forIdentifier: .bloodPressureDiastolic)
    public static let bodyTemperature = HKQuantityType.quantityType(
        forIdentifier: .bodyTemperature)
    public static let basalBodyTemperature = HKQuantityType.quantityType(
        forIdentifier: .basalBodyTemperature)
    public static let oxygenSaturation = HKQuantityType.quantityType(
        forIdentifier: .oxygenSaturation)
    public static let respiratoryRate = HKQuantityType.quantityType(
        forIdentifier: .respiratoryRate)
    public static let peripheralPerfusionIndex = HKQuantityType.quantityType(
        forIdentifier: .peripheralPerfusionIndex)
    public static let vo2Max = HKQuantityType.quantityType(
        forIdentifier: .vo2Max)
    public static let forcedExpiratoryVolume1 = HKQuantityType.quantityType(
        forIdentifier: .forcedExpiratoryVolume1)
    public static let forcedVitalCapacity = HKQuantityType.quantityType(
        forIdentifier: .forcedVitalCapacity)
    public static let peakExpiratoryFlowRate = HKQuantityType.quantityType(
        forIdentifier: .peakExpiratoryFlowRate)
    public static let environmentalAudioExposure = HKQuantityType.quantityType(
        forIdentifier: .environmentalAudioExposure)

    /// Body Measurements
    public static let bodyMass = HKQuantityType.quantityType(
        forIdentifier: .bodyMass)
    public static let bodyMassIndex = HKQuantityType.quantityType(
        forIdentifier: .bodyMassIndex)
    public static let height = HKQuantityType.quantityType(
        forIdentifier: .height)
    public static let leanBodyMass = HKQuantityType.quantityType(
        forIdentifier: .leanBodyMass)
    public static let bodyFatPercentage = HKQuantityType.quantityType(
        forIdentifier: .bodyFatPercentage)
    public static let waistCircumference = HKQuantityType.quantityType(
        forIdentifier: .waistCircumference)
    @available(iOS 15.0, *)
    public static let appleWalkingSteadiness = HKQuantityType.quantityType(
        forIdentifier: .appleWalkingSteadiness)

    /// Nutrition
    public static let dietaryEnergyConsumed = HKQuantityType.quantityType(
        forIdentifier: .dietaryEnergyConsumed)
    public static let dietaryFatTotal = HKQuantityType.quantityType(
        forIdentifier: .dietaryFatTotal)
    public static let dietaryFatSaturated = HKQuantityType.quantityType(
        forIdentifier: .dietaryFatSaturated)
    public static let dietaryFatMonounsaturated = HKQuantityType.quantityType(
        forIdentifier: .dietaryFatMonounsaturated)
    public static let dietaryFatPolyunsaturated = HKQuantityType.quantityType(
        forIdentifier: .dietaryFatPolyunsaturated)
    public static let dietaryCholesterol = HKQuantityType.quantityType(
        forIdentifier: .dietaryCholesterol)
    public static let dietarySodium = HKQuantityType.quantityType(
        forIdentifier: .dietarySodium)
    public static let dietaryCarbohydrates = HKQuantityType.quantityType(
        forIdentifier: .dietaryCarbohydrates)
    public static let dietaryFiber = HKQuantityType.quantityType(
        forIdentifier: .dietaryFiber)
    public static let dietarySugar = HKQuantityType.quantityType(
        forIdentifier: .dietarySugar)
    public static let dietaryProtein = HKQuantityType.quantityType(
        forIdentifier: .dietaryProtein)
    public static let dietaryVitaminA = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminA)
    public static let dietaryVitaminB6 = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminB6)
    public static let dietaryVitaminB12 = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminB12)
    public static let dietaryVitaminC = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminC)
    public static let dietaryVitaminD = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminD)
    public static let dietaryVitaminE = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminE)
    public static let dietaryVitaminK = HKQuantityType.quantityType(
        forIdentifier: .dietaryVitaminK)
    public static let dietaryCalcium = HKQuantityType.quantityType(
        forIdentifier: .dietaryCalcium)
    public static let dietaryIron = HKQuantityType.quantityType(
        forIdentifier: .dietaryIron)
    public static let dietaryThiamin = HKQuantityType.quantityType(
        forIdentifier: .dietaryThiamin)
    public static let dietaryRiboflavin = HKQuantityType.quantityType(
        forIdentifier: .dietaryRiboflavin)
    public static let dietaryNiacin = HKQuantityType.quantityType(
        forIdentifier: .dietaryNiacin)
    public static let dietaryFolate = HKQuantityType.quantityType(
        forIdentifier: .dietaryFolate)
    public static let dietaryBiotin = HKQuantityType.quantityType(
        forIdentifier: .dietaryBiotin)
    public static let dietaryPantothenicAcid = HKQuantityType.quantityType(
        forIdentifier: .dietaryPantothenicAcid)
    public static let dietaryPhosphorus = HKQuantityType.quantityType(
        forIdentifier: .dietaryPhosphorus)
    public static let dietaryIodine = HKQuantityType.quantityType(
        forIdentifier: .dietaryIodine)
    public static let dietaryMagnesium = HKQuantityType.quantityType(
        forIdentifier: .dietaryMagnesium)
    public static let dietaryZinc = HKQuantityType.quantityType(
        forIdentifier: .dietaryZinc)
    public static let dietarySelenium = HKQuantityType.quantityType(
        forIdentifier: .dietarySelenium)
    public static let dietaryCopper = HKQuantityType.quantityType(
        forIdentifier: .dietaryCopper)
    public static let dietaryManganese = HKQuantityType.quantityType(
        forIdentifier: .dietaryManganese)
    public static let dietaryChromium = HKQuantityType.quantityType(
        forIdentifier: .dietaryChromium)
    public static let dietaryMolybdenum = HKQuantityType.quantityType(
        forIdentifier: .dietaryMolybdenum)
    public static let dietaryChloride = HKQuantityType.quantityType(
        forIdentifier: .dietaryChloride)
    public static let dietaryPotassium = HKQuantityType.quantityType(
        forIdentifier: .dietaryPotassium)
    public static let dietaryCaffeine = HKQuantityType.quantityType(
        forIdentifier: .dietaryCaffeine)
    public static let dietaryWater = HKQuantityType.quantityType(
        forIdentifier: .dietaryWater)

    /// Lab and Test Results
    public static let bloodGlucose = HKQuantityType.quantityType(
        forIdentifier: .bloodGlucose)
    public static let bloodAlcoholContent = HKQuantityType.quantityType(
        forIdentifier: .bloodAlcoholContent)
    public static let insulin = HKQuantityType.quantityType(
        forIdentifier: .insulinDelivery)
    public static let numberOfTimesFallen = HKQuantityType.quantityType(
        forIdentifier: .numberOfTimesFallen)
    public static let electrodermalActivity = HKQuantityType.quantityType(
        forIdentifier: .electrodermalActivity)
    public static let inhalerUsage = HKQuantityType.quantityType(
        forIdentifier: .inhalerUsage)
    public static let insulinDelivery = HKQuantityType.quantityType(
        forIdentifier: .insulinDelivery)
    @available(iOS 15.0, *)
    public static let numberOfAlcoholicBeverages = HKQuantityType.quantityType(
        forIdentifier: .numberOfAlcoholicBeverages)
    public static let uvExposure = HKQuantityType.quantityType(
        forIdentifier: .uvExposure)
    @available(iOS 16.0, *)
    public static let waterTemperature = HKQuantityType.quantityType(
        forIdentifier: .waterTemperature)
    @available(iOS 16.0, *)
    public static let atrialFibrillationBurden = HKQuantityType.quantityType(
        forIdentifier: .atrialFibrillationBurden)
    public static let headphoneAudioExposure = HKQuantityType.quantityType(
        forIdentifier: .headphoneAudioExposure)

    /// Sleep
    public static let sleepAnalysis = HKCategoryType.categoryType(
        forIdentifier: .sleepAnalysis)

    /// Health Risk
    public static let appleWalkingHeartRateAverage =
        HKQuantityType.quantityType(forIdentifier: .walkingHeartRateAverage)
    public static let lowHeartRateEvent = HKCategoryType.categoryType(
        forIdentifier: .lowHeartRateEvent)
    public static let highHeartRateEvent = HKCategoryType.categoryType(
        forIdentifier: .highHeartRateEvent)
    public static let irregularHeartRhythmEvent = HKCategoryType.categoryType(
        forIdentifier: .irregularHeartRhythmEvent)

    // MARK: - Category Types

    public static let mindfulSession = HKCategoryType.categoryType(
        forIdentifier: .mindfulSession)
    public static let menstrualFlow = HKCategoryType.categoryType(
        forIdentifier: .menstrualFlow)
    public static let ovulationTestResult = HKCategoryType.categoryType(
        forIdentifier: .ovulationTestResult)
    public static let cervicalMucusQuality = HKCategoryType.categoryType(
        forIdentifier: .cervicalMucusQuality)
    public static let intermenstrualBleeding = HKCategoryType.categoryType(
        forIdentifier: .intermenstrualBleeding)
    public static let sexualActivity = HKCategoryType.categoryType(
        forIdentifier: .sexualActivity)
    public static let appleStandHour = HKCategoryType.categoryType(
        forIdentifier: .appleStandHour)
    public static let toothbrushingEvent = HKCategoryType.categoryType(
        forIdentifier: .toothbrushingEvent)
    @available(iOS 14.3, *)
    public static let pregnancy = HKCategoryType.categoryType(
        forIdentifier: .pregnancy)
    @available(iOS 14.3, *)
    public static let lactation = HKCategoryType.categoryType(
        forIdentifier: .lactation)
    @available(iOS 14.3, *)
    public static let contraceptive = HKCategoryType.categoryType(
        forIdentifier: .contraceptive)
    @available(iOS 14.0, *)
    public static let environmentalAudioExposureEvent =
        HKCategoryType.categoryType(
            forIdentifier: .environmentalAudioExposureEvent)
    @available(iOS 14.2, *)
    public static let headphoneAudioExposureEvent = HKCategoryType.categoryType(
        forIdentifier: .headphoneAudioExposureEvent)
    @available(iOS 14.0, *)
    public static let handwashingEvent = HKCategoryType.categoryType(
        forIdentifier: .handwashingEvent)
    @available(iOS 13.6, *)
    public static let appetiteChanges = HKCategoryType.categoryType(
        forIdentifier: .appetiteChanges)
    @available(iOS 13.6, *)
    public static let bloating = HKCategoryType.categoryType(
        forIdentifier: .bloating)
    @available(iOS 13.6, *)
    public static let breastPain = HKCategoryType.categoryType(
        forIdentifier: .breastPain)
    @available(iOS 13.6, *)
    public static let chestTightnessOrPain = HKCategoryType.categoryType(
        forIdentifier: .chestTightnessOrPain)
    @available(iOS 13.6, *)
    public static let chills = HKCategoryType.categoryType(
        forIdentifier: .chills)
    @available(iOS 13.6, *)
    public static let constipation = HKCategoryType.categoryType(
        forIdentifier: .constipation)
    @available(iOS 13.6, *)
    public static let coughing = HKCategoryType.categoryType(
        forIdentifier: .coughing)
    @available(iOS 13.6, *)
    public static let diarrhea = HKCategoryType.categoryType(
        forIdentifier: .diarrhea)
    @available(iOS 13.6, *)
    public static let dizziness = HKCategoryType.categoryType(
        forIdentifier: .dizziness)
    @available(iOS 14.0, *)
    public static let drySkin = HKCategoryType.categoryType(
        forIdentifier: .drySkin)
    @available(iOS 13.6, *)
    public static let fainting = HKCategoryType.categoryType(
        forIdentifier: .fainting)
    @available(iOS 13.6, *)
    public static let fatigue = HKCategoryType.categoryType(
        forIdentifier: .fatigue)
    @available(iOS 13.6, *)
    public static let fever = HKCategoryType.categoryType(forIdentifier: .fever)
    @available(iOS 13.6, *)
    public static let generalizedBodyAche = HKCategoryType.categoryType(
        forIdentifier: .generalizedBodyAche)
    @available(iOS 14.0, *)
    public static let hairLoss = HKCategoryType.categoryType(
        forIdentifier: .hairLoss)
    @available(iOS 13.6, *)
    public static let headache = HKCategoryType.categoryType(
        forIdentifier: .headache)
    @available(iOS 13.6, *)
    public static let heartburn = HKCategoryType.categoryType(
        forIdentifier: .heartburn)
    @available(iOS 13.6, *)
    public static let hotFlashes = HKCategoryType.categoryType(
        forIdentifier: .hotFlashes)
    @available(iOS 13.6, *)
    public static let lossOfSmell = HKCategoryType.categoryType(
        forIdentifier: .lossOfSmell)
    @available(iOS 13.6, *)
    public static let lossOfTaste = HKCategoryType.categoryType(
        forIdentifier: .lossOfTaste)
    @available(iOS 13.6, *)
    public static let lowerBackPain = HKCategoryType.categoryType(
        forIdentifier: .lowerBackPain)
    @available(iOS 14.0, *)
    public static let memoryLapse = HKCategoryType.categoryType(
        forIdentifier: .memoryLapse)
    @available(iOS 13.6, *)
    public static let moodChanges = HKCategoryType.categoryType(
        forIdentifier: .moodChanges)
    @available(iOS 13.6, *)
    public static let nausea = HKCategoryType.categoryType(
        forIdentifier: .nausea)
    @available(iOS 14.0, *)
    public static let nightSweats = HKCategoryType.categoryType(
        forIdentifier: .nightSweats)
    @available(iOS 13.6, *)
    public static let pelvicPain = HKCategoryType.categoryType(
        forIdentifier: .pelvicPain)
    @available(iOS 13.6, *)
    public static let rapidPoundingOrFlutteringHeartbeat =
        HKCategoryType.categoryType(
            forIdentifier: .rapidPoundingOrFlutteringHeartbeat)
    @available(iOS 13.6, *)
    public static let runnyNose = HKCategoryType.categoryType(
        forIdentifier: .runnyNose)
    @available(iOS 13.6, *)
    public static let shortnessOfBreath = HKCategoryType.categoryType(
        forIdentifier: .shortnessOfBreath)
    @available(iOS 13.6, *)
    public static let sinusCongestion = HKCategoryType.categoryType(
        forIdentifier: .sinusCongestion)
    @available(iOS 13.6, *)
    public static let skippedHeartbeat = HKCategoryType.categoryType(
        forIdentifier: .skippedHeartbeat)
    @available(iOS 13.6, *)
    public static let sleepChanges = HKCategoryType.categoryType(
        forIdentifier: .sleepChanges)
    @available(iOS 13.6, *)
    public static let soreThroat = HKCategoryType.categoryType(
        forIdentifier: .soreThroat)
    @available(iOS 14.0, *)
    public static let vaginalDryness = HKCategoryType.categoryType(
        forIdentifier: .vaginalDryness)
    @available(iOS 13.6, *)
    public static let vomiting = HKCategoryType.categoryType(
        forIdentifier: .vomiting)
    @available(iOS 13.6, *)
    public static let wheezing = HKCategoryType.categoryType(
        forIdentifier: .wheezing)
    @available(iOS 16.0, *)
    public static let persistentIntermenstrualBleeding =
        HKCategoryType.categoryType(
            forIdentifier: .persistentIntermenstrualBleeding)
    @available(iOS 13.6, *)
    public static let abdominalCramps = HKCategoryType.categoryType(
        forIdentifier: .abdominalCramps)
    @available(iOS 14.0, *)
    public static let bladderIncontinence = HKCategoryType.categoryType(
        forIdentifier: .bladderIncontinence)

    /// Mobility
    @available(iOS 15.0, *)
    public static let appleWalkingSteadinessEvent = HKCategoryType.categoryType(
        forIdentifier: .appleWalkingSteadinessEvent)

    // MARK: - Correlation Types

    public static let foodCorrelation = HKCorrelationType.correlationType(
        forIdentifier: .food)
    public static let bloodPressure = HKCorrelationType.correlationType(
        forIdentifier: .bloodPressure)

    // MARK: - Workout Type

    public static let workout = HKObjectType.workoutType()

    // MARK: - Activity Summary Type

    public static let activitySummary = HKObjectType.activitySummaryType()

    // MARK: - Clinical Types

    public static let allergyRecord = HKClinicalType.clinicalType(
        forIdentifier: .allergyRecord)
    public static let conditionRecord = HKClinicalType.clinicalType(
        forIdentifier: .conditionRecord)
    public static let immunizationRecord = HKClinicalType.clinicalType(
        forIdentifier: .immunizationRecord)
    public static let labResultRecord = HKClinicalType.clinicalType(
        forIdentifier: .labResultRecord)
    public static let medicationRecord = HKClinicalType.clinicalType(
        forIdentifier: .medicationRecord)
    public static let procedureRecord = HKClinicalType.clinicalType(
        forIdentifier: .procedureRecord)
    public static let vitalSignRecord = HKClinicalType.clinicalType(
        forIdentifier: .vitalSignRecord)
    @available(iOS 14.0, *)
    public static let coverageRecord = HKClinicalType.clinicalType(
        forIdentifier: .coverageRecord)

    // MARK: - Document Types

    public static let cdaDocument = HKDocumentType.documentType(
        forIdentifier: .CDA)

    // MARK: - Electrocardiogram

    @available(iOS 14.0, *)
    public static let electrocardiogram = HKObjectType.electrocardiogramType()

    // MARK: - Audio Records

    public static let audiogram = HKObjectType.audiogramSampleType()

    // MARK: - Vision Records

    @available(iOS 16.0, *)
    public static let vision = HKObjectType.visionPrescriptionType()

    // MARK: - Grouped Sets

    public static var quantityTypes: Set<HKQuantityType?> {
        var array: Set<HKQuantityType?> = [
            // Activity & Fitness
            activeEnergyBurned,
            basalEnergyBurned,
            appleExerciseTime,
            appleStandTime,
            distanceWalkingRunning,
            distanceCycling,
            distanceSwimming,
            distanceDownhillSnowSports,
            distanceWheelchair,
            stepCount,
            flightsClimbed,
            nikeFuel,
            pushCount,
            swimmingStrokeCount,

            // Vital Signs
            heartRate,
            heartRateVariabilitySDNN,
            restingHeartRate,
            walkingHeartRateAverage,
            bloodPressureSystolic,
            bloodPressureDiastolic,
            bodyTemperature,
            basalBodyTemperature,
            oxygenSaturation,
            respiratoryRate,
            peripheralPerfusionIndex,
            vo2Max,
            forcedExpiratoryVolume1,
            forcedVitalCapacity,
            peakExpiratoryFlowRate,
            environmentalAudioExposure,

            // Body Measurements
            bodyMass,
            bodyMassIndex,
            height,
            leanBodyMass,
            bodyFatPercentage,
            waistCircumference,

            // Nutrition
            dietaryEnergyConsumed,
            dietaryFatTotal,
            dietaryFatSaturated,
            dietaryFatMonounsaturated,
            dietaryFatPolyunsaturated,
            dietaryCholesterol,
            dietarySodium,
            dietaryCarbohydrates,
            dietaryFiber,
            dietarySugar,
            dietaryProtein,
            dietaryVitaminA,
            dietaryVitaminB6,
            dietaryVitaminB12,
            dietaryVitaminC,
            dietaryVitaminD,
            dietaryVitaminE,
            dietaryVitaminK,
            dietaryCalcium,
            dietaryIron,
            dietaryThiamin,
            dietaryRiboflavin,
            dietaryNiacin,
            dietaryFolate,
            dietaryBiotin,
            dietaryPantothenicAcid,
            dietaryPhosphorus,
            dietaryIodine,
            dietaryMagnesium,
            dietaryZinc,
            dietarySelenium,
            dietaryCopper,
            dietaryManganese,
            dietaryChromium,
            dietaryMolybdenum,
            dietaryChloride,
            dietaryPotassium,
            dietaryCaffeine,
            dietaryWater,

            // Lab and Test Results
            bloodGlucose,
            bloodAlcoholContent,
            insulin,
            numberOfTimesFallen,
            electrodermalActivity,
            inhalerUsage,
            insulinDelivery,

            uvExposure,

            headphoneAudioExposure,

            // Health Risk
            appleWalkingHeartRateAverage,
        ]

        if #available(iOS 16, *) {
            [
                heartRateRecoveryOneMinute,
                runningStrideLength,
                runningVerticalOscillation,
                runningGroundContactTime,
                runningPower,
                runningSpeed, waterTemperature,
                atrialFibrillationBurden,
            ].forEach {
                array.insert($0)
            }
        }
        if #available(iOS 14, *) {
            [
                walkingSpeed,
                walkingStepLength,
                walkingAsymmetryPercentage,
                walkingDoubleSupportPercentage,
                sixMinuteWalkTestDistance,
                stairAscentSpeed,
                stairDescentSpeed,
            ].forEach {
                array.insert($0)
            }
        }

        if #available(iOS 15, *) {
            for item in [appleWalkingSteadiness, numberOfAlcoholicBeverages] {
                array.insert(item)
            }
        }

        if #available(iOS 14.5, *) {
            for item in [appleMoveTime] {
                array.insert(item)
            }
        }

        return array
    }

    public static var categoryTypes: Set<HKCategoryType?> {
        var array: Set<HKCategoryType?> = [
            sleepAnalysis,
            mindfulSession,
            menstrualFlow,
            ovulationTestResult,
            cervicalMucusQuality,
            intermenstrualBleeding,
            sexualActivity,
            appleStandHour,
            toothbrushingEvent,
            lowHeartRateEvent,
            highHeartRateEvent,
            irregularHeartRhythmEvent,
        ]

        if #available(iOS 14.3, *) {
            [
                pregnancy,
                lactation,
                contraceptive,
                environmentalAudioExposureEvent,
                headphoneAudioExposureEvent,
                handwashingEvent,
                drySkin,
                memoryLapse,
                nightSweats,
                vaginalDryness,
                bladderIncontinence,
                hairLoss,
            ].forEach {
                array.insert($0)
            }
        }
        if #available(iOS 13.6, *) {
            [
                appetiteChanges,
                bloating,
                breastPain,
                chestTightnessOrPain,
                chills,
                constipation,
                coughing,
                diarrhea,
                dizziness, fainting,
                fatigue,
                fever,
                generalizedBodyAche,
                headache,
                heartburn,
                hotFlashes,
                lossOfSmell,
                lossOfTaste,
                lowerBackPain,
                moodChanges,
                nausea,
                pelvicPain,
                rapidPoundingOrFlutteringHeartbeat,
                runnyNose,
                shortnessOfBreath,
                sinusCongestion,
                skippedHeartbeat,
                sleepChanges,
                soreThroat,
                vomiting,
                wheezing,
                abdominalCramps,
            ].forEach {
                array.insert($0)
            }
        }

        if #available(iOS 15, *) {
            for item in [appleWalkingSteadinessEvent] {
                array.insert(item)
            }
        }

        if #available(iOS 16, *) {
            for item in [persistentIntermenstrualBleeding] {
                array.insert(item)
            }
        }

        return array
    }

    public static var correlationTypes: Set<HKCorrelationType?>? {
        [
            foodCorrelation,
            bloodPressure,
        ]
    }

    public static var clinicalTypes: Set<HKClinicalType?> {
        var array: Set<HKClinicalType?> = [
            allergyRecord,
            conditionRecord,
            immunizationRecord,
            labResultRecord,
            medicationRecord,
            procedureRecord,
            vitalSignRecord,
        ]

        if #available(iOS 14, *) {
            for item in [coverageRecord] {
                array.insert(item)
            }
        }
        return array
    }

    public static var documentTypes: Set<HKDocumentType?> {
        [cdaDocument]
    }

    /// All readable types (for requesting authorization)
    public static var readableTypes: Set<HKObjectType> {
        var types = Set<HKObjectType>()

        // Add quantity types
        types.formUnion(Set(quantityTypes.compactMap(\.self)))

        // Add category types
        types.formUnion(Set(categoryTypes.compactMap(\.self)))

        // Add correlation types
        types.formUnion(Set(correlationTypes?.compactMap(\.self) ?? []))

        // Add special types
        types.insert(workout)
        types.insert(activitySummary)
        if #available(iOS 14, *) {
            types.insert(electrocardiogram)
        }
        if #available(iOS 16, *) {
            types.insert(vision)
        }
        types.insert(audiogram)

        // Add clinical types
        types.formUnion(Set(clinicalTypes.compactMap(\.self)))

        // Add document types
        types.formUnion(Set(documentTypes.compactMap(\.self)))

        return types
    }

    /// All writable types (for requesting authorization)
    public static var writableTypes: Set<HKSampleType?> {
        var types = Set<HKSampleType>()

        // Add quantity types
        types.formUnion(Set(quantityTypes.compactMap(\.self)))

        // Add category types
        types.formUnion(Set(categoryTypes.compactMap(\.self)))

        // Add correlation types
        types.formUnion(Set(correlationTypes?.compactMap(\.self) ?? []))

        // Add workout
        types.insert(workout)

        return types
    }
}
