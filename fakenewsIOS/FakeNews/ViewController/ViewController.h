

#import <UIKit/UIKit.h>
#import "FNDropDownList.h"
#import "FNPhaseView.h"
#import "FNChoiceView.h"
#import "FNQuestionView.h"
#import "JMRequestObject.h"
#import "FNBaseController.h"
#import "FNPhase2QEnd.h"

@interface ViewController : FNBaseController <FNChoiceViewDelegate>

@property (nonatomic, strong) UIScrollView *scContent;
@property (nonatomic, strong) FNDropDownList *ddlist;
@property (nonatomic, strong) FNPhaseView *vphase;
@property (nonatomic, strong) FNQuestionView *qview;
@property (nonatomic, strong) FNChoiceView *vChoice;
@property (nonatomic, assign) FN_PHASE phase;
@property (nonatomic, strong) FNPhase2QEnd *vP2End;

@property (nonatomic, strong) JMRequestObject *questionRequest;
@property (nonatomic, strong) NSMutableDictionary *dictNewsDetails;
@property (nonatomic, strong) NSString *phaseStartTime;

@property (nonatomic, strong) NSMutableArray *arrayAnswers;
@property (nonatomic, strong) NSMutableDictionary *uploadJson;

@property (nonatomic, assign) NSInteger currentQuestionIndex;
@property (nonatomic, strong) NSDate *questionBeginTime;
@property (nonatomic, assign) BOOL continueTrail;

@end

