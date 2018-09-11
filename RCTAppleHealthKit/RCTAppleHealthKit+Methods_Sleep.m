//
//  RCTAppleHealthKit+Methods_Sleep.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-11-06.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//


#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)



- (void)sleep_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    
    [self fetchSleepCategorySamplesForPredicate:predicate
                                          limit:limit
                                     completion:^(NSArray *results, NSError *error) {
                                         if(results){
                                             callback(@[[NSNull null], results]);
                                             return;
                                         } else {
                                             NSLog(@"error getting sleep samples: %@", error);
                                             callback(@[RCTMakeError(@"error getting sleep samples", nil, nil)]);
                                             return;
                                         }
                                     }];
    
}


- (void)sleep_saveSleep:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSString *valueString = [RCTAppleHealthKit stringFromOptions:input key:@"value" withDefault:nil];
    double value;

    if ([valueString isEqualToString:@"INBED"]) {
        value = HKCategoryValueSleepAnalysisInBed;
    } else if ([valueString isEqualToString:@"ASLEEP"]) {
        value = HKCategoryValueSleepAnalysisAsleep;
    } else if ([valueString isEqualToString:@"AWAKE"]) {
        value = HKCategoryValueSleepAnalysisAwake;
    } else {
        callback(@[RCTMakeError(@"value must be one of (INBED, ASLEEP, AWAKE)", nil, nil)]);
        return;
    }

    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil || endDate == nil){
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }

    HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierSleepAnalysis];
    HKCategorySample *sample = [HKCategorySample categorySampleWithType:type value:value startDate:startDate endDate:endDate];

    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the sleep sample %@. The error was: %@.", sample, error);
            callback(@[RCTMakeError(@"An error occured saving the sleep sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(value)]);
    }];

}


@end
