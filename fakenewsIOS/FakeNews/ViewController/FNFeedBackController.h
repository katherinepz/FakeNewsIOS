

#import "FNBaseController.h"
#import "FNSurveyType.h"
#import "FNPhaseView.h"
#import "JMRequestObject.h"
#import "LCChartView.h"
#import "JMRequestObject.h"

@interface FNFeedBackController : FNBaseController

@property (nonatomic, strong) FNPhaseView *vphase;
@property (nonatomic, strong) UIScrollView *scContent;
@property (nonatomic, strong) UILabel *lblTip1;
@property (nonatomic, strong) UILabel *lblScore;
@property (nonatomic, strong) UILabel *lblTip2;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblTip3;
@property (strong, nonatomic) LCChartView *chartViewBar;
@property (nonatomic, strong) UIButton *btnLeave;
@property (nonatomic, strong) JMRequestObject *resultRequest;
@property (nonatomic, strong) UIButton *btnRefresh;

@end
