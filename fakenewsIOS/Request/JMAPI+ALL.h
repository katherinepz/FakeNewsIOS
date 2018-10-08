

#import "JMAPI.h"

@interface JMAPI (ALL)

+ (ASIHTTPRequest *)getCodeWithUsername:(NSString *)username
                               Password:(NSString *)password;
+ (ASIHTTPRequest *)loginWithLoginCode:(NSString *)logincode;
+ (ASIHTTPRequest *)uploadTrailJson:(NSDictionary *)json
                              token:(NSString *)token;
+ (ASIHTTPRequest *)getNewsInfoWithNewsId:(NSString *)NewsId
                                    token:(NSString *)token;
+ (ASIHTTPRequest *)surveyWithJson:(NSDictionary *)json
                             token:(NSString *)token;
+ (ASIHTTPRequest *)getUserResultWithToken:(NSString *)token;

@end
