//
//  NSArray+DeepMutableCopy.m
//  BarCode
//
//  Created by ghostwasd on 13-2-12.
//  Copyright (c) 2013年 ghostwasd. All rights reserved.
//

#import "NSArray+DeepMutableCopy.h"

@implementation NSArray (DeepMutableCopy)

- (NSMutableArray *)deepMutableCopy
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id item in self)
    {
        if ([item respondsToSelector:@selector(deepMutableCopy)])
        {
            [array addObject:[item deepMutableCopy]];
        }
        else
        {
            [array addObject:item];
        }
    }
    
    return array;
}

@end
