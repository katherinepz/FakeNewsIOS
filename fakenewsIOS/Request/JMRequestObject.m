//
//  JMRequestObject.m
//  Decorate
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import "JMRequestObject.h"
#import "DEBUGLOG.h"
@implementation JMRequestObject

- (void)clear
{
    [currentRequest clearDelegatesAndCancel];
    currentRequest = nil;
    
    [currentRequest setCompletionBlock:nil];
    [currentRequest setFailedBlock:nil];
}

- (void)dealloc
{
    [currentRequest setCompletionBlock:nil];
    [currentRequest setFailedBlock:nil];
    
    [currentRequest clearDelegatesAndCancel];
    
    DEBUGLOG(@"JMRequestObject dealloc");
}

- (void)startRequestWithRequest:(ASIHTTPRequest *(^)())requestBlock
                   successBlock:(void(^)(ASIHTTPRequest *request))successBlock
                      failBlock:(void(^)(ASIHTTPRequest *request))failBlock
                          retry:(BOOL)retry
{
    __unsafe_unretained JMRequestObject *__self = self;
    currentRequest = requestBlock();
    
    [currentRequest setCompletionBlock:^{
        
        DEBUGLOG(@"%@", currentRequest.responseString);
        
        if (successBlock != nil)
        {
            successBlock(currentRequest);
        }
        
        [currentRequest clearDelegatesAndCancel];
        currentRequest = nil;
    }];
    
    [currentRequest setFailedBlock:^{
        
        DEBUGLOG(@"%@", currentRequest.responseString);
        
        if (failBlock != nil)
        {
            failBlock(currentRequest);
        }
        
        [currentRequest clearDelegatesAndCancel];
        currentRequest = nil;
        
        if (retry)
        {
            [__self startRequestWithRequest:requestBlock
                               successBlock:successBlock
                                  failBlock:failBlock
                                      retry:retry];
        }
    }];
    
    [currentRequest startAsynchronous];
}

@end
