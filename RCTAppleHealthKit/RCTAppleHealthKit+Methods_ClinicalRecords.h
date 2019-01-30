//
//  RCTAppleHealthKit+Methods_ClinicalRecords.h
//  RCTAppleHealthKit
//
//  Created by Kartik Thakore on 1/29/19.
//  Copyright © 2019 Kartik Thakore. All rights reserved.
//

#ifndef RCTAppleHealthKit_Methods_ClincalRecords_h
#define RCTAppleHealthKit_Methods_ClincalRecords_h

#import "RCTAppleHealthKit.h"

/*
             "MedicationRecord", 
             "AllergyRecord",
             "ConditionRecord",
             "ImmunizationRecord",
             "LabResultRecord",
             "ProcedureRecord",
             "VitalSignRecord"
            
*/

@interface RCTAppleHealthKit (Methods_ClinicalRecords)
    
- (void)clinical_getMedicationRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
    
    @end
#endif /* RCTAppleHealthKit_Methods_ClincalRecords_h */
