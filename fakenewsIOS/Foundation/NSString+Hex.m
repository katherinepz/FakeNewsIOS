//
//  NSString+Hex.m
//  QingMai
//
//  Created by ghostwasd on 13-8-30.
//  Copyright (c) 2013年 ZiYou. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)

- (int)hexValue
{
    unichar character =[self characterAtIndex:0];
    
    if (character >= 'a' && character <= 'f')
    {
        return character - 'a' + 10;
    }
    else if (character >= 'A' && character <= 'F')
    {
        return character - 'A' + 10;
    }
    else if (character >= '0' && character <= '9')
    {
        return character - '0';
    }
    else
    {
        return 0;
    }
}

- (NSUInteger)hexIntegerValue
{
    NSUInteger result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    [scanner setScanLocation:0]; // bypass '#' character
    [scanner scanHexInt:&result];
    
    return result;
}

@end
