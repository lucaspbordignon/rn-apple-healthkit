#import "RCTAppleHealthKit+Methods_Vitals.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Vitals)


- (void)vitals_getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:heartRateType
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

- (void)vitals_saveHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    // Need to grab date from device, optionally set it to now
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double heartRate = [RCTAppleHealthKit doubleFromOptions:input key:@"heartRate" withDefault:0];
    HKQuantity *heartRateQuantity = [HKQuantity quantityWithUnit:[count unitDividedByUnit:minute] doubleValue:heartRate];
    HKQuantitySample *heartRateSample = [HKQuantitySample quantitySampleWithType:heartRateType quantity:heartRateQuantity startDate:startDate endDate:endDate];
    
    [self.healthStore saveObject:heartRateSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving the heart rate sample: %@", error);
            callback(@[RCTMakeError(@"error saving the heart rate sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(heartRate)]);
    }];
    
}

- (void)vitals_getRestingHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    if (@available(iOS 11.0, *)) {
        HKQuantityType *restingHeartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
        
        HKUnit *count = [HKUnit countUnit];
        HKUnit *minute = [HKUnit minuteUnit];
        
        HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
        NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
        BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
        if(startDate == nil){
            callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
            return;
        }
        NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
        
        [self fetchQuantitySamplesOfType:restingHeartRateType
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
    } else {
        // Fallback on earlier versions
    }
}


- (void)vitals_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyTemperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bodyTemperatureType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting body temperature samples: %@", error);
            callback(@[RCTMakeError(@"error getting body temperature samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples", nil, nil)]);
            return;
        }
    }];
}

- (void)vitals_saveBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{

    // Need to grab date from device, optionally set it to now
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    
    // Build systolic object
    double systolic = [RCTAppleHealthKit doubleFromOptions:input key:@"systolic" withDefault:0];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantity *systolicQuantity = [HKQuantity quantityWithUnit:[HKUnit millimeterOfMercuryUnit] doubleValue:systolic];
    HKQuantitySample *systolicSample = [HKQuantitySample quantitySampleWithType:systolicType quantity:systolicQuantity startDate:startDate endDate:endDate];
    
    // Build diastolic object
    double diastolic = [RCTAppleHealthKit doubleFromOptions:input key:@"diastolic" withDefault:0];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    HKQuantity *diastolicQuantity = [HKQuantity quantityWithUnit:[HKUnit millimeterOfMercuryUnit] doubleValue:diastolic];
    HKQuantitySample *diastolicSample = [HKQuantitySample quantitySampleWithType:diastolicType quantity:diastolicQuantity startDate:startDate endDate:endDate];

    HKCorrelationType *bloodPressureType = [HKObjectType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    NSSet *bloodObjects = [NSSet setWithObjects:systolicSample, diastolicSample, nil];

    HKCorrelation *bloodPressure = [HKCorrelation correlationWithType:bloodPressureType startDate:startDate endDate:endDate objects:bloodObjects];

    [self.healthStore saveObject:bloodPressure withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving the blood pressure sample: %@", error);
            callback(@[RCTMakeError(@"error saving the blood pressure sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(systolic)]);
    }];
}


- (void)vitals_getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *respiratoryRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:respiratoryRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting respiratory rate samples: %@", error);
            callback(@[RCTMakeError(@"error getting respiratory rate samples", nil, nil)]);
            return;
        }
    }];
}

@end
