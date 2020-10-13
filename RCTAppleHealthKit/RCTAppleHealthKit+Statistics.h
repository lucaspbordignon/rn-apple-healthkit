//
//  RCTAppleHealthKit+Statistics.h
//  RCTAppleHealthKit
//
//  Created by Elena Grednikova on 13.10.2020.
//  Copyright © 2020 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Statistics)

- (nullable HKQuantity *)statistics_getQuantity:(NSString *)key result:(HKStatistics *)result;
- (HKStatisticsOptions)statistics_getStatisticsType:(NSString *)key;
- (nullable HKQuantityType *)statistics_getQuantityType:(NSString *)key;
- (void)statistics_fetchStatistics:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback;

@end
