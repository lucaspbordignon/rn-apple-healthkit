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

        getBloodGlucoseSamples(options: GetBloodGlucoseOptions, callback: (error: string, result: Object) => void): void;

        saveBloodGlucoseSample(options: SaveBloodGlucoseOptions, callback: (error: string, result: Object) => void): void;
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

    export interface GetBloodGlucoseOptions {
        unit: HealthUnit;
        startDate: Date;
        endDate: Date;
        ascending: boolean;
        limit: Number;
    }

    export interface SaveBloodGlucoseOptions {
        unit: HealthUnit;
        value: Number,
        date: Date;
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
