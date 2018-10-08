

#import "JMAPI+ALL.h"
#import "DEBUGLOG.h"

@implementation JMAPI (ALL)

+ (ASIHTTPRequest *)getCodeWithUsername:(NSString *)username
                               Password:(NSString *)password
{
    NSMutableArray *arrayPostKeys = [NSMutableArray array];
    NSMutableArray *arrayPostValues = [NSMutableArray array];
    
    if (username.length > 0)
    {
        [arrayPostKeys addObject:@"username"];
        [arrayPostValues addObject:username];
    }
    
    if (password.length > 0)
    {
        [arrayPostKeys addObject:@""];
        [arrayPostValues addObject:password];
    }
    
    return [JMAPI requestWithUrl:[JMAPI API_AddressWithPath:@""] postKeys:arrayPostKeys postValues:arrayPostValues];
}

+ (ASIHTTPRequest *)loginWithLoginCode:(NSString *)logincode
{
    NSString *path = [NSString stringWithFormat:@"%@user/login/%@", JM_API_ADDRESS, logincode];
    
//    ASIHTTPRequest *request = [JMAPI requestWithUrl:[JMAPI API_AddressWithPath:path] postKeys:nil postValues:nil];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    DEBUGLOG(@"%@", path);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    return request;
}

+ (ASIHTTPRequest *)uploadTrailJson:(NSDictionary *)json
                              token:(NSString *)token
{
//    NSString *author = [NSString stringWithFormat:@"Bearer %@", token];
//
//    ASIHTTPRequest *request = [JMAPI requestWithUrl:[JMAPI API_AddressWithPath:@"user/question/"] postKeys:nil postValues:nil];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request addRequestHeader:@"Authorization" value:author];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
//    [request setPostBody:[NSMutableData dataWithData:data]];
    
    NSString *author = [NSString stringWithFormat:@"Bearer %@", token];
    NSString *path = [NSString stringWithFormat:@"%@user/question", JM_API_ADDRESS];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Authorization" value:author];
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    [request setPostBody:[NSMutableData dataWithData:data]];
    
    return request;
}

+ (ASIHTTPRequest *)getNewsInfoWithNewsId:(NSString *)NewsId
                                    token:(NSString *)token
{
    NSString *author = [NSString stringWithFormat:@"Bearer %@", token];
    NSString *path = [NSString stringWithFormat:@"%@user/question/%@", JM_API_ADDRESS, NewsId];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Authorization" value:author];
    
    return request;
}

+ (ASIHTTPRequest *)surveyWithJson:(NSDictionary *)json
                             token:(NSString *)token
{
    NSString *author = [NSString stringWithFormat:@"Bearer %@", token];
    
    ASIHTTPRequest *request = [JMAPI requestWithUrl:[JMAPI API_AddressWithPath:@"user/survey/"] postKeys:nil postValues:nil];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Authorization" value:author];
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    [request setPostBody:[NSMutableData dataWithData:data]];
    return request;
}

+ (ASIHTTPRequest *)getUserResultWithToken:(NSString *)token
{
    NSString *author = [NSString stringWithFormat:@"Bearer %@", token];
    NSString *path = [NSString stringWithFormat:@"%@user/result", JM_API_ADDRESS];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:path]];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Authorization" value:author];
    return request;
}

@end
