//
//  JMAPI.h
//  Decorate
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import "ASIFormDataRequest.h"

extern const NSString *JM_API_ADDRESS;
extern const NSString *JM_FILE_ADDRESS;

typedef enum JM_API_IMAGE_SIZE
{
    JM_API_IMAGE_SIZE_FULL,
    JM_API_IMAGE_SIZE_LARGE,
    JM_API_IMAGE_SIZE_MEDIUM,
    JM_API_IMAGE_SIZE_SMALL,
}
JM_API_IMAGE_SIZE;

@interface JMAPI : NSObject

+ (BOOL)isRequestResultSuccess:(NSDictionary *)dictResult;
+ (NSString *)API_AddressWithPath:(NSString *)path;
+ (ASIHTTPRequest *)requestWithUrl:(NSString *)url postKeys:(NSArray *)keys postValues:(NSArray *)values;

@end
