//
//  NSMutableDictionary+SetObject.h
//  Decorate
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SetObject)

- (void)setNotNullObject:(id)object key:(id)key;

@end
