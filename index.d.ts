declare module "rn-apple-healthkit" {
  export interface HealthKitPermissions {
    permissions: {
      read: string[];
      write: string[];
    };
  }
  export interface MindfulSessionData {
    startDate?: Date;
    endDate?: Date;
    limit?: number;
  }

  export interface AppleHealthKit {
    initHealthKit(
      permissions: HealthKitPermissions,
      callback: (error: string, result: Object) => void
    ): void;

    initStepCountObserver(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    getBiologicalSex(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    getDateOfBirth(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    getWeightSamples(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    saveWeight(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    getHeightSamples(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    getLatestBmi(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    saveBmi(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    saveFood(
      options: Object,
      callback: (error: string, result: Object) => void
    ): void;

    isAvailable(callback: (error: Object, results: boolean) => void): void;

    getDateOfBirth(
      options: any,
      callback: (error: Object, results: HealthDateOfBirth) => void
    ): void;

    getLatestHeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void
    ): void;

    getLatestWeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void
    ): void;

    getMindfulSession(
      options: MindfulSessionData,
      callback: (err: string, results: HealthValue) => void
    ): void;

    getStepCount(
      options: any,
      callback: (err: string, results: HealthValue) => void
    ): void;

    Constants: {
      Permissions: Permissions;
      Units: HealthUnit;
    };
  }

  export interface HealthDateOfBirth {
    value: string;
    age: number;
  }

  export interface HealthValue {
    value: number;
    startDate: string;
    endDate: string;
  }

  export interface HealthUnitOptions {
    unit: HealthUnit;
  }

  export enum Permissions {
    ActiveEnergyBurned = "ActiveEnergyBurned",
    AppleExerciseTime = "AppleExerciseTime",
    BasalEnergyBurned = "BasalEnergyBurned",
    BiologicalSex = "BiologicalSex",
    BloodGlucose = "BloodGlucose",
    BloodPressureDiastolic = "BloodPressureDiastolic",
    BloodPressureSystolic = "BloodPressureSystolic",
    BodyFatPercentage = "BodyFatPercentage",
    BodyMass = "BodyMass",
    BodyMassIndex = "BodyMassIndex",
    BodyTemperature = "BodyTemperature",
    DateOfBirth = "DateOfBirth",
    Biotin = "Biotin",
    Caffeine = "Caffeine",
    Calcium = "Calcium",
    Carbohydrates = "Carbohydrates",
    Chloride = "Chloride",
    Cholesterol = "Cholesterol",
    Copper = "Copper",
    EnergyConsumed = "EnergyConsumed",
    FatMonounsaturated = "FatMonounsaturated",
    FatPolyunsaturated = "FatPolyunsaturated",
    FatSaturated = "FatSaturated",
    FatTotal = "FatTotal",
    Fiber = "Fiber",
    Folate = "Folate",
    Iodine = "Iodine",
    Iron = "Iron",
    Magnesium = "Magnesium",
    Manganese = "Manganese",
    Molybdenum = "Molybdenum",
    Niacin = "Niacin",
    PantothenicAcid = "PantothenicAcid",
    Phosphorus = "Phosphorus",
    Potassium = "Potassium",
    Protein = "Protein",
    Riboflavin = "Riboflavin",
    Selenium = "Selenium",
    Sodium = "Sodium",
    Sugar = "Sugar",
    Thiamin = "Thiamin",
    VitaminA = "VitaminA",
    VitaminB12 = "VitaminB12",
    VitaminB6 = "VitaminB6",
    VitaminC = "VitaminC",
    VitaminD = "VitaminD",
    VitaminE = "VitaminE",
    VitaminK = "VitaminK",
    Zinc = "Zinc",
    Water = "Water",
    DistanceCycling = "DistanceCycling",
    DistanceSwimming = "DistanceSwimming",
    DistanceWalkingRunning = "DistanceWalkingRunning",
    FlightsClimbed = "FlightsClimbed",
    HeartRate = "HeartRate",
    Height = "Height",
    LeanBodyMass = "LeanBodyMass",
    MindfulSession = "MindfulSession",
    NikeFuel = "NikeFuel",
    RespiratoryRate = "RespiratoryRate",
    SleepAnalysis = "SleepAnalysis",
    StepCount = "StepCount",
    Steps = "Steps",
    Weight = "Weight",
    Workout = "Workout"
  }

  export enum HealthUnit {
    bpm = "bpm",
    calorie = "calorie",
    celsius = "celsius",
    count = "count",
    day = "day",
    fahrenheit = "fahrenheit",
    foot = "foot",
    gram = "gram",
    hour = "hour",
    inch = "inch",
    joule = "joule",
    meter = "meter",
    mgPerdL = "mgPerdL",
    mile = "mile",
    minute = "minute",
    mmhg = "mmhg",
    mmolPerL = "mmolPerL",
    percent = "percent",
    pound = "pound",
    second = "second"
  }

  const appleHealthKit: AppleHealthKit;
  export default appleHealthKit;
}
