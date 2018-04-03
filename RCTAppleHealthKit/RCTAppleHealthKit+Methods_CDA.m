//
//  RCTAppleHealthKit+Methods_CDA.m
//  RCTAppleHealthKit
//
//  Created by Andrey on 03/04/2018.
//  Copyright © 2018 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_CDA.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_CDA)

- (void)cda_saveCDADocument:(NSString *)xml callback:(RCTResponseSenderBlock)callback
{
    NSDate *today = [NSDate new];
    NSError *error = nil;
    HKCDADocumentSample *sample = [HKCDADocumentSample CDADocumentSampleWithData:[xml dataUsingEncoding:NSUTF8StringEncoding] startDate:today endDate:today metadata:nil validationError:&error];
    sample.
    if (!error) {
        callback(@[RCTMakeError(error.userInfo[HKDetailedCDAValidationErrorKey], error, nil)]);
        return;
    }
    
    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving CDA document: %@.", error);
            callback(@[RCTMakeError(@"error saving CDA document", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(YES)]);
    }];
}

@end
