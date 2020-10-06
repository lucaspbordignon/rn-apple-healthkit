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

        getBiologicalSex(options: any, callback: (error: Object, results: HealthBiologicalSex) => void): void;

        getLatestHeight(options: HealthUnitOptions, callback: (err: string, results: HealthValue) => void): void;

        getLatestWeight(options: HealthUnitOptions, callback: (err: string, results: HealthValue) => void): void;

        getMindfulSession(options: MindfulSessionData, callback: (err: string, results: HealthValue) => void): void;

        getStepCount(options: any, callback: (err: string, results: HealthValue) => void): void;

        getWeightSamples(options: HealthWeightOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getHeightSamples(options: HealthHeightOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getLatestBmi(options: null, callback: (err: string, results: HealthValue) => void): void;

        getDailyStepCountSamples(options: HealthStepCountOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getDailyFlightsClimbedSamples(options: HealthDailyFlightsClimbedOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getSleepSamples(options: HealthOptions, callback: (err: string, results: HealthSleepValue[]) => void): void;

        getActiveEnergyBurned(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getBasalEnergyBurned(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getAppleStandTime(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getBodyTemperatureSamples(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getBloodPressureSamples(options: HealthOptions, callback: (err: string, results: HealthBloodPressureValue[]) => void): void;

        getMenstrualFlowSamples(options: HealthOptions, callback: (err: string, results: HealthMenstrualFlowValue[]) => void): void;

        getLastMenstruationDate(options: any, callback: (err: string, results: HealthLastMenstruationDate) => void): void;

        getInhalerUsageSamples(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getRestingHeartRateSamples(options: HealthHeartRateOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getHeartRateSamples(options: HealthHeartRateOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getHeartRateVariabilitySDNNSamples(options: HealthOptions, callback: (err: string, results: HealthValue[]) => void): void;

        getBodyFatPercentageSamples(options: BodyFatPercentageOptions, callback: (err: string, results: HealthValue[]) => void): void;
    }

    export interface HealthDateOfBirth {
        value: string;
        age: number;
    }

    export interface HealthLastMenstruationDate {
        startDate: string;
    }

    export interface HealthBiologicalSex {
        value: 'unknown' | 'female' | 'male' | 'other';
    }

    export interface HealthValue {
        value: number;
        startDate: string;
        endDate: string;
    }

    export interface HealthSleepValue {
        value: 'ASLEEP' | 'INBED';
        startDate: string;
        endDate: string;
    }

    export interface HealthBloodPressureValue {
        bloodPressureSystolicValue: number;
        bloodPressureDiastolicValue: number;
        startDate: string;
        endDate: string;
    }

    export interface HealthMenstrualFlowValue {
        startDate: string;
        endDate: string;
        startOfCycle: boolean;
        value: 'NONE' | 'UNSPECIFIED' | 'LIGHT' | 'MEDIUM' | 'HEAVY';
    }

    export interface HealthOptions {
        startDate: string;
        endDate?: string;
        limit?: number;
    }

    export interface HealthUnitOptions {
        unit: HealthUnit;
    }

    export interface HealthWeightOptions extends HealthOptions {
        unit?: 'pound';
        ascending?: boolean;
    }

    export interface HealthHeightOptions extends HealthOptions {
        unit?: 'inch';
        ascending?: boolean;
    }

    export interface HealthStepCountOptions extends HealthOptions {
        includeManuallyAdded: boolean;
    }

    export interface HealthHeartRateOptions extends HealthOptions {
        unit?: 'bpm';
        ascending?: boolean;
    }

    export interface BodyFatPercentageOptions extends HealthOptions {
        ascending?: boolean;
    }

    export interface HealthDailyFlightsClimbedOptions extends HealthOptions {
        includeManuallyAdded?: boolean;
        ascending?: boolean;
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
