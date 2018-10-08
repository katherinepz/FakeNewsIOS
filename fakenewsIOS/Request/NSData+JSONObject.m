//
//  NSData+JSONObject.m
//  TaoJin
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 YueBao. All rights reserved.
//

#import "NSData+JSONObject.h"

@implementation NSData (JSONObject)

- (id)JSONObject
{
    return [NSJSONSerialization JSONObjectWithData:self
                                           options:NSJSONReadingMutableContainers
                                             error:nil];
}

@end
