//
//  RCTAppleHealthKit+Methods_Audio.m
//  RCTAppleHealthKit
//
//  Created by Udi Falkson on 2019-09-08.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//


#import "RCTAppleHealthKit+Methods_Audio.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)


- (void)audio_getEnvironmentalSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *eventType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierEnvironmentalAudioExposure];
    HKUnit *unit = [HKUnit decibelAWeightedSoundPressureLevelUnit];

    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:eventType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
    }];
}

- (void)audio_getAvgDecibelsInDateRange:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil) {
        callback(@[RCTMakeError(@"could not parse startDate from options.date", nil, nil)]);
        return;
    }

    if(endDate == nil) {
        callback(@[RCTMakeError(@"could not parse endDate from options.date", nil, nil)]);
        return;
    }

    HKQuantityType *eventType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierEnvironmentalAudioExposure];
    HKUnit *unit = [HKUnit decibelAWeightedSoundPressureLevelUnit];

    [self fetchAvgOfSamplesInDateRangeForType:eventType
                                   unit:unit
                                    startDate:startDate
                                      endDate: endDate
                             completion:^(double value, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!value) {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }

         NSDictionary *response = @{
                 @"value" : @(value),
                 @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                 @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
         };

        callback(@[[NSNull null], response]);
    }];
}


@end
