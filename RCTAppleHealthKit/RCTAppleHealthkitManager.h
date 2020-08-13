//
//  RCTAppleHealthkitManager.h
//  RCTAppleHealthKit
//
//  Created by Hammad Ahmad on 8/13/20.
//  Copyright © 2020 Greg Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTAppleHealthkitManager : NSObject

+ (RCTAppleHealthkitManager *)sharedManager;

- (void)setupHKListener;

@end
