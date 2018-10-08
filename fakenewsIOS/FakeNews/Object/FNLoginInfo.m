

#import "FNLoginInfo.h"
#import "DEBUGLOG.h"
#import "NSDictionary+ValueType.h"
#import "NSDictionary+DeepMutableCopy.h"
#import "JMRequestObject.h"
#import "API.h"
#import "NDWaitingView.h"

const NSString *FN_LAST_CODE = @"FN_LAST_CODE";
const NSString *FN_LAST_TIME = @"FN_LAST_TIME";

@implementation FNLoginInfo

+ (FNLoginInfo *)shareLoginInfo
{
    static FNLoginInfo *g_shareLoginInfo = nil;
    
    if (g_shareLoginInfo == nil) {
        @synchronized([FNLoginInfo class])
        {
            if (g_shareLoginInfo == nil) {
                g_shareLoginInfo = [[FNLoginInfo alloc] init];
            }
        }
    }
    
    return g_shareLoginInfo;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.dictTotalAnswers = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)saveToLocalMemory
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:_code forKey:@"code"];
    [dict setObject:_token forKey:@"token"];
    [dict setObject:_arrayNewsId forKey:@"newsId"];
    [dict setObject:_dictTotalAnswers forKey:@"answers"];
    [dict setObject:[NSNumber numberWithInteger:_phase] forKey:@"phase"];
    
    NSString *plist = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _code]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plist]) {
        [[NSFileManager defaultManager] removeItemAtPath:plist error:nil];
    }
    [dict writeToFile:plist atomically:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:_code forKey:FN_LAST_CODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)hasLastTrail
{
    NSDate *lastTime = [[NSUserDefaults standardUserDefaults] objectForKey:FN_LAST_TIME];
    
    if (lastTime == nil || [[NSDate date]timeIntervalSinceDate:lastTime] > 24 * 60 * 60)
    {
        [self clearLastInfo];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)clearLastInfo
{
    NSString *lastCode = [[NSUserDefaults standardUserDefaults] objectForKey:FN_LAST_CODE];
    NSString *plist = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", lastCode]];
    [[NSFileManager defaultManager] removeItemAtPath:plist error:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FN_LAST_CODE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FN_LAST_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self clearAndExit];
}

- (BOOL)loadLastInfoFromLocalMemory
{
    NSString *lastCode = [[NSUserDefaults standardUserDefaults] objectForKey:FN_LAST_CODE];
    if (lastCode.length > 0)
    {
        NSString *plist = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", lastCode]];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plist];
        
        DEBUGLOG(@"%@", plist);
        
        self.code = lastCode;
        self.token = [dict stringForKeyPath:@"token"];
        self.arrayNewsId = [dict arrayForKeyPath:@"newsId"];
        self.dictTotalAnswers = [[dict dictForKeyPath:@"answers"] deepMutableCopy];
        self.phase = [dict integerForKeyPath:@"phase"];
        return YES;
    }
    
    return NO;
}

- (void)uploadJsonToServer:(void(^)(void))completeBlock
{
    [[NDWaitingView shareWaitingView] show];
    JMRequestObject *request = [[JMRequestObject alloc] init];
    
    [request startRequestWithRequest:^ASIHTTPRequest *{
        return [JMAPI uploadTrailJson:_dictTotalAnswers token:_token];
    }
                        successBlock:^(ASIHTTPRequest *request) {
                            
                            [[NDWaitingView shareWaitingView] hide];
                            if (completeBlock != nil) {
                                completeBlock();
                            }
                        }
                           failBlock:^(ASIHTTPRequest *request) {
                               [[NDWaitingView shareWaitingView] hide];
                        }
                               retry:NO];
}

- (void)clearAndExit
{
    self.code = nil;
    self.token = nil;
    self.arrayNewsId = nil;
    self.dictTotalAnswers = [NSMutableDictionary dictionary];
    self.phase = FN_PHASE_1;
}

- (void)caculateScoreAndTime
{
    _totalTime = 0;
    NSInteger totalScore = 0;
    NSArray *arrayP1Answers = [_dictTotalAnswers arrayForKeyPath:@"phase_1.news"];
    for (NSDictionary *dict in arrayP1Answers) {
        NSString *label = [dict stringForKeyPath:@"label"];
        NSInteger score = [dict integerForKeyPath:@"truthRating"];
        
        if ([label isEqualToString:@"TRUE"]) {
            totalScore += score - 1;
        }
        else
        {
            totalScore += 8 - score;
        }
        
        NSInteger time = [dict integerForKeyPath:@"elapsedTime"];
        _totalTime += time;
    }
    
    [_dictTotalAnswers setObject:[NSString stringWithFormat:@"%d", totalScore] forKey:@"score"];
}

/*- (void)generateRandomQuestion
{
    NSInteger i = 0;
    while (i < 30)
    {
        BOOL exist = NO;
        NSInteger num = arc4random() % _arrayNewsId.count;
        NSString *snum = [_arrayNewsId objectAtIndex:num];
        
        for (NSInteger j = 0; j < _arrayRandomQuestions.count; ++ j)
        {
            NSString *question = [_arrayRandomQuestions objectAtIndex:j];
            if ([question isEqualToString:snum]) {
                exist = YES;
                break;
            }
        }
        
        if (!exist) {
            [_arrayRandomQuestions addObject:snum];
            ++ i;
        }
    }
    
    DEBUGLOG(@"%@", [_arrayRandomQuestions description]);
}*/

@end
