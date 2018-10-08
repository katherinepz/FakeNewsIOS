//
//  NSMutableDictionary+SetObject.m
//  Decorate
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import "NSMutableDictionary+SetObject.h"

@implementation NSMutableDictionary (SetObject)

- (void)setNotNullObject:(id)object key:(id)key
{
    if (object == nil)
    {
        return;
    }
    
    if ([object isKindOfClass:[NSNull class]])
    {
        return;
    }
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *value = (NSString *)object;
        
        if (value.length == 0)
        {
            return;
        }
    }
    
    [self setObject:object forKey:key];
}

@end
