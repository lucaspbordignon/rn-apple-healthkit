declare module "rn-apple-healthkit" {
    export interface HealthKitPermissions {
        permissions: {
            read: string[];
            write: string[];
        };
    }
    export interface MindfulSessionData {
        startDate?: Date,
        endDate?: Date,
        limit?: number
    }

    export interface AppleHealthKit {
        initHealthKit(permissions: HealthKitPermissions, callback: (error: string, result: Object) => void): void;

        saveFood(options: Object, callback: (error: string, result: Object) => void): void;

        isAvailable(callback: (error: Object, results: boolean) => void): void;

        getDateOfBirth(options: any, callback: (error: Object, results: HealthDateOfBirth) => void): void;

        getLatestHeight(options: HealthUnitOptions, callback: (err: string, results: HealthValue) => void): void;

        getLatestWeight(options: HealthUnitOptions, callback: (err: string, results: HealthValue) => void): void;

        getMindfulSession(options: MindfulSessionData, callback: (err: string, results: HealthValue) => void): void;

        getStepCount(options: any, callback: (err: string, results: HealthValue) => void): void;
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
        second = "second",
        liter = "liter",
    }

    export enum Nutrition {
        biotin = 'Biotin',
        caffeine = 'Caffeine',
        calcium = 'Calcium',
        carbohydrates = 'Carbohydrates',
        chloride = 'Chloride',
        cholesterol = 'Cholesterol',
        copper = 'Copper',
        energyConsumed = 'EnergyConsumed',
        fatMonounsaturated = 'FatMonounsaturated',
        fatPolyunsaturated = 'FatPolyunsaturated',
        fatSaturated = 'FatSaturated',
        fatTotal = 'FatTotal',
        fiber = 'Fiber',
        folate = 'Folate',
        iodine = 'Iodine',
        iron = 'Iron',
        magnesium = 'Magnesium',
        manganese = 'Manganese',
        molybdenum = 'Molybdenum',
        niacin = 'Niacin',
        pantothenicAcid = 'PantothenicAcid',
        phosphorus = 'Phosphorus',
        potassium = 'Potassium',
        protein = 'Protein',
        riboflavin = 'Riboflavin',
        selenium = 'Selenium',
        sodium = 'Sodium',
        sugar = 'Sugar',
        thiamin = 'Thiamin',
        vitaminA = 'VitaminA',
        vitaminB12 = 'VitaminB12',
        vitaminB6 = 'VitaminB6',
        vitaminC = 'VitaminC',
        vitaminD = 'VitaminD',
        vitaminE = 'VitaminE',
        vitaminK = 'VitaminK',
        water = 'Water',
        zinc = 'Zinc',
    }

    const appleHealthKit: AppleHealthKit;
    export default appleHealthKit;
}
