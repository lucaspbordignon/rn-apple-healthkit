//
//  RCTAppleHealthKit+Statistics.m
//  RCTAppleHealthKit
//
//  Created by Elena Grednikova on 13.10.2020.
//  Copyright © 2020 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Statistics)

- (nullable HKQuantity *)statistics_getQuantity:(NSString *)key result:(HKStatistics *)result {
    HKQuantity *quantity;

    if([key isEqualToString:@"average"]){
        quantity = [result averageQuantity];
    }
    if([key isEqualToString:@"min"]){
        quantity = [result minimumQuantity];
    }
    if([key isEqualToString:@"max"]){
       quantity = [result maximumQuantity];
    }
    if([key isEqualToString:@"sum"]){
        quantity = [result sumQuantity];
    }
    if([key isEqualToString:@"mostRecent"]){
        if (@available(iOS 13.0, *)) {
             quantity = [result mostRecentQuantity];
        } else {
            NSLog(@"mostRecent Unavailable in this OS version");
        }
    }

    return quantity;
}

- (HKStatisticsOptions)statistics_getStatisticsType:(NSString *)key {
    HKStatisticsOptions statisticsType;

    if([key isEqualToString:@"average"]){
        statisticsType = HKStatisticsOptionDiscreteAverage;
    } else if([key isEqualToString:@"min"]){
        statisticsType = HKStatisticsOptionDiscreteMin;
    } else if([key isEqualToString:@"max"]){
        statisticsType = HKStatisticsOptionDiscreteMax;
    } else if([key isEqualToString:@"sum"]){
        statisticsType = HKStatisticsOptionCumulativeSum;
    } else if([key isEqualToString:@"mostRecent"]){
        if (@available(iOS 13.0, *)) {
             statisticsType = HKStatisticsOptionMostRecent;
        } else {
            NSLog(@"mostRecent Unavailable in this OS version");
            statisticsType = HKStatisticsOptionNone;
        }
    } else {
        statisticsType = HKStatisticsOptionNone;
    }

    return statisticsType;
}

- (nullable HKQuantityType *)statistics_getQuantityType:(NSString *)key {
    HKQuantityType *quantityType;

    if([key isEqualToString:@"stepCount"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    }
    if([key isEqualToString:@"activeEnergyBurned"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    }
    if([key isEqualToString:@"basalEnergyBurned"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    }
    if([key isEqualToString:@"bodyMassIndex"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    }
    if([key isEqualToString:@"bodyMass"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    }
    if([key isEqualToString:@"bodyFatPercentage"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    }
    if([key isEqualToString:@"heartRate"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    }
    if([key isEqualToString:@"restingHeartRate"]){
        if (@available(iOS 11.0, *)) {
             quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
        } else {
            NSLog(@"restingHeartRate Unavailable in this OS version");
            return nil;
        }
    }
    if([key isEqualToString:@"heartRateVariability"]){
        if (@available(iOS 11.0, *)) {
             quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
        } else {
            NSLog(@"heartRateVariability Unavailable in this OS version");
            return nil;
        }
    }
    if([key isEqualToString:@"oxygenSaturation"]){
        quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    }

    return quantityType;
}

- (void)statistics_fetchStatistics:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:options key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:options key:@"endDate" withDefault:[NSDate date]];

    NSString *type = [options objectForKey:@"type"];
    NSString *aggregationType = [options objectForKey:@"aggregationType"];
    NSString *unitName = [options objectForKey:@"unit"];

    if(startDate == nil) {
        callback(@[RCTMakeError(@"options.startDate is required", nil, nil)]);
        return;
    }

    if(type == nil) {
        callback(@[RCTMakeError(@"options.type is required", nil, nil)]);
        return;
    }

    if(aggregationType == nil) {
        callback(@[RCTMakeError(@"options.aggregationType is required", nil, nil)]);
        return;
    }

    if(unitName == nil) {
        callback(@[RCTMakeError(@"options.unit is required", nil, nil)]);
        return;
    }

    HKQuantityType *quantityType = [self statistics_getQuantityType:type];
    HKStatisticsOptions statisticsOptions = [self statistics_getStatisticsType:aggregationType];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:options key:@"unit" withDefault:nil];

    if(quantityType == nil){
        callback(@[RCTMakeError(@"Not supported quantity type", nil, nil)]);
        return;
    }

    // TODO: read interval from options
    NSDateComponents *interval = [NSDateComponents new];
    interval.day = 1;

    HKStatisticsCollectionQuery *query =
    [[HKStatisticsCollectionQuery alloc]
     initWithQuantityType:quantityType
     quantitySamplePredicate:nil
     options:statisticsOptions
     anchorDate:startDate
     intervalComponents:interval];

    query.initialResultsHandler =
    ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {

        if (error) {
            callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
            return;
        }

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

        [results
         enumerateStatisticsFromDate:startDate
         toDate:endDate
         withBlock:^(HKStatistics *result, BOOL *stop) {
            HKQuantity *quantity = [self statistics_getQuantity:aggregationType result:result];
                     if (quantity) {
                         double value = [quantity doubleValueForUnit:unit];

                         NSDictionary *elem = @{
                             @"value" : @(value),
                             @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:result.startDate],
                             @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:result.endDate]
                         };

                         [data addObject:elem];
                     }

                 }];

        callback(@[[NSNull null], data]);
    };

    [self.healthStore executeQuery:query];
}

- (void)statistics_fetchWorkoutStatistics:(NSDictionary *)options
                                 callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:options key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:options key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil) {
        callback(@[RCTMakeError(@"options.startDate is required", nil, nil)]);
        return;
    }

    NSPredicate* period = [HKQuery predicateForSamplesWithStartDate:startDate
                                                            endDate:endDate
                                                            options:HKQueryOptionNone];

    HKSampleQuery* query = [[HKSampleQuery alloc] initWithSampleType:[HKWorkoutType workoutType]
                                                           predicate:period
                                                               limit:HKObjectQueryNoLimit
                                                     sortDescriptors:nil
                                                      resultsHandler:^(HKSampleQuery* query,
                                                                       NSArray<HKWorkout*>* results,
                                                                       NSError* error) {
        if (error) {
            callback(@[RCTMakeError(error.localizedDescription, nil, nil)]);
            return;
        }

        NSMutableArray* samples = [NSMutableArray arrayWithCapacity:results.count];

        for (HKWorkout* workout in results) {
            double durationMinutes = [workout.endDate timeIntervalSinceDate:workout.startDate] / 60;

            NSDictionary* sample = @{
                @"activityType": [RCTAppleHealthKit stringForHKWorkoutActivityType:workout.workoutActivityType],
                @"duration" : @(durationMinutes),
                @"energyBurned": @([workout.totalEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]]),
                @"distance": @([workout.totalDistance doubleValueForUnit:[HKUnit meterUnit]]),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:workout.startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:workout.endDate]
            };

            [samples addObject:sample];
        }

        callback(@[[NSNull null], samples]);
    }];

    [self.healthStore executeQuery:query];
}

@end
