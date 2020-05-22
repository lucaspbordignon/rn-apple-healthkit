//
//  RCTAppleHealthKit+Methods_Hearing.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-11-06.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//


#import "RCTAppleHealthKit+Methods_Hearing.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Hearing)



- (void)hearing_getHeadphoneAudioSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *audioExposureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit decibelAWeightedSoundPressureLevel];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    
    [self fetchQuantitySamplesOfType:audioExposureType
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
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


@end
