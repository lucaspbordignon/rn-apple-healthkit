//
//  RCTAppleHealthKit+TypesAndPermissions.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+TypesAndPermissions.h"
#define WORKOUT_DICTIONARY @{"key" : "value"\
"key2" : "value2"}

@implementation RCTAppleHealthKit (TypesAndPermissions)


#pragma mark - HealthKit Permissions

- (NSDictionary *)readPermsDict {
    NSDictionary *readPerms = @{
        // Characteristic Identifiers
        @"DateOfBirth" : [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
        @"BiologicalSex" : [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
        // Body Measurements
        @"Height" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
        @"Weight" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyFatPercentage" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage],
        @"BodyMassIndex" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
        @"LeanBodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass],
        // Fitness Identifiers
        @"Steps" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"StepCount" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"DistanceWalkingRunning" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
        @"DistanceCycling" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling],
        @"BasalEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
        @"ActiveEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
        @"FlightsClimbed" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
        @"NikeFuel" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel],
//        @"AppleExerciseTime" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime],
        // Nutrition Identifiers
        @"DietaryEnergy" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
        // Vital Signs Identifiers
        @"HeartRate" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
        @"BodyTemperature" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature],
        @"BloodPressureSystolic" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic],
        @"BloodPressureDiastolic" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic],
        @"RespiratoryRate" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate],
        // Results Identifiers
        @"BloodGlucose" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose],
        // Sleep
        @"SleepAnalysis" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis],
        // Mindfulness
        @"MindfulSession" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession],
        @"Workout" : [HKObjectType workoutType],
        @"Cholesterol": [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol]
    };
    return readPerms;
}


- (NSDictionary *)writePermsDict {
    NSDictionary *writePerms = @{
        // Body Measurements
        @"Height" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
        @"Weight" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
        @"BodyFatPercentage" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage],
        @"BodyMassIndex" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
        @"LeanBodyMass" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass],
        // Fitness Identifiers
        @"Steps" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"StepCount" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
        @"DistanceWalkingRunning" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
        @"DistanceCycling" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling],
        @"BasalEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
        @"ActiveEnergyBurned" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
        @"FlightsClimbed" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
        // Nutrition Identifiers
        @"Biotin" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin],
        @"Caffeine" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine],
        @"Calcium" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium],
        @"Carbohydrates" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates],
        @"Chloride" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride],
        @"Cholesterol" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol],
        @"Copper" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper],
        @"EnergyConsumed" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
        @"FatMonounsaturated" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated],
        @"FatPolyunsaturated" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated],
        @"FatSaturated" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated],
        @"FatTotal" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal],
        @"Fiber" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber],
        @"Folate" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate],
        @"Iodine" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine],
        @"Iron" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron],
        @"Magnesium" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium],
        @"Manganese" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese],
        @"Molybdenum" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum],
        @"Niacin" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin],
        @"PantothenicAcid" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid],
        @"Phosphorus" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus],
        @"Potassium" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium],
        @"Protein" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein],
        @"Riboflavin" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin],
        @"Selenium" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium],
        @"Sodium" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium],
        @"Sugar" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar],
        @"Thiamin" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin],
        @"VitaminA" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA],
        @"VitaminB12" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12],
        @"VitaminB6" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6],
        @"VitaminC" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC],
        @"VitaminD" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD],
        @"VitaminE" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE],
        @"VitaminK" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK],
        @"Zinc" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc],
        @"Water" : [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater],
        // Sleep
        @"SleepAnalysis" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis],
        // Mindfulness
        @"MindfulSession" : [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession],
        @"Workout" : [HKObjectType workoutType],
    };
    return writePerms;
}


// Returns HealthKit read permissions from options array
- (NSSet *)getReadPermsFromOptions:(NSArray *)options {
    NSDictionary *readPermDict = [self readPermsDict];
    NSMutableSet *readPermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        HKObjectType *val = [readPermDict objectForKey:optionKey];
        if(val != nil) {
            [readPermSet addObject:val];
        }
    }
    return readPermSet;
}


// Returns HealthKit write permissions from options array
- (NSSet *)getWritePermsFromOptions:(NSArray *)options {
    NSDictionary *writePermDict = [self writePermsDict];
    NSMutableSet *writePermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        HKObjectType *val = [writePermDict objectForKey:optionKey];
        if(val != nil) {
            [writePermSet addObject:val];
        }
    }
    return writePermSet;
}

+ (NSDictionary *)getStringToWorkoutActivityTypeDictionary {
    return @{
             @"AmericanFootball": @(HKWorkoutActivityTypeAmericanFootball),
             @"Archery": @(HKWorkoutActivityTypeArchery),
             @"AustralianFootball": @(HKWorkoutActivityTypeAustralianFootball),
             @"Badminton": @(HKWorkoutActivityTypeBadminton),
             @"Baseball": @(HKWorkoutActivityTypeBaseball),
             @"Basketball": @(HKWorkoutActivityTypeBasketball),
             @"Bowling": @(HKWorkoutActivityTypeBowling),
             @"Boxing": @(HKWorkoutActivityTypeBoxing) ,
             @"Climbing": @(HKWorkoutActivityTypeClimbing),
             @"Cricket": @(HKWorkoutActivityTypeCricket),
             @"CrossTraining": @(HKWorkoutActivityTypeCrossTraining) ,
             @"Curling": @(HKWorkoutActivityTypeCurling),
             @"Cycling": @(HKWorkoutActivityTypeCycling),
             @"Dance": @(HKWorkoutActivityTypeDance),
             @"Elliptical": @(HKWorkoutActivityTypeElliptical),
             @"EquestrianSports": @(HKWorkoutActivityTypeEquestrianSports) ,
             @"Fencing": @(HKWorkoutActivityTypeFencing),
             @"Fishing": @(HKWorkoutActivityTypeFishing),
             @"FunctionalStrengthTraining": @(HKWorkoutActivityTypeFunctionalStrengthTraining) ,
             @"Golf": @(HKWorkoutActivityTypeGolf),
             @"Gymnastics": @(HKWorkoutActivityTypeGymnastics),
             @"Handball": @(HKWorkoutActivityTypeHandball),
             @"Hiking": @(HKWorkoutActivityTypeHiking),
             @"Hockey": @(HKWorkoutActivityTypeHockey) ,
             @"Hunting": @(HKWorkoutActivityTypeHunting),
             @"Lacrosse": @(HKWorkoutActivityTypeLacrosse),
             @"MartialArts": @(HKWorkoutActivityTypeMartialArts),
             @"MindAndBody": @(HKWorkoutActivityTypeMindAndBody) ,
             @"PaddleSports": @(HKWorkoutActivityTypePaddleSports) ,
             @"Play": @(HKWorkoutActivityTypePlay) ,
             @"PreparationAndRecovery": @(HKWorkoutActivityTypePreparationAndRecovery) ,
             @"Racquetball": @(HKWorkoutActivityTypeRacquetball),
             @"Rowing": @(HKWorkoutActivityTypeRowing),
             @"Rugby": @(HKWorkoutActivityTypeRugby),
             @"Running": @(HKWorkoutActivityTypeRunning),
             @"Sailing": @(HKWorkoutActivityTypeSailing),
             @"SkatingSports": @(HKWorkoutActivityTypeSkatingSports) ,
             @"SnowSports": @(HKWorkoutActivityTypeSnowSports) ,
             @"Soccer": @(HKWorkoutActivityTypeSoccer),
             @"Softball": @(HKWorkoutActivityTypeSoftball),
             @"Squash": @(HKWorkoutActivityTypeSquash),
             @"StairClimbing": @(HKWorkoutActivityTypeStairClimbing) ,
             @"SurfingSports": @(HKWorkoutActivityTypeSurfingSports) ,
             @"Swimming": @(HKWorkoutActivityTypeSwimming),
             @"TableTennis": @(HKWorkoutActivityTypeTableTennis),
             @"Tennis": @(HKWorkoutActivityTypeTennis),
             @"TrackAndField": @(HKWorkoutActivityTypeTrackAndField) ,
             @"TraditionalStrengthTraining": @(HKWorkoutActivityTypeTraditionalStrengthTraining) ,
             @"Volleyball": @(HKWorkoutActivityTypeVolleyball),
             @"Walking": @(HKWorkoutActivityTypeWalking),
             @"WaterFitness": @(HKWorkoutActivityTypeWaterFitness),
             @"WaterPolo": @(HKWorkoutActivityTypeWaterPolo),
             @"WaterSports": @(HKWorkoutActivityTypeWaterSports) ,
             @"Wrestling": @(HKWorkoutActivityTypeWrestling),
             @"Yoga": @(HKWorkoutActivityTypeYoga)  ,
             @"Barre": @(HKWorkoutActivityTypeBarre),
             @"CoreTraining": @(HKWorkoutActivityTypeCoreTraining),
             @"CrossCountrySkiing": @(HKWorkoutActivityTypeCrossCountrySkiing),
             @"DownhillSkiing": @(HKWorkoutActivityTypeDownhillSkiing),
             @"Flexibility": @(HKWorkoutActivityTypeFlexibility),
             @"HighIntensityIntervalTraining": @(HKWorkoutActivityTypeHighIntensityIntervalTraining),
             @"JumpRope": @(HKWorkoutActivityTypeJumpRope),
             @"Kickboxing": @(HKWorkoutActivityTypeKickboxing),
             @"Pilates": @(HKWorkoutActivityTypePilates),
             @"Snowboarding": @(HKWorkoutActivityTypeSnowboarding),
             @"Stairs": @(HKWorkoutActivityTypeStairs),
             @"StepTraining": @(HKWorkoutActivityTypeStepTraining),
             @"WheelchairWalkPace": @(HKWorkoutActivityTypeWheelchairWalkPace),
             @"WheelchairRunPace": @(HKWorkoutActivityTypeWheelchairRunPace),
             @"TaiChi": @(HKWorkoutActivityTypeTaiChi),
             @"MixedCardio": @(HKWorkoutActivityTypeMixedCardio),
             @"HandCycling": @(HKWorkoutActivityTypeHandCycling)
             };
}

@end
