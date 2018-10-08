//
//  ZYBarButtonItem.m
//  iZiyou
//
//  Created by Sina on 12-2-16.
//  Copyright (c) 2012年 ghost. All rights reserved.
//

#import "ZYBarButtonItem.h"

@implementation ZYBarButtonItem

- (id)initWithNormalImage:(UIImage *)normalImage highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action
{
    CGRect frame = CGRectZero;
    frame.size = normalImage.size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    button.showsTouchWhenHighlighted = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

- (id)initBackStyleWithTarget:(id)target action:(SEL)action
{
    UIImage *ivBack = [UIImage imageNamed:@"ic_title_bar_back.png"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setImage:ivBack forState:UIControlStateNormal];
    [button setTitle:@" 返回" forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

@end
