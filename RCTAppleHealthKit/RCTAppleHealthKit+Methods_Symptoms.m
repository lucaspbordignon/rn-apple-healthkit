//
//  RCTAppleHealthKit+Methods_Symptoms.m
//  RCTAppleHealthKit
//
//  Created by Bartek Widlarz on 18/09/2020.
//

#import "RCTAppleHealthKit+Methods_Symptoms.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Methods_Symptoms)

- (void)symptoms_getBloating:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double limit = [RCTAppleHealthKit doubleFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    NSLog(@"startDate: %@", startDate);

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc]
        initWithKey:HKSampleSortIdentifierEndDate
        ascending:NO
    ];

    HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierBloating];
    
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    HKSampleQuery *query = [[HKSampleQuery alloc]
        initWithSampleType:type
        predicate:predicate
        limit: limit
        sortDescriptors:@[timeSortDescriptor]
        resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {

            if (error != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", error);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", error, nil)]);
            return;
            }
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:(10)];

            for (HKCategorySample *sample in results) {
            NSLog(@"sample for bloating %@", sample);
            NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
            NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

            NSDictionary *elem = @{
                    @"startDate" : startDateString,
                    @"endDate" : endDateString,
            };

            [data addObject:elem];
        }
        callback(@[[NSNull null], data]);
     }
    ];
    [self.healthStore executeQuery:query];
}
@end

//
//- (void)getSymptomsDailySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
//{
//    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
//    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
//    HKObject *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKCategoryValueSeverity severity]];
//    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:nil];
//
//    if(startDate == nil ){
//        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
//        return;
//    }
//    if(type == nil ){
//        callback(@[RCTMakeError(@"type is required in options", nil, nil)]);
//        return;
//    }
//
//    HKCategoryType  *categoryType;
//    if ([type isEqual:@"bloating"]) {
//        quantityType = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierBloating];
//    }
//
//
//    [self fetchCumulativeSumStatisticsCollection:categoryType
//                                            unit:unit
//                                       startDate:startDate
//                                         endDate:endDate
//                                       ascending:false
//                                           limit:HKObjectQueryNoLimit
//                                      completion:^(NSArray *arr, NSError *err){
//                                          if (err != nil) {
//                                              callback(@[RCTJSErrorFromNSError(err)]);
//                                              return;
//                                          }
//                                          callback(@[[NSNull null], arr]);
//                                      }];
//
//}
//
//
//@end

