//
//  MPCountdownTimerView.h
//
//  Copyright 2018-2021 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <UIKit/UIKit.h>
#import "MPViewabilityObstruction.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A view that will display a countdown timer and invoke a completion block once the timer has elapsed.
 This view has an intrinsic size, so do not add width and height constaints to it. This is a square view.
 */
@interface MPCountdownTimerView : UIView

/**
 True if the countdown timer is active, or false if it's not.
 */
@property (nonatomic, assign, readonly) BOOL isCountdownActive;

/**
 Initializes a countdown timer view. The timer is not automatically started.
 @param seconds Duration of the timer in seconds. This value must be greater than zero.
 @param completion Completion block that is fired after the timer elapses or is stopped.
 @returns An initialized timer if successful; otherwise nil.
 */
- (instancetype)initWithDuration:(NSTimeInterval)seconds timerCompletion:(void(^)(BOOL hasElapsed))completion;

/**
 Starts the countdown timer. If the timer has already started, calling this method again will do nothing.
 */
- (void)start;

/**
 Stops the timer and optionally invokes the completion block. If the timer hasn't started, calling
 this method will do nothing.
 @param shouldSignalCompletion If YES, then invoke the completion. Do not invoke the completion otherwise.
 */
- (void)stopAndSignalCompletion:(BOOL)shouldSignalCompletion;

/**
 Pause the countdown timer.
 */
- (void)pause;

/**
 Resume the countdown timer.
 */
- (void)resume;

@end

#pragma mark - MPViewabilityObstruction

@interface MPCountdownTimerView (MPViewabilityObstruction) <MPViewabilityObstruction>
/**
 The type of obstruction that this view identifies as.
 */
@property (nonatomic, readonly) MPViewabilityObstructionType viewabilityObstructionType;

/**
 A human-readable name that succinctly describes this obstruction. For convenience, use only the
 predefined constants in `MPViewabilityObstructionName`.
 */
@property (nonatomic, copy, readonly) MPViewabilityObstructionName viewabilityObstructionName;

@end

NS_ASSUME_NONNULL_END
