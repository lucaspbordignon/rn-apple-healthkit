type HealthKitPermissions =
    | 'ActiveEnergyBurned'
    | 'AppleExerciseTime'
    | 'BasalEnergyBurned'
    | 'BiologicalSex'
    | 'BloodGlucose'
    | 'BloodPressureDiastolic'
    | 'BloodPressureSystolic'
    | 'BodyFatPercentage'
    | 'BodyMass'
    | 'BodyMassIndex'
    | 'BodyTemperature'
    | 'DateOfBirth'
    | 'Biotin'
    | 'Caffeine'
    | 'Calcium'
    | 'Carbohydrates'
    | 'Chloride'
    | 'Cholesterol'
    | 'Copper'
    | 'EnergyConsumed'
    | 'FatMonounsaturated'
    | 'FatPolyunsaturated'
    | 'FatSaturated'
    | 'FatTotal'
    | 'Fiber'
    | 'Folate'
    | 'Iodine'
    | 'Iron'
    | 'Magnesium'
    | 'Manganese'
    | 'Molybdenum'
    | 'Niacin'
    | 'PantothenicAcid'
    | 'Phosphorus'
    | 'Potassium'
    | 'Protein'
    | 'Riboflavin'
    | 'Selenium'
    | 'Sodium'
    | 'Sugar'
    | 'Thiamin'
    | 'VitaminA'
    | 'VitaminB12'
    | 'VitaminB6'
    | 'VitaminC'
    | 'VitaminD'
    | 'VitaminE'
    | 'VitaminK'
    | 'Zinc'
    | 'Water'
    | 'DistanceCycling'
    | 'DistanceWalkingRunning'
    | 'FlightsClimbed'
    | 'HeartRate'
    | 'Height'
    | 'LeanBodyMass'
    | 'MindfulSession'
    | 'NikeFuel'
    | 'RespiratoryRate'
    | 'SleepAnalysis'
    | 'StepCount'
    | 'Steps'
    | 'Weight';

type WeightUnits = 'pound' | 'gram';

export interface InitHealthKitOptions {
    permissions: {
        read: HealthKitPermissions[];
        write: HealthKitPermissions[];
    };
}

declare class AppleHealthKit {
    public static initHealthKit(
        options: InitHealthKitOptions,
        callback: (error: Error | null, result?: boolean) => void
    ): void;
    public static getDateOfBirth(
        options: any,
        callback: (
            error: Error | null,
            result?: {value: string | null; age: number | null}
        ) => void
    ): void;
    public static getLatestWeight(
        options: {unit?: WeightUnits},
        callback: (
            error: Error | null,
            result?: {value: number; startDate: string; endDate: string}
        ) => void
    ): void;
    public static getWeightSamples(
        options: {
            unit?: WeightUnits;
            limit?: number;
            ascending?: boolean;
            startDate: string;
            endDate?: string;
        },
        callback: (
            error: Error | null,
            results?: {value: number; startDate: string; endDate: string}[]
        ) => void
    ): void;
}

export default AppleHealthKit;
