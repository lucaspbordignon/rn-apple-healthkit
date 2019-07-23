#import "RCTAppleHealthKit+Methods_ReproductiveHealth.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)

- (void)reproductiveHealth_getBasalBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];

    if (startDate == nil) {
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalBodyTemperature];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    [self fetchQuantitySamplesOfType:sampleType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting basal body temperature samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting basal body temperature samples", nil, nil)]);
                                  return;
                              }
                          }];

}

- (void)reproductiveHealth_getMenstruationFlowSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

    if (startDate == nil) {
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    [self fetchMenstruationFlowSamples:predicate
                             ascending:ascending
                                 limit:limit
                            completion:^(NSArray *results, NSError *error) {
                                if (results) {
                                    callback(@[[NSNull null], results]);
                                    return;
                                } else {
                                    NSLog(@"Error getting menstruation flow samples: %@", error);
                                    callback(@[RCTMakeError(@"Error getting menstruation flow samples", error, nil)]);
                                    return;
                                }
                            }];

}

- (void)reproductiveHealth_getOvulationTestResultSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

    if (startDate == nil) {
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    [self fetchOvulationTestResultSamples:predicate
                                ascending:ascending
                                    limit:limit
                               completion:^(NSArray *results, NSError *error) {
                                      if (results) {
                                          callback(@[[NSNull null], results]);
                                          return;
                                      } else {
                                          NSLog(@"Error getting ovulation test result samples: %@", error);
                                          callback(@[RCTMakeError(@"Error getting ovulation test result samples", error, nil)]);
                                          return;
                                      }
                                  }];

}

- (void)reproductiveHealth_getSexualActivitySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

    if (startDate == nil) {
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    [self fetchSexualActivitySamples:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                                if (results) {
                                    callback(@[[NSNull null], results]);
                                    return;
                                } else {
                                    NSLog(@"Error getting sexual activity samples: %@", error);
                                    callback(@[RCTMakeError(@"Error getting sexual activity samples", error, nil)]);
                                    return;
                                }
                            }];

}

@end
