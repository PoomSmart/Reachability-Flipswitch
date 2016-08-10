#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "Header.h"

static NSString *const reachabilityKey = @"PS_SBReallyDisableReachability";

@interface ReachabilitySwitch : NSObject
@end

@implementation ReachabilitySwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:reachabilityKey] ? FSSwitchStateOff : FSSwitchStateOn;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	[[NSUserDefaults standardUserDefaults] setBool:newState != FSSwitchStateOn forKey:reachabilityKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end

%hook SBReachabilityManager

- (void)triggerDidTriggerReachability:(id)arg1
{
	BOOL disabled = [[NSUserDefaults standardUserDefaults] boolForKey:reachabilityKey];
	if (disabled)
		return;
	%orig;
}

- (void)_handleReachabilityActivated
{
	BOOL disabled = [[NSUserDefaults standardUserDefaults] boolForKey:reachabilityKey];
	if (disabled)
		return;
	%orig;
}

%end

%hook SBReachabilityHoldTrigger

- (void)biometricEventMonitor:(id)monitor handleBiometricEvent:(unsigned)event
{
	BOOL disabled = [[NSUserDefaults standardUserDefaults] boolForKey:reachabilityKey];
	if (disabled)
		return;
	%orig;
}

%end

%hook SBReachabilityTapTrigger

- (void)biometricEventMonitor:(id)monitor handleBiometricEvent:(unsigned)event
{
	BOOL disabled = [[NSUserDefaults standardUserDefaults] boolForKey:reachabilityKey];
	if (disabled)
		return;
	%orig;
}

%end