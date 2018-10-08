//
//  JMRequestObject.h
//  Decorate
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface JMRequestObject : NSObject
{
    ASIHTTPRequest *currentRequest;
}

- (void)clear;
- (void)startRequestWithRequest:(ASIHTTPRequest *(^)())requestBlock
                   successBlock:(void(^)(ASIHTTPRequest *request))successBlock
                      failBlock:(void(^)(ASIHTTPRequest *request))failBlock
                          retry:(BOOL)retry;

@end
