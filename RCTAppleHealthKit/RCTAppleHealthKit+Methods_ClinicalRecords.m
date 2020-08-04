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

    
- (void)clinical_getAllergyRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *allergyRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];
        
            NSSet *permissionSet = [NSSet setWithObjects:allergyRecordType, nil];
            //NSSet *shareSet = [NSSet set];
            NSLog(@"Fetching MostRecent QualitySampleOfType Allergy");
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *allergyType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierAllergyRecord];
                    HKSampleQuery *allergyQuery = [[HKSampleQuery alloc] initWithSampleType:allergyType predicate:nil 
                                                                            limit:HKObjectQueryNoLimit sortDescriptors:nil 
                                                                            resultsHandler:^(HKSampleQuery *query, 
                                                                            NSArray *allergiesList, NSError *error) {
                
                        if (!error && allergiesList) {
                            NSMutableArray *allergies = [[NSMutableArray alloc] init];
                            for (id allergy in allergiesList) {
                                
                                [allergies addObject:@{@"displayName" : [allergy displayName], 
                                                        @"FHIRResource": [[NSString alloc] initWithData:[[allergy FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"allergies" : allergies};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:allergyQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }


    - (void)clinical_getConditionRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *conditionRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord];
        
            NSSet *permissionSet = [NSSet setWithObjects:conditionRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", "IOS Version <12"];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *conditionType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierConditionRecord];
                    HKSampleQuery *conditionQuery = [[HKSampleQuery alloc] initWithSampleType:conditionType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *conditionsList, NSError *error) {
                        
                        if (!error && conditionsList) {
                            NSMutableArray *conditions = [[NSMutableArray alloc] init];
                            for (id condition in conditionsList) {
                                [conditions addObject:@{@"displayName" : [condition displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[condition FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"conditions" : conditions};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:conditionQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }

    - (void)clinical_getMedicationRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *medicationRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];
        
            NSSet *permissionSet = [NSSet setWithObjects:medicationRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *medicationType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierMedicationRecord];
                    HKSampleQuery *medicationQuery = [[HKSampleQuery alloc] initWithSampleType:medicationType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *medicationsList, NSError *error) {
                        
                        if (!error && medicationsList) {
                            NSMutableArray *medications = [[NSMutableArray alloc] init];
                            for (id medication in medicationsList) {
                                [medications addObject:@{@"displayName" : [medication displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[medication FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"medications" : medications};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:medicationQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }


    - (void)clinical_getLabResultRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *labResultRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord];

            NSSet *permissionSet = [NSSet setWithObjects:labResultRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *labResultType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierLabResultRecord];
                    HKSampleQuery *labResultQuery = [[HKSampleQuery alloc] initWithSampleType:labResultType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *labResultsList, NSError *error) {
                        
                        if (!error && labResultsList) {
                            NSMutableArray *labResults = [[NSMutableArray alloc] init];
                            for (id labResult in labResultsList) {
                                [labResults addObject:@{@"displayName" : [labResult displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[labResult FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"labResults" : labResults};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:labResultQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }


 
    - (void)clinical_getProcedureRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *procedureRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord];

            NSSet *permissionSet = [NSSet setWithObjects:procedureRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *procedureType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierProcedureRecord];
                    HKSampleQuery *procedureQuery = [[HKSampleQuery alloc] initWithSampleType:procedureType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *proceduresList, NSError *error) {
                        
                        if (!error && proceduresList) {
                            NSMutableArray *procedures = [[NSMutableArray alloc] init];
                            for (id procedure in proceduresList) {
                                [procedures addObject:@{@"displayName" : [procedure displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[procedure FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"procedures" : procedures};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:procedureQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }


 - (void)clinical_getImmunizationRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *immunizationRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord];

            NSSet *permissionSet = [NSSet setWithObjects:immunizationRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *immunizationType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierImmunizationRecord];
                    HKSampleQuery *immunizationQuery = [[HKSampleQuery alloc] initWithSampleType:immunizationType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *immunizationsList, NSError *error) {
                        
                        if (!error && immunizationsList) {
                            NSMutableArray *immunizations = [[NSMutableArray alloc] init];
                            for (id immunization in immunizationsList) {
                                [immunizations addObject:@{@"displayName" : [immunization displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[immunization FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"immunizations" : immunizations};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:immunizationQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }



 - (void)clinical_getClinicalVitalRecord:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
    {
        if (@available(iOS 12.0, *)) {
            HKClinicalType *clinicalVitalRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord];

            NSSet *permissionSet = [NSSet setWithObjects:clinicalVitalRecordType, nil];
            
            [self.healthStore requestAuthorizationToShareTypes:nil readTypes:permissionSet completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    HKClinicalType *clinicalVitalType = [HKObjectType clinicalTypeForIdentifier: HKClinicalTypeIdentifierVitalSignRecord];
                    HKSampleQuery *clinicalVitalQuery = [[HKSampleQuery alloc] initWithSampleType:clinicalVitalType predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *clinicalVitalsList, NSError *error) {
                        
                        if (!error && clinicalVitalsList) {
                            NSMutableArray *clinicalVitals = [[NSMutableArray alloc] init];
                            for (id clinicalVital in clinicalVitalsList) {
                                [clinicalVitals addObject:@{@"displayName" : [clinicalVital displayName],
                                                    @"FHIRResource": [[NSString alloc] initWithData:[[clinicalVital FHIRResource] data] encoding:NSUTF8StringEncoding]}];
                            }
                            
                            NSDictionary *response = @{@"clinicalVitals" : clinicalVitals};
                            callback(@[[NSNull null], response]);
                        } else {
                            NSLog(@"Error!!!");
                        }
                    }];
                    
                    
                    [self.healthStore executeQuery:clinicalVitalQuery];
                }
            }];
        } else {
            NSString *errMsg = @"Error with HealthKit authorization:IOS Version <12";
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    }



    @end

