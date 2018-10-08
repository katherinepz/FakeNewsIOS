//
//  TransitionAnimation.h
//  CCSildeTabBarController
//
//  Created by wsk on 16/8/22.
//  Copyright © 2016年 cyd. All rights reserved.
//

@import UIKit;

typedef enum TRANSITION_END_STATE
{
    TRANSITION_END_STATE_LEFT = -1,
    TRANSITION_END_STATE_RIGHT = 1,
}
TRANSITION_END_STATE;

@protocol TransitionAnimationDelegate;

@interface TransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (nonatomic, readwrite) UIRectEdge targetEdge;
@property (nonatomic, assign) id<TransitionAnimationDelegate> delegate;

@end

@protocol TransitionAnimationDelegate <NSObject>

- (void)TransitionDidEndWithState:(TRANSITION_END_STATE)state;
- (void)TransitionDidEndToViewController:(UIViewController *)controller;

@end
