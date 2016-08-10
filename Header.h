#import <Foundation/Foundation.h>

@interface SBReachabilityTrigger : NSObject
- (void)biometricEventMonitor:(id)monitor handleBiometricEvent:(unsigned)event;
@end

@interface SBReachabilityHoldTrigger : SBReachabilityTrigger
@end

@interface SBReachabilityTapTrigger : SBReachabilityTrigger
@end

@interface SBReachabilityManager : NSObject {
	SBReachabilityTrigger *_trigger;
}
@property(readonly, nonatomic) BOOL reachabilityModeActive;
+ (SBReachabilityManager *)sharedInstance;
+ (BOOL)reachabilitySupported;
- (void)triggerDidTriggerReachability:(id)arg1;
- (void)_handleReachabilityActivated;
- (void)_handleReachabilityDeactivated;
@end