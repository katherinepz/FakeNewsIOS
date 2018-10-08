//
//  NDWaitingView.h
//  NextDress
//
//  Created by ghost on 12-7-31.
//  Copyright 2012年 ghost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NDWaitingView : UIView

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

+ (NDWaitingView *)shareWaitingView;
- (void)show;
- (void)hide;
- (BOOL)isShowing;

@end
