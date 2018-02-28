//
//  RCTAppleHealthKit+Methods_Workout.m
//  RCTAppleHealthKit
//
//  Created by Ward van Teijlingen on 19/11/2017.
//  Copyright © 2017 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Workout.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Workout)

- (void)workout_saveWorkout:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
	HKWorkoutActivityType activityType = [RCTAppleHealthKit hkWorkoutActivityTypeFromOptions:input key:@"type" withDefault:HKWorkoutActivityTypeOther];
	NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
	NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:nil];
	NSTimeInterval duration = [RCTAppleHealthKit doubleFromOptions:input key:@"duration" withDefault:(NSTimeInterval)0];
	HKQuantity *totalEnergyBurned = [self quantityFromOptions:input valueKey:@"energyBurned" unitKey:@"energyBurnedUnit"];
	HKQuantity *totalDistance = [self quantityFromOptions:input valueKey:@"distance" unitKey:@"distanceUnit"];
	
	HKWorkout *workout = [HKWorkout
												workoutWithActivityType:activityType
												startDate:startDate
												endDate:endDate
												duration:duration
												totalEnergyBurned:totalEnergyBurned
												totalDistance:totalDistance
												metadata:nil];

	[self.healthStore saveObject:workout withCompletion:^(BOOL success, NSError * _Nullable error) {
		if (!success) {
			NSLog(@"An error occured saving the workout %@. The error was: %@.", workout, error);
			callback(@[RCTMakeError(@"An error occured saving the workout", error, nil)]);
			return;
		}
		callback(@[[NSNull null], workout.UUID.UUIDString]);
	}];
}

-(HKQuantity *)quantityFromOptions:(NSDictionary *)input valueKey:(NSString *)valueKey unitKey:(NSString *)unitKey {
	double value = [RCTAppleHealthKit doubleFromOptions:input key:valueKey withDefault:-1];
	HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:unitKey withDefault:nil];
	
	if(unit != nil && value != -1) {
		return [HKQuantity quantityWithUnit:unit doubleValue:value];
	} else {
		return nil;
	}
}
@end
