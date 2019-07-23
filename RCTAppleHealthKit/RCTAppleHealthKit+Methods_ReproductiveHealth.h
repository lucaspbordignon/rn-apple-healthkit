#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Vitals)

- (void)reproductiveHealth_getBasalBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)reproductiveHealth_getMenstruationFlowSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)reproductiveHealth_getOvulationTestResultSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)reproductiveHealth_getSexualActivitySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
