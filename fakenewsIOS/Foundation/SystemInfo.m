//
//  SystemInfo.m
//  TaoJin
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 YueBao. All rights reserved.
//

#import "SystemInfo.h"

const CGFloat FG_NAV_BAR_HEIGHT = 44.0f;
const CGFloat FG_SEARCH_BAR_HEIGHT = 44.0f;
const CGFloat FG_TAB_BAR_HEIGHT = 49.0f;
const CGFloat FG_STATUS_BAR_HEIGHT = 20.0f;
const CGFloat FG_TOOL_BAR_HEIGHT = 44.0f;

CGFloat navBarHeight(UIViewController *viewController)
{
    UINavigationBar *navBar = viewController.navigationController.navigationBar;
    return navBar.frame.size.height;
}

CGFloat searchBarHeight()
{
    static CGFloat searchBarHeight = 0.0f;
    if (searchBarHeight == 0.0f)
    {
        UITabBar *searchBar = [[UITabBar alloc] init];
        searchBarHeight = searchBar.frame.size.height;
    };
    
    return searchBarHeight;
}

CGFloat tabBarHeight(UIViewController *viewController)
{
    UITabBar *tabBar = viewController.tabBarController.tabBar;
    return tabBar.frame.size.height;
}

//CGFloat tabBarHeight()
//{
//    static CGFloat tabBarHeight = 0.0f;
//    if (tabBarHeight == 0.0f)
//    {
//        UITabBar *tabBar = [[UITabBar alloc] init];
//        tabBarHeight = tabBar.frame.size.height;
//    };
//    
//    return tabBarHeight;
//}

CGFloat statusBarHeight()
{
    return MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height);
}

CGFloat screenHeight()
{
    static float screenHeight = 0.0f;
    
    if (screenHeight == 0.0f)
    {
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
    }
    
    return screenHeight;
}

CGFloat screenHeightDots()
{
    return [[UIScreen mainScreen] scale] * screenHeight();
}

CGFloat screenWidth()
{
    static float screenWidth = 0.0f;
    
    if (screenWidth == 0.0f)
    {
        screenWidth = [[UIScreen mainScreen] bounds].size.width;
    }
    
    return screenWidth;
}

CGFloat availableHeightWithStatusBar()
{
    return screenHeight() - statusBarHeight();
}

CGFloat availableHeightWithStatusBarAndNavBar(UIViewController *controller)
{
    return screenHeight() - statusBarHeight() - navBarHeight(controller);
}

CGFloat availableHeightWithStatusBarAndNavBarAndTabBar(UIViewController *controller)
{
    return screenHeight() - statusBarHeight() - navBarHeight(controller) - tabBarHeight(controller);
}

NSUInteger DeviceSystemMajorVersion()
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
}

