//
//  NSDictionary+DeepMutableCopy.m
//  BarCode
//
//  Created by ghostwasd on 13-2-12.
//  Copyright (c) 2013年 ghostwasd. All rights reserved.
//

#import "NSDictionary+DeepMutableCopy.h"

@implementation NSDictionary (DeepMutableCopy)

- (NSMutableDictionary *)deepMutableCopy
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:self.count];
    
    for (id key in self)
    {
        id item = [self objectForKey:key];
        
        if ([item respondsToSelector:@selector(deepMutableCopy)])
        {
            [dictionary setObject:[item deepMutableCopy] forKey:key];
        }
        else
        {
            [dictionary setObject:item forKey:key];
        }
    }
    
    return dictionary;
}

@end

@implementation NSMutableDictionary (Merge)

- (void)mergeDictionary:(NSDictionary *)dictionary
{
    for (id key in dictionary)
    {
        id object = [dictionary objectForKey:key];
        
        if ([object isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *object_self = [self objectForKey:key];
            
            if (object_self == nil)
            {
                [self setObject:[object deepMutableCopy] forKey:key];
            }
            else
            {
                [object_self mergeDictionary:object];
            }
        }
        else if ([object isKindOfClass:[NSArray class]])
        {
            [self setObject:[object deepMutableCopy] forKey:key];
        }
        else
        {
            [self setObject:object forKey:key];
        }
    }
}

@end
