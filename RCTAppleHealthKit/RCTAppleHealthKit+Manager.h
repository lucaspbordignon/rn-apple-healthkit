//
//  RCTAppleHealthkitManager.h
//  RCTAppleHealthKit
//
//  Created by Hammad Ahmad on 8/13/20.
//  Copyright © 2020 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Manager)

+ (RCTAppleHealthkitManager *)sharedManager;

- (void)setupHKListener;

@end
