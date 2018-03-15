//
//  RCTAppleHealthKit+Methods_Fitness.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Fitness.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Methods_Fitness)


- (void)fitness_getStepCountOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    if(date == nil) {
        callback(@[RCTMakeError(@"could not parse date from options.date", nil, nil)]);
        return;
    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKUnit *stepsUnit = [HKUnit countUnit];

    [self fetchSumOfSamplesOnDayForType:stepCountType
                                   unit:stepsUnit
                                    day:date
                             completion:^(double value, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!value) {
            NSLog(@"could not fetch step count for day: %@", error);
            callback(@[RCTMakeError(@"could not fetch step count for day", error, nil)]);
            return;
        }

         NSDictionary *response = @{
                 @"value" : @(value),
                 @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                 @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
         };

        callback(@[[NSNull null], response]);
    }];
}


- (void)fitness_getDailyStepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    [self fetchCumulativeSumStatisticsCollection:stepCountType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
        if (err != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
            return;
        }
        callback(@[[NSNull null], arr]);
    }];
}


- (void)fitness_saveSteps:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double value = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil || endDate == nil){
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }

    HKUnit *unit = [HKUnit countUnit];
    HKQuantity *quantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantitySample *sample = [HKQuantitySample quantitySampleWithType:type quantity:quantity startDate:startDate endDate:endDate];

    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the step count sample %@. The error was: %@.", sample, error);
            callback(@[RCTMakeError(@"An error occured saving the step count sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(value)]);
    }];
}

- (void)fitness_clearSproutBackgroundTask:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int value = 0;
    [defaults removeObjectForKey:@"token"];
    [defaults removeObjectForKey:@"url"];
    [defaults removeObjectForKey:@"vendorId"];
    [defaults removeObjectForKey:@"vendorName"];
    [defaults removeObjectForKey:@"deviceId"];
    [defaults removeObjectForKey:@"lastHealthKitSync"];
    callback(@[[NSNull null], @(value)]);
}


- (void)fitness_initializeSproutBackgroundTask:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSString *sproutToken = [RCTAppleHealthKit stringFromOptions:input key:@"token" withDefault:nil];
    NSString *url = [RCTAppleHealthKit stringFromOptions:input key:@"url" withDefault:nil];
    NSString *vendorName = [RCTAppleHealthKit stringFromOptions:input key:@"vendorName" withDefault:nil];
    NSString *deviceId = [RCTAppleHealthKit stringFromOptions:input key:@"deviceId" withDefault:nil];

    NSUInteger vendorId = [RCTAppleHealthKit uintFromOptions:input key:@"vendorId" withDefault:0];

    if (!sproutToken || !url || !vendorId || !vendorName || !deviceId) {
        NSLog(@"One of required paramter not supplied: token/url/vendorId/vendorName/deviceId");
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"One of required paramter not supplied: token/url/vendorId/vendorName/deviceId" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"com.sproutatwork" code:-1 userInfo:errorDetail];
        callback(@[RCTMakeError(@"One of required paramter not supplied: token/url/vendorId/vendorName/deviceId", error, nil)]);
        return;
    }
    
    // Store to defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:sproutToken forKey:@"token"];
    [defaults setValue:url forKey:@"url"];
    [defaults setValue:vendorName forKey:@"vendorName"];
    [defaults setValue:deviceId forKey:@"deviceId"];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:vendorId] forKey:@"vendorId"];

    HKSampleType *sampleType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    HKUpdateFrequency frequency = HKUpdateFrequencyHourly;
    
    [self.healthStore enableBackgroundDeliveryForType:sampleType frequency:frequency withCompletion:^(BOOL success, NSError *error) {}];
    
    HKQuery *backgroundquery = [[HKObserverQuery alloc] initWithSampleType:sampleType predicate:nil updateHandler:
    ^void(HKObserverQuery *observerQuery, HKObserverQueryCompletionHandler completionHandler, NSError *error) {
        NSLog(@"HealthKit native received a background call");
        if (completionHandler) {
            completionHandler();
        }
        
        // Added to sync when app is closed.
        UIBackgroundTaskIdentifier __block taskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            if (taskID != UIBackgroundTaskInvalid) {
                [[UIApplication sharedApplication] endBackgroundTask:taskID];
                taskID = UIBackgroundTaskInvalid;
            }
        }];

        NSInteger _vendorId = [defaults integerForKey:@"vendorId"];
        NSString *_vendorName = [defaults stringForKey:@"vendorName"];
        NSString *_deviecId = [defaults stringForKey:@"deviceId"];
        NSString *_sproutToken = [defaults stringForKey:@"token"];
        NSString *_url = [defaults stringForKey:@"url"];
        if (!_sproutToken) {
            if (taskID != UIBackgroundTaskInvalid) {
                NSLog(@"HealthKit native endBackgroundTask no token");
                [[UIApplication sharedApplication] endBackgroundTask:taskID];
                taskID = UIBackgroundTaskInvalid;
            }
            return;
        }
        double lastHealthKitSync = [defaults doubleForKey:@"lastHealthKitSync"];
        NSDate *date = [NSDate date];
        NSTimeInterval now = [date timeIntervalSince1970];
        if (lastHealthKitSync + 60 > now) {
            NSLog(@"HealthKit just sync'ed, skipping");
            if (taskID != UIBackgroundTaskInvalid) {
                NSLog(@"HealthKit native endBackgroundTask");
                [[UIApplication sharedApplication] endBackgroundTask:taskID];
                taskID = UIBackgroundTaskInvalid;
            }
            return;
        }
        [defaults setDouble:now forKey:@"lastHealthKitSync"];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *interval = [[NSDateComponents alloc] init];
        interval.day = 1;
        NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                         fromDate:[NSDate date]];
        anchorComponents.hour = 0;
        NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
        HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        // Create the query
        HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                              quantitySamplePredicate:nil
                                              options:HKStatisticsOptionCumulativeSum
                                              anchorDate:anchorDate
                                              intervalComponents:interval];
        // Set the results handler
        query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
            if (error) {
                // Perform proper error handling here
                NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
                if (taskID != UIBackgroundTaskInvalid) {
                    NSLog(@"HealthKit native endBackgroundTask");
                    [[UIApplication sharedApplication] endBackgroundTask:taskID];
                    taskID = UIBackgroundTaskInvalid;
                }
                return;
            }
            
            NSDate *endDate = [NSDate date];
            NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:endDate options:0];

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            [dateFormatter setLocale:enUSPOSIXLocale];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
            
            NSMutableArray *activity = [[NSMutableArray alloc] init];
            // Plot the daily step counts over the past 7 days
            [results enumerateStatisticsFromDate:startDate toDate:endDate
                withBlock:^(HKStatistics *result, BOOL *stop) {
                    HKQuantity *quantity = result.sumQuantity;
                    if (quantity) {
                        NSMutableDictionary *dayActivity = [[NSMutableDictionary alloc] init];
                        [dayActivity setObject:@"healthKit" forKey:@"source"];
                        [dayActivity setObject:@"steps" forKey:@"type"];
                        [dayActivity setObject:@NO forKey:@"manual"];
                        
                        NSString *startDateString = [dateFormatter stringFromDate:result.startDate];
                        NSString *endDateString = [dateFormatter stringFromDate:result.endDate];

                        [dayActivity setObject:startDateString forKey:@"startTime"];
                        [dayActivity setObject:endDateString forKey:@"endTime"];
                        
                        NSInteger offset = [[NSTimeZone localTimeZone] secondsFromGMT] / 60;    // In minutes
                        NSInteger offsetHr = (NSInteger) offset / 60;
                        NSInteger offsetMin = (NSInteger) offset % 60;
                        NSString *offsetString;
                        if (offsetHr < 0) {
                            offsetString = [NSString stringWithFormat:@"%+03d:%02d", offsetHr, offsetMin];
                        }
                        else {
                            offsetString = [NSString stringWithFormat:@"%02d:%02d", offsetHr, offsetMin];
                        }
                        
                        [dayActivity setObject:offsetString forKey:@"offset"];

                        int stepsValue = (int) [quantity doubleValueForUnit:[HKUnit countUnit]];
                        
                        NSDictionary *metrics = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:stepsValue] forKey:@"steps"];
                        [dayActivity setObject:metrics forKey:@"metrics"];
                        NSLog(@"%@: %d", startDateString, stepsValue);
                        
                        [activity addObject:dayActivity];
                    }
                }
            ];

            //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _url, @"client_logs"]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _url, @"users/apps_devices"]];
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            request.HTTPMethod = @"POST";
            [request addValue:[NSString stringWithFormat:@"sprout-token %@", _sproutToken] forHTTPHeaderField:@"Authorization"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            NSDictionary *submitData = [NSDictionary dictionaryWithObject:activity forKey:@"activity"];
            
            NSMutableDictionary *submit = [[NSMutableDictionary alloc] init];
            [submit setObject:submitData forKey:@"data"];
            [submit setObject:_deviecId forKey:@"deviceId"];
            [submit setObject:@"iOSHealth" forKey:@"vendorName"];
            [submit setObject:[NSNumber numberWithUnsignedInteger:_vendorId] forKey:@"vendorId"];
            
            NSData *postData = [NSJSONSerialization dataWithJSONObject:submit options:0 error:nil];
            [request setHTTPBody:postData];
            
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    // Handle response here
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    if (!error && httpResp.statusCode == 201) {
                        NSLog(@"HealthKit native logging completed...");
                    } else {
                        NSLog(@"HealthKit native logging failed...");
                    }
                    if (taskID != UIBackgroundTaskInvalid) {
                        NSLog(@"HealthKit native endBackgroundTask");
                        [[UIApplication sharedApplication] endBackgroundTask:taskID];
                        taskID = UIBackgroundTaskInvalid;
                    }
                }];
            [postDataTask resume];
        };
        
        [self.healthStore executeQuery:query];
    }];
    
    [self.healthStore executeQuery:backgroundquery];
}

- (void)fitness_initializeStepEventObserver:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKSampleType *sampleType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    HKObserverQuery *query =
    [[HKObserverQuery alloc]
     initWithSampleType:sampleType
     predicate:nil
     updateHandler:^(HKObserverQuery *query,
                     HKObserverQueryCompletionHandler completionHandler,
                     NSError *error) {
         
         if (error) {
             // Perform Proper Error Handling Here...
             NSLog(@"*** An error occured while setting up the stepCount observer. %@ ***", error.localizedDescription);
             callback(@[RCTMakeError(@"An error occured while setting up the stepCount observer", error, nil)]);
             return;
         }
         
         // Added to sync when app is closed.
         UIBackgroundTaskIdentifier __block taskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
             if (taskID != UIBackgroundTaskInvalid) {
                 [[UIApplication sharedApplication] endBackgroundTask:taskID];
                 taskID = UIBackgroundTaskInvalid;
             }
         }];
         
         [self.bridge.eventDispatcher sendAppEventWithName:@"change:steps"
                                                      body:@{@"name": @"change:steps"}];
         
         // If you have subscribed for background updates you must call the completion handler here.
         // completionHandler();
         
     }];
    
    [self.healthStore executeQuery:query];
}


- (void)fitness_getDistanceWalkingRunningOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double distance, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!distance) {
            NSLog(@"ERROR getting DistanceWalkingRunning: %@", error);
            callback(@[RCTMakeError(@"ERROR getting DistanceWalkingRunning", error, nil)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(distance),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };


        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyDistanceWalkingRunningSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];

    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}


- (void)fitness_getDistanceCyclingOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double distance, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!distance) {
            NSLog(@"ERROR getting DistanceCycling: %@", error);
            callback(@[RCTMakeError(@"ERROR getting DistanceCycling", error, nil)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(distance),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };

        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyDistanceCyclingSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];

    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}

- (void)fitness_getFlightsClimbedOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [HKUnit countUnit];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double count, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!count) {
            NSLog(@"ERROR getting FlightsClimbed: %@", error);
            callback(@[RCTMakeError(@"ERROR getting FlightsClimbed", error, nil), @(count)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(count),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };

        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyFlightsClimbedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];

    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}

@end
