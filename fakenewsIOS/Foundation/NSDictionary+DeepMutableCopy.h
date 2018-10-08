//
//  NSDictionary+DeepMutableCopy.h
//  BarCode
//
//  Created by ghostwasd on 13-2-12.
//  Copyright (c) 2013年 ghostwasd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DeepMutableCopy)

- (NSMutableDictionary *)deepMutableCopy;

@end

@interface NSMutableDictionary (Merge)

- (void)mergeDictionary:(NSDictionary *)dictionary;

@end
