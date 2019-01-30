//
//  RCTAppleHealthKit+Methods_ClincalRecords.m
//  RCTAppleHealthKit
//
//  Created by Kartik Thakore on 1/29/19.
//  Copyright © 2019 Kartik Thakore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTAppleHealthKit+Methods_ClinicalRecords.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_ClinicalRecords)

    
- (void)clinical_getMedicationRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        HKQuantityType *medicationRecordType = [HKQuantityType quantityTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];

        HKClinicalRecord
        
        let medicationsType = HKObjectType.clinicalType(forIdentifier: .medicationRecord) else {
            callback(@[RCTMakeError(@"Unable to getting medicationRecord", nil, nil)]);
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
    
    
    @end


