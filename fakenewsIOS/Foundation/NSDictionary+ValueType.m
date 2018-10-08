//
//  NSDictionary+ValueType.m
//  BarCode
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 ghostwasd. All rights reserved.
//

#import "NSDictionary+ValueType.h"
#import "NSArray+DeepMutableCopy.h"
#import "NSDictionary+DeepMutableCopy.h"

@implementation NSDictionary (ValueType)

- (id)objectForKeyPath:(NSString *)keyPath
{
    NSObject *object = [self valueForKeyPath:keyPath];
    
    if ([object isKindOfClass:[NSNull class]])
    {
        object = nil;
    }
    
    return object;
}

- (NSString *)moneyForKeyPath:(NSString *)keyPath
{
    id money = [self valueForKeyPath:keyPath];
    if (money == nil)
    {
        return nil;
    }
    else
    {
        return [NSString stringWithFormat:@" ¥ %@ ", money];
    }
}

- (NSString *)yuanForKeyPath:(NSString *)keyPath
{
    id money = [self valueForKeyPath:keyPath];
    if (money == nil)
    {
        return nil;
    }
    else
    {
        return [NSString stringWithFormat:@"¥ %@ ", money];
    }
}

- (NSString *)stringForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    else if ([object respondsToSelector:@selector(stringValue)])
    {
        return [object stringValue];
    }
    else
    {
        if (object == nil)
        {
            return nil;
        }
        else
        {
            return [NSString stringWithFormat:@"%@", object];
        }
    }
}

- (NSString *)getStringForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    else if ([object respondsToSelector:@selector(stringValue)])
    {
        return [object stringValue];
    }
    else
    {
        if (object == nil)
        {
            return @"";
        }
        else
        {
            return [NSString stringWithFormat:@"%@", object];
        }
    }
}

- (double)doubleForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object respondsToSelector:@selector(integerValue)])
    {
        return [object doubleValue];
    }
    else
    {
        return 0.0;
    }
}

- (NSInteger)integerForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object respondsToSelector:@selector(integerValue)])
    {
        return [object integerValue];
    }
    else
    {
        return 0;
    }
}

- (NSArray *)arrayForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSArray class]])
    {
        return object;
    }
    else
    {
        return [NSArray array];
    }
}

- (NSMutableArray *)mutableArrayForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSMutableArray class]])
    {
        return object;
    }
    else
    {
        return nil;
    }
}

- (NSMutableDictionary *)mutableDictionaryForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSMutableDictionary class]])
    {
        return object;
    }
    else
    {
        return nil;
    }
}

- (NSDictionary *)dictForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    else
    {
        return nil;
    }
}

- (BOOL)boolForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object respondsToSelector:@selector(boolValue)])
    {
        return [object boolValue];
    }
    else
    {
        return NO;
    }
}

- (CGFloat)floatForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object respondsToSelector:@selector(floatValue)])
    {
        return [object floatValue];
    }
    else
    {
        return 0;
    }
}

- (NSString *)integerStringForKeyPath:(NSString *)keyPath
{
    id object = [self valueForKeyPath:keyPath];
    if ([object respondsToSelector:@selector(integerValue)])
    {
        NSInteger num = [object integerValue];
        return [NSString stringWithFormat:@"%d", num];
    }
    else
    {
        return @"0";
    }
}

@end
