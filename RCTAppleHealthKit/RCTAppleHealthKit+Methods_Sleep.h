//
//  RCTAppleHealthKit+Methods_Sleep.h
//  RCTAppleHealthKit
//
//  Maintained by Terrillo Wallson 2016-11-06.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Sleep)

- (void)sleep_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
