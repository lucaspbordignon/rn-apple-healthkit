//
//  RCTAppleHealthKit+Methods_Nutrition.m
//  RCTAppleHealthKit
//
//  Created by Ahmed Fathy Ghazy on 4/25/18.
//  Copyright © 2018 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Methods_Nutrition)
- (void)nutrition_getCholesterol:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    void (^completion)(NSArray *results, NSError *error);
    completion = ^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSString *errMsg = [NSString stringWithFormat:@"Error getting cholesterol: %@", error];
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    };
    
    [self fetchCholesterolForPredicate: predicate
             ascending:ascending
                 limit:limit
            completion:completion];
}
@end
