//
//  RCTAppleHealthKit+Methods_CDA.h
//  RCTAppleHealthKit
//
//  Created by Andrey on 03/04/2018.
//  Copyright © 2018 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_CDA)

- (void)cda_getCDADocuments:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)cda_saveCDADocument:(NSString *)xml callback:(RCTResponseSenderBlock)callback;

@end