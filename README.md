# React Native Apple Healthkit
A React Native bridge module for interacting with Apple Healthkit data. Checkout the DEMO app.(https://github.com/terrillo/rn-apple-healthkit/tree/master/Demo)

## Installation (React Native >=0.40)

Install the [rn-apple-healthkit] package from npm:

- Run `npm install rn-apple-healthkit --save`
- Run `react-native link rn-apple-healthkit`
- Run `cd ./ios && pod install`
- Update `./ios/<Project Name>/info.plist` in your React Native project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```
- Enable Healthkit in your application's `Capabilities`
![](https://i.imgur.com/eOCCCyv.png "Xcode Capabilities Section")
- Build and run

## Get Started
Initialize Healthkit. This will show the Healthkit permissions prompt for any read/write permissions set in the required `options` object.

Due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. The app user would have to go into the Apple Health app and grant the permission to your react-native app under *sources* tab.

For any data that is read from Healthkit the status/error is the same for both. This privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today).

For any data written to Healthkit an authorization error can be caught. If an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present.

If new read/write permissions are added to the options object then the app user will see the Healthkit permissions prompt with the new permissions to allow.

`initHealthKit` requires an options object with Healthkit permission settings

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

const PERMS = AppleHealthKit.Constants.Permissions;
const healthKitOptions = {
    permissions: {
        read:  [
            PERMS.Age,
            PERMS.Weight,
        ]
    }
};

AppleHealthKit.initHealthKit(healthKitOptions, (err, results) => {
    if (err) {
        console.log("error initializing Healthkit: ", err);
        return;
    }

    // Height Example
    AppleHealthKit.getDateOfBirth(null, (err, results) => {
      console.log(results)
    });

});
```

Height Example Response
```javascript
{
	value: '1986-09-01T00:00:00.000-0400',
	age: 29
}
```

## Wiki
  * [Installation](/docs/Install)
  * [Documentation](#documentation)
    * [Permissions](#supported-apple-permissions)
    * [Units](#units)
    * Base Methods
      * [isAvailable](/docs/isAvailable().md)
      * [initHealthKit](/docs/initHealthKit().md)
      * [authorizationStatusForType](/docs/authorizationStatusForType().md)
    * Realtime Methods
      * [initStepCountObserver](/docs/initStepCountObserver().md)
      * [setObserver](/docs/setObserver().md)
    * Read Methods
      * [getActiveEnergyBurned](/docs/getActiveEnergyBurned().md)
      * [getBasalEnergyBurned](/docs/getBasalEnergyBurned().md)
      * [getBiologicalSex](/docs/getBiologicalSex().md)
      * [getBloodGlucoseSamples](/docs/getBloodGlucoseSamples().md)
      * [getBloodPressureSamples](/docs/getBloodPressureSamples().md)
      * [getBodyTemperatureSamples](/docs/getBodyTemperatureSamples().md)
      * [getDailyDistanceCyclingSamples](/docs/getDailyDistanceCyclingSamples().md)
      * [getDailyDistanceWalkingRunningSamples](/docs/getDailyDistanceWalkingRunningSamples().md)
      * [getDailyFlightsClimbedSamples](/docs/getDailyFlightsClimbedSamples().md)
      * [getDailyStepCountSamples](/docs/getDailyStepCountSamples().md)
      * [getDateOfBirth](/docs/getDateOfBirth().md)
      * [getDistanceCycling](/docs/getDistanceCycling().md)
      * [getDistanceSwimming](/docs/getDistanceSwimming().md)
      * [getDistanceWalkingRunning](/docs/getDistanceWalkingRunning().md)
      * [getFlightsClimbed](/docs/getFlightsClimbed().md)
      * [getHeartRateSamples](/docs/getHeartRateSamples().md)
      * [getHeightSamples](/docs/getHeightSamples().md)
      * [getLatestBmi](/docs/getLatestBmi().md)
      * [getLatestBodyFatPercentage](/docs/getLatestBodyFatPercentage().md)
      * [getBodyFatPercentageSamples](/docs/getBodyFatPercentageSamples().md)
      * [getLatestHeight](/docs/getLatestHeight().md)
      * [getLatestLeanBodyMass](/docs/getLatestLeanBodyMass().md)
      * [getLeanBodyMassSamples](/docs/getLeanBodyMassSamples().md)
      * [getLatestWeight](/docs/getLatestWeight().md)
      * [getRespiratoryRateSamples](/docs/getRespiratoryRateSamples().md)
      * [getRestingHeartRate](/docs/getRestingHeartRate().md)
      * [getSleepSamples](/docs/getSleepSamples().md)
      * [getStepCount](/docs/getStepCount().md)
      * [getWeightSamples](/docs/getWeightSamples().md)
      * [getSamples](docs/getSamples().md)
      * [getMindfulSession](docs/getMindfulSession().md)
    * Write Methods
      * [saveBmi](/docs/saveBmi().md)
      * [saveHeight](/docs/saveHeight().md)
      * [saveMindfulSession](/docs/saveMindfulSession().md)
      * [saveWeight](/docs/saveWeight().md)
      * [saveSteps](/docs/saveSteps().md)
      * [saveBodyFatPercentage](/docs/saveBodyFatPercentage().md)
      * [saveLeanBodyMass](/docs/saveLeanBodyMass().md)
  * [References](#references)

## Supported Apple Permissions

The available Healthkit permissions to use with `initHealthKit`

| Permission             | Healthkit Identifier Type                                                                                                                                          | Read | Write |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|-------|
| ActiveEnergyBurned     | [HKQuantityTypeIdentifierActiveEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615771-activeenergyburned?language=objc)           | ✓    |       |
| BasalEnergyBurned      | [HKQuantityTypeIdentifierBasalEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615512-basalenergyburned?language=objc)           | ✓    |       |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)           | ✓    |       |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                         | ✓    |       |
| BloodPressureDiastolic | [HKQuantityTypeIdentifierBloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressurediastolic?language=objc) | ✓    | ✓     |
| BloodPressureSystolic  | [HKQuantityTypeIdentifierBloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressuresystolic?language=objc)   | ✓    | ✓     |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                       | ✓    | ✓     |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodytemperature?language=objc)                   | ✓    |       |
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)               | ✓    |       |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancecycling?language=objc)                   | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc)     | ✓    | ✓     |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                     | ✓    | ✓     |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheartrate?language=objc)                               | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheight?language=objc)                                     | ✓    | ✓     |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                         | ✓    | ✓     |
| MindfulSession         | [HKCategoryTypeIdentifierMindfulSession](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiermindfulsession?language=objc)                     |      |  ✓    |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)                   | ✓    |       |
| RestingHeartRate       | [HKQuantityTypeIdentifierRestingHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrestingheartrate?language=objc)                 | ✓    |       |
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/Healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                       | ✓    |       |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierstepcount?language=objc)                               | ✓    | ✓     |
| Steps                  | [HKQuantityTypeIdentifierSteps](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiersteps?language=objc)                                       | ✓    | ✓     |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymass?language=objc)                                 | ✓    | ✓     |
| BodyFatPercentage      | [HKQuantityTypeIdentifierBodyFatPercentage](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodyfatpercentage?language=objc)                                 | ✓    | ✓     |

These permissions are exported as constants of the `rn-apple-healthkit` module.

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

// get the available permissions from AppleHealthKit.Constants object
const PERMS = AppleHealthKit.Constants.Permissions;

// setup healthkit read/write permissions using PERMS
const healthKitOptions = {
    permissions: {
        read:  [
            PERMS.StepCount,
            PERMS.Height,
        ],
        write: [
            PERMS.StepCount
        ],
    }
};
```

## Units
- bpm
- calorie
- celsius
- count
- day
- fahrenheit
- foot
- gram
- hour
- inch
- joule
- meter
- mgPerdL
- mile
- minute
- mmhg
- mmolPerL
- percent
- pound
- second


## References
- Apple Healthkit Documentation [https://developer.apple.com/Healthkit/](https://developer.apple.com/Healthkit/)
