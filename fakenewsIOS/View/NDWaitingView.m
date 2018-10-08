//
//  NDWaitingView.m
//  NextDress
//
//  Created by ghost on 12-7-31.
//  Copyright 2012年 ghost. All rights reserved.
//

#import "NDWaitingView.h"
#import "AppDelegate.h"

@implementation NDWaitingView

static NDWaitingView *g_waitingView = nil;

+ (NDWaitingView *)shareWaitingView
{
    if (g_waitingView == nil)
    {
        @synchronized([self class])
        {
            if (g_waitingView == nil)
            {
                g_waitingView = [[NDWaitingView alloc] init];
            }
        }
    }
    
    return g_waitingView;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        _view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _view.layer.cornerRadius = 5.0;
        _view.layer.masksToBounds = YES;
        [self addSubview:_view];
        
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.frame = CGRectMake(0, 0, 32, 32);
        _indicator.center= CGPointMake(32, 32);
        [_view addSubview:_indicator];
    }
    
    return self;
}

- (BOOL)isShowing
{
    return self.superview == nil;
}

- (void)show
{
    if (self.superview == nil)
    {
        [_indicator startAnimating];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIWindow *window = appDelegate.window;
        self.frame = window.bounds;
        _view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.42f);
        [window addSubview:self];
    }
}

- (void)hide
{
    [_indicator stopAnimating];
    [self removeFromSuperview];
}

@end
