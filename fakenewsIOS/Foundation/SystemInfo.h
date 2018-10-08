//
//  SystemInfo.h
//  TaoJin
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 YueBao. All rights reserved.
//

#ifndef SystemInfo_h
#define SystemInfo_h

#import <UIKit/UIKit.h>

extern const CGFloat FG_NAV_BAR_HEIGHT;
extern const CGFloat FG_SEARCH_BAR_HEIGHT;
extern const CGFloat FG_TAB_BAR_HEIGHT;
extern const CGFloat FG_STATUS_BAR_HEIGHT;
extern const CGFloat FG_TOOL_BAR_HEIGHT;

CGFloat navBarHeight(UIViewController *viewController);
CGFloat searchBarHeight();
//CGFloat tabBarHeight();
CGFloat tabBarHeight(UIViewController *viewController);
CGFloat statusBarHeight();

CGFloat screenHeight();
CGFloat screenHeightDots();
CGFloat screenWidth();
CGFloat availableHeightWithStatusBar();
CGFloat availableHeightWithStatusBarAndNavBar(UIViewController *controller);
CGFloat availableHeightWithStatusBarAndNavBarAndTabBar(UIViewController *controller);

NSUInteger DeviceSystemMajorVersion();
#define IOS_VERSION_GREATER_OR_EQUAL_THAN_10 (DeviceSystemMajorVersion() >= 10)
#define IOS_VERSION_LOWER_THAN_10 (DeviceSystemMajorVersion() < 10)
#define IOS_VERSION_LOWER_THAN_7 (DeviceSystemMajorVersion() < 7)
#define IOS_VERSION_EQUAL_7 (DeviceSystemMajorVersion() == 7)
#define IOS_VERSION_GREATER_OR_EQUAL_THAN_7 (DeviceSystemMajorVersion() >= 7)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define __kScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define __kScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_MAX_LENGTH (MAX(__kScreenWidth, __kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(__kScreenWidth, __kScreenHeight))

#define IS_IPHONE_PLUS (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif /* SystemInfo_h */
