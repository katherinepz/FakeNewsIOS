

#import <Foundation/Foundation.h>
#import "FNPhase.h"

extern const NSString *FN_LAST_CODE;
extern const NSString *FN_LAST_TIME;


@interface FNLoginInfo : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSArray *arrayNewsId;
@property (nonatomic, strong) NSMutableDictionary *dictTotalAnswers;
@property (nonatomic, assign) FN_PHASE phase;
@property (nonatomic, assign) NSInteger totalTime;
//@property (nonatomic, strong) NSMutableArray *arrayRandomQuestions;

+ (FNLoginInfo *)shareLoginInfo;
- (void)saveToLocalMemory;
- (BOOL)hasLastTrail;
- (BOOL)loadLastInfoFromLocalMemory;
- (void)clearLastInfo;
- (void)caculateScoreAndTime;

- (void)uploadJsonToServer:(void(^)(void))completeBlock;

@end
