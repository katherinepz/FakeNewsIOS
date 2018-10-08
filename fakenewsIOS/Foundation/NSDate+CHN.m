//
//  NSDate+CHN.m
//  News
//
//  Created by apple on 18/4/23.
//  Copyright © 2018年 htyl. All rights reserved.
//

#import "NSDate+CHN.h"

@implementation NSDate (CHN)

- (NSString *)timeStampString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.000'Z'"];
    return [dateFormatter stringFromDate:self];
}


@end
