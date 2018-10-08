//
//  ZYBarButtonItem.h
//  iZiyou
//
//  Created by Sina on 12-2-16.
//  Copyright (c) 2012年 ghost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBarButtonItem : UIBarButtonItem

- (id)initWithNormalImage:(UIImage *)normalImage highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (id)initBackStyleWithTarget:(id)target action:(SEL)action;

@end
