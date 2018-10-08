

#import <UIKit/UIKit.h>
#import "FNSurveyType.h"
#import "FNPhaseView.h"
#import "JMRequestObject.h"
#import "FNBaseController.h"

@interface FNSurveyController : FNBaseController

@property (nonatomic, strong) FNPhaseView *vphase;
@property (nonatomic, strong) UIScrollView *scContent;
@property (nonatomic, strong) NSMutableArray *arrayQuestionViews;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) JMRequestObject *uploadRequest;
@property (nonatomic, strong) NSMutableDictionary *dictSurvey;

@end
