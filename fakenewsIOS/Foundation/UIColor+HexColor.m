//
//  UIColor+HexColor.m
//  QingMai
//
//  Created by ghostwasd on 13-8-10.
//  Copyright (c) 2013年 ZiYou. All rights reserved.
//

#import "UIColor+HexColor.h"
#import "NSString+Hex.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHexValue:(NSString *)value
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte, alphaByte;
    
    if (nil != value)
    {
        NSScanner *scanner = [NSScanner scannerWithString:value];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    
    if (value.length > 8)
    {
        alphaByte = (unsigned char) (colorCode >> 24);
    }
    else
    {
        alphaByte = 255;
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:(float)alphaByte / 0xff];
    return result;
}

@end
