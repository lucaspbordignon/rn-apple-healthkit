//
//  RCTAppleHealthKit+Utils.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Utils)


#pragma mark - Utilities

+ (NSDate *)parseISO8601DateFromString:(NSString *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
    return [dateFormatter dateFromString:date];
}


+ (NSString *)buildISO8601StringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
    return [dateFormatter stringFromDate:date];
}


+ (NSPredicate *)predicateForSamplesToday {
    NSDate *now = [NSDate date];
    return [RCTAppleHealthKit predicateForSamplesOnDay:now];
}


+ (NSPredicate *)predicateForSamplesOnDayFromTimestamp:(NSString *)timestamp {
    NSDate *day = [RCTAppleHealthKit parseISO8601DateFromString:timestamp];
    return [RCTAppleHealthKit predicateForSamplesOnDay:day];
}


+ (NSPredicate *)predicateForSamplesOnDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startDate = [calendar startOfDayForDate:date];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}


+ (NSPredicate *)predicateForSamplesBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}


+ (double)doubleValueFromOptions:(NSDictionary *)options {
    double value = [[options objectForKey:@"value"] doubleValue];
    return value;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}


+ (NSDate *)dateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    if(dateString != nil){
        NSDate *date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        if(date == nil){
            // probably not a good idea... should return an error or just the null pointer
            date = [NSDate date];
        }
        return date;
    }
    NSDate *now = [NSDate date];
    return now;
}


+ (NSDate *)startDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"startDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    return date;
}


+ (NSDate *)endDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}


+ (NSDate *)endDateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    if(date == nil){
        date = [NSDate date];
    }
    return date;
}

+ (HKSampleType *)hkQuantityTypeFromString:(NSString *)type {
    if ([type isEqual:@"Walking"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([type isEqual:@"StairClimbing"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([type isEqual:@"Running"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([type isEqual:@"Cycling"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([type isEqual:@"Swimming"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    }
    // default [type isEqual:@"Workout"])
    return [HKObjectType workoutType];
}


+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(HKUnit *)defaultValue {
    NSString *unitString = [options objectForKey:key];
    HKUnit *theUnit;

    if([unitString isEqualToString:@"gram"]){
        theUnit = [HKUnit gramUnit];
    }
    if([unitString isEqualToString:@"kg"]){
        theUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    }
    if([unitString isEqualToString:@"stone"]){
        theUnit = [HKUnit stoneUnit];
    }
    if([unitString isEqualToString:@"pound"]){
        theUnit = [HKUnit poundUnit];
    }
    if([unitString isEqualToString:@"meter"]){
        theUnit = [HKUnit meterUnit];
    }
    if([unitString isEqualToString:@"cm"]){
        theUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
    }
    if([unitString isEqualToString:@"inch"]){
        theUnit = [HKUnit inchUnit];
    }
    if([unitString isEqualToString:@"mile"]){
        theUnit = [HKUnit mileUnit];
    }
    if([unitString isEqualToString:@"foot"]){
        theUnit = [HKUnit footUnit];
    }
    if([unitString isEqualToString:@"second"]){
        theUnit = [HKUnit secondUnit];
    }
    if([unitString isEqualToString:@"millisecond"]){
        theUnit = [HKUnit secondUnitWithMetricPrefix:HKMetricPrefixMilli];
    }
    if([unitString isEqualToString:@"minute"]){
        theUnit = [HKUnit minuteUnit];
    }
    if([unitString isEqualToString:@"hour"]){
        theUnit = [HKUnit hourUnit];
    }
    if([unitString isEqualToString:@"day"]){
        theUnit = [HKUnit dayUnit];
    }
    if([unitString isEqualToString:@"joule"]){
        theUnit = [HKUnit jouleUnit];
    }
    if([unitString isEqualToString:@"kilocalorie"]){
        theUnit = [HKUnit kilocalorieUnit];
    }
    if([unitString isEqualToString:@"calorie"]){
        theUnit = [HKUnit calorieUnit];
    }
    if([unitString isEqualToString:@"count"]){
        theUnit = [HKUnit countUnit];
    }
    if([unitString isEqualToString:@"percent"]){
        theUnit = [HKUnit percentUnit];
    }
    if([unitString isEqualToString:@"bpm"]){
        HKUnit *count = [HKUnit countUnit];
        HKUnit *minute = [HKUnit minuteUnit];

        theUnit = [count unitDividedByUnit:minute];
    }
    if([unitString isEqualToString:@"fahrenheit"]){
        theUnit = [HKUnit degreeFahrenheitUnit];
    }
    if([unitString isEqualToString:@"celsius"]){
        theUnit = [HKUnit degreeCelsiusUnit];
    }
    if([unitString isEqualToString:@"mmhg"]){
        theUnit = [HKUnit millimeterOfMercuryUnit];
    }
    if([unitString isEqualToString:@"mmolPerL"]){
        theUnit = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];
    }
    if([unitString isEqualToString:@"mgPerdL"]){
        theUnit = [HKUnit unitFromString:@"mg/dL"];
    }

    if(theUnit == nil){
        theUnit = defaultValue;
    }

    return theUnit;
}


+ (NSUInteger)uintFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSUInteger)defaultValue {
    NSUInteger val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num unsignedIntValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (double)doubleFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(double)defaultValue {
    double val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num doubleValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSDate *)defaultValue {
    NSString *dateString = [options objectForKey:key];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    } else {
        date = defaultValue;
    }
    return date;
}


+ (NSString *)stringFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSString *)defaultValue {
    NSString *str = [options objectForKey:key];
    if(str == nil){
        str = defaultValue;
    }
    return str;
}


+ (bool)boolFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(bool)defaultValue {
    NSNumber *num = [options objectForKey:key];
    if(num == nil){
        return defaultValue;
    }
    return [num boolValue];
}


+ (NSMutableArray *)reverseNSMutableArray:(NSMutableArray *)array {
    if ([array count] <= 1)
        return array;
    NSUInteger i = 0;
    NSUInteger j = [array count] - 1;
    while (i < j) {
        [array exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        i++;
        j--;
    }
    return array;
}

+ (NSString*)stringForHKWorkoutActivityType:(HKWorkoutActivityType) activityType {
    switch (activityType) {
        case HKWorkoutActivityTypeAmericanFootball:
            return @"American Football";
        case HKWorkoutActivityTypeArchery:
            return @"Archery";
        case HKWorkoutActivityTypeAustralianFootball:
            return @"Australian Football";
        case HKWorkoutActivityTypeBadminton:
            return @"Badminton";
        case HKWorkoutActivityTypeBaseball:
            return @"Baseball";
        case HKWorkoutActivityTypeBasketball:
            return @"Basketball";
        case HKWorkoutActivityTypeBowling:
            return @"Bowling";
        case HKWorkoutActivityTypeBoxing:
            return @"Boxing";
        case HKWorkoutActivityTypeClimbing:
            return @"Climbing";
        case HKWorkoutActivityTypeCricket:
            return @"Cricket";
        case HKWorkoutActivityTypeCrossTraining:
            return @"Cross Training";
        case HKWorkoutActivityTypeCurling:
            return @"Curling";
        case HKWorkoutActivityTypeCycling:
            return @"Cycling";
        case HKWorkoutActivityTypeDance:
            return @"Dance";
        case HKWorkoutActivityTypeDanceInspiredTraining:
            return @"Dance Inspired Training";
        case HKWorkoutActivityTypeElliptical:
            return @"Elliptical";
        case HKWorkoutActivityTypeEquestrianSports:
            return @"Equestrian Sports";
        case HKWorkoutActivityTypeFencing:
            return @"Fencing";
        case HKWorkoutActivityTypeFishing:
            return @"Fishing";
        case HKWorkoutActivityTypeFunctionalStrengthTraining:
            return @"Functional Strength Training";
        case HKWorkoutActivityTypeGolf:
            return @"Golf";
        case HKWorkoutActivityTypeGymnastics:
            return @"Gymnastics";
        case HKWorkoutActivityTypeHandball:
            return @"Handball";
        case HKWorkoutActivityTypeHiking:
            return @"Hiking";
        case HKWorkoutActivityTypeHockey:
            return @"Hockey";
        case HKWorkoutActivityTypeHunting:
            return @"Hunting";
        case HKWorkoutActivityTypeLacrosse:
            return @"Lacrosse";
        case HKWorkoutActivityTypeMartialArts:
            return @"Martial Arts";
        case HKWorkoutActivityTypeMindAndBody:
            return @"Mind And Body";
        case HKWorkoutActivityTypeMixedMetabolicCardioTraining:
            return @"Mixed Metabolic Cardio Training";
        case HKWorkoutActivityTypePaddleSports:
            return @"Paddle Sports";
        case HKWorkoutActivityTypePlay:
            return @"Play";
        case HKWorkoutActivityTypePreparationAndRecovery:
            return @"Preparation And Recovery";
        case HKWorkoutActivityTypeRacquetball:
            return @"Racquetball";
        case HKWorkoutActivityTypeRowing:
            return @"Rowing";
        case HKWorkoutActivityTypeRugby:
            return @"Rugby";
        case HKWorkoutActivityTypeRunning:
            return @"Running";
        case HKWorkoutActivityTypeSailing:
            return @"Sailing";
        case HKWorkoutActivityTypeSkatingSports:
            return @"Skating Sports";
        case HKWorkoutActivityTypeSnowSports:
            return @"Snow Sports";
        case HKWorkoutActivityTypeSoccer:
            return @"Soccer";
        case HKWorkoutActivityTypeSoftball:
            return @"Softball";
        case HKWorkoutActivityTypeSquash:
            return @"Squash";
        case HKWorkoutActivityTypeStairClimbing:
            return @"Stair Climbing";
        case HKWorkoutActivityTypeSurfingSports:
            return @"Surfing Sports";
        case HKWorkoutActivityTypeSwimming:
            return @"Swimming";
        case HKWorkoutActivityTypeTableTennis:
            return @"Table Tennis";
        case HKWorkoutActivityTypeTennis:
            return @"Tennis";
        case HKWorkoutActivityTypeTrackAndField:
            return @"Track And Field";
        case HKWorkoutActivityTypeTraditionalStrengthTraining:
            return @"Traditional Strength Training";
        case HKWorkoutActivityTypeVolleyball:
            return @"Volleyball";
        case HKWorkoutActivityTypeWalking:
            return @"Walking";
        case HKWorkoutActivityTypeWaterFitness:
            return @"Water Fitness";
        case HKWorkoutActivityTypeWaterPolo:
            return @"Water Polo";
        case HKWorkoutActivityTypeWaterSports:
            return @"Water Sports";
        case HKWorkoutActivityTypeWrestling:
            return @"Wrestling";
        case HKWorkoutActivityTypeYoga:
            return @"Yoga";
        case HKWorkoutActivityTypeBarre:
            return @"Barre";
        case HKWorkoutActivityTypeCoreTraining:
            return @"Core Training";
        case HKWorkoutActivityTypeCrossCountrySkiing:
            return @"Cross Country Skiing";
        case HKWorkoutActivityTypeDownhillSkiing:
            return @"Downhill Skiing";
        case HKWorkoutActivityTypeFlexibility:
            return @"Flexibility";
        case HKWorkoutActivityTypeHighIntensityIntervalTraining:
            return @"High Intensity Interval Training";
        case HKWorkoutActivityTypeJumpRope:
            return @"Jump Rope";
        case HKWorkoutActivityTypeKickboxing:
            return @"Kickboxing";
        case HKWorkoutActivityTypePilates:
            return @"Pilates";
        case HKWorkoutActivityTypeSnowboarding:
            return @"Snowboarding";
        case HKWorkoutActivityTypeStairs:
            return @"Stairs";
        case HKWorkoutActivityTypeStepTraining:
            return @"Step Training";
        case HKWorkoutActivityTypeWheelchairWalkPace:
            return @"Wheelchair Walk Pace";
        case HKWorkoutActivityTypeWheelchairRunPace:
            return @"Wheelchair Run Pace";
        case HKWorkoutActivityTypeTaiChi:
            return @"Tai Chi";
        case HKWorkoutActivityTypeMixedCardio:
            return @"Mixed Cardio";
        case HKWorkoutActivityTypeHandCycling:
            return @"Hand Cycling";
        case HKWorkoutActivityTypeDiscSports:
            return @"Disc Sports";
        case HKWorkoutActivityTypeFitnessGaming:
            return @"Fitness Gaming";
        case HKWorkoutActivityTypeCardioDance:
            return @"Cardio Dance";
        case HKWorkoutActivityTypePickleball:
            return @"Pickleball";
        case HKWorkoutActivityTypeSocialDance:
            return @"Social Dance";
        case HKWorkoutActivityTypeCooldown:
            return @"Cooldown";
        case HKWorkoutActivityTypeOther:
            return @"Other";
    }

    return @"Other";
}

@end
