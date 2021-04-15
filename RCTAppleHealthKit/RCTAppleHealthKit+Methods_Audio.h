//
//  RCTAppleHealthKit+Methods_Audio.h
//  RCTAppleHealthKit
//
//  Created by Udi Falkson on 2019-09-08.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Audio)

- (void)audio_getEnvironmentalSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)audio_getAvgDecibelsInDateRange:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
