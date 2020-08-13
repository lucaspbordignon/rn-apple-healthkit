//
//  RCTAppleHealthkitManager.m
//  RCTAppleHealthKit
//
//  Created by Hammad Ahmad on 8/13/20.
//  Copyright © 2020 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Manager.h"
#import <HealthKit/HealthKit.h>
#import "RCTAppleHealthKit.h"


#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Manager)

//This is essentially creating a sharedManager (HealthKitManager) that can be called in AppDelegate
+ (RCTAppleHealthKit *)sharedManager {
    static dispatch_once_t pred = 0;
    static RCTAppleHealthKit *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[RCTAppleHealthKit alloc] init];
        instance.healthStore = [[HKHealthStore alloc] init];
    });
    return instance;
}

//healthkit value change handler. It emits the event to js and js can pick up
- (void) healthkitValueAddedHandler {
    NSLog(@"healthkitValueAddedHandler");
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    [self.bridge.eventDispatcher emitEventWithName:@"healthkit" andPayload:dict];
    [self.bridge.eventDispatcher sendAppEventWithName:@"healthkit" body:dict];
    
}

//Thie is to set up the healthkit listner. We listen to the healthkit change event of all the healthkit type we support
- (void)setupHKListener {
    
    //sleep
    HKSampleType *sleepSampleType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    HKObserverQuery *sleepQuery = [[HKObserverQuery alloc] initWithSampleType:sleepSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:sleepQuery];
    [self.healthStore enableBackgroundDeliveryForType:sleepSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //blood pressure
    HKSampleType *bloodPressureDiastolicSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    HKObserverQuery *bloodPressureDiastolicQuery = [[HKObserverQuery alloc] initWithSampleType:bloodPressureDiastolicSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:bloodPressureDiastolicQuery];
    [self.healthStore enableBackgroundDeliveryForType:bloodPressureDiastolicSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    HKSampleType *bloodPressureSystolicSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKObserverQuery *bloodPressureSystolicQuery = [[HKObserverQuery alloc] initWithSampleType:bloodPressureSystolicSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:bloodPressureSystolicQuery];
    [self.healthStore enableBackgroundDeliveryForType:bloodPressureSystolicSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //step count
    HKSampleType *stepCountSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKObserverQuery *stepCountQuery = [[HKObserverQuery alloc] initWithSampleType:stepCountSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:stepCountQuery];
    [self.healthStore enableBackgroundDeliveryForType:stepCountSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //blood glucose
    HKSampleType *bloodGlucoseSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    HKObserverQuery *bloodGlucoseQuery = [[HKObserverQuery alloc] initWithSampleType:bloodGlucoseSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:bloodGlucoseQuery];
    [self.healthStore enableBackgroundDeliveryForType:bloodGlucoseSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //weight
    HKSampleType *weightSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKObserverQuery *weightQuery = [[HKObserverQuery alloc] initWithSampleType:weightSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:weightQuery];
    [self.healthStore enableBackgroundDeliveryForType:weightSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //height
    HKSampleType *heightSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKObserverQuery *heightQuery = [[HKObserverQuery alloc] initWithSampleType:heightSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:heightQuery];
    [self.healthStore enableBackgroundDeliveryForType:heightSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
    
    //heart rate
    HKSampleType *heartRateSampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKObserverQuery *heartRateQuery = [[HKObserverQuery alloc] initWithSampleType:heartRateSampleType predicate:nil updateHandler:^(HKObserverQuery * _Nonnull query, HKObserverQueryCompletionHandler  _Nonnull completionHandler, NSError * _Nullable error) {
        [self healthkitValueAddedHandler];
    }];
    
    [self.healthStore executeQuery:heartRateQuery];
    [self.healthStore enableBackgroundDeliveryForType:heartRateSampleType frequency:HKUpdateFrequencyImmediate withCompletion:^(BOOL success, NSError * _Nullable error) {}];
}


@end
