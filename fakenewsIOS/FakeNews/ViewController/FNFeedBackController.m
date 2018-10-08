

#import "FNFeedBackController.h"
#import "Masonry.h"
#import "ZYBarButtonItem.h"
#import "FNLoginInfo.h"
#import "SystemInfo.h"
#import "UIColor+HexColor.h"
#import "API.h"
#import "NSData+JSONObject.h"
#import "NSDictionary+ValueType.h"
#import "NDAlertView.h"

@interface FNFeedBackController ()

@end

@implementation FNFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[ZYBarButtonItem alloc] initWithTitle:nil target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[ZYBarButtonItem alloc] initWithTitle:@"      ?" target:self action:@selector(showTip)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnRefresh = [[UIButton alloc] init];
    _btnRefresh.hidden = YES;
    [self.view addSubview:_btnRefresh];
    [_btnRefresh addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnRefresh setTitle:@"Refresh" forState:UIControlStateNormal];
    
    [[FNLoginInfo shareLoginInfo] caculateScoreAndTime];
    [self loadUserResult];
}

- (void)showTip
{
    [NDAlertView alertViewWithTitle:@"Tip"
                            message:@"Your performance score is base on how close you are to the answer.\n\nWhen the answer is TRUE, for your truth rating 1 to 8, you will get 0 to 7 points correspondingly.\nWhen the answer is FALSE, for your truth rating 1 to 8, you will get 7 to 0 points correspondingly.\n\nFor Example, if the answer is TRUE, and your response is 1 (Extremely confident the news is false), then you get 0, because you are completely wrong. If your response is 7 (highly confident the news is true), then you will get 6 points since you are very close to the answer. Vice versa for the FALSE. \n\n The final score will be the accumulated points scaled down to 100."
                  cancelButtonTitle:@"OK"];
}

- (void)refreshClick
{
    [self loadUserResult];
    _btnRefresh.hidden = YES;
}

- (void)loadUserResult
{
    self.resultRequest = [[JMRequestObject alloc] init];
    [_resultRequest startRequestWithRequest:^ASIHTTPRequest *{
        return [JMAPI getUserResultWithToken:[FNLoginInfo shareLoginInfo].token];
    }
                               successBlock:^(ASIHTTPRequest *request) {
                                   
                                   NSDictionary *dict = [request.responseData JSONObject];
                                   NSArray *arrayDoc = [dict arrayForKeyPath:@"doc"];
                                   NSMutableArray *arrayBars = [NSMutableArray array];
                                   NSMutableArray *arrayTitles = [NSMutableArray array];
                                   
                                   NSInteger lastV = 0;
                                   float maxPercent = 0.0f;
                                   NSInteger totalCount = 0;
                                   for (NSDictionary *dict in arrayDoc) {
                                       NSInteger count = [dict integerForKeyPath:@"count"];
                                       totalCount += count;
                                       NSInteger v = [dict integerForKeyPath:@"_id"];
                                       NSString *title = [NSString stringWithFormat:@"%d-%d", lastV, v];
                                       lastV = v;
                                       
                                       [arrayTitles addObject:title];
                                   }
                                   
                                   NSInteger highLightIndex = [[FNLoginInfo shareLoginInfo].dictTotalAnswers integerForKeyPath:@"score"] / 20;
                                   for (NSInteger i = 0; i < arrayDoc.count; ++ i) {
                                       NSDictionary *dict = [arrayDoc objectAtIndex:i];
                                       NSInteger count = [dict integerForKeyPath:@"count"];
                                       float percent = count * 100.0f / totalCount;
                                       if (percent > maxPercent) {
                                           maxPercent = percent;
                                       }
                                       NSString *spercent = [NSString stringWithFormat:@"%.1f", percent];
                                       [arrayBars addObject:spercent];
                                   }
                                   
                                   [self addViewWithResultArray:arrayBars titles:arrayTitles maxValue:maxPercent highLightIndex:highLightIndex];
                               }
                                  failBlock:^(ASIHTTPRequest *request) {
                                      _btnRefresh.hidden = NO;
                                  }
                                      retry:NO];
}

- (void)addViewWithResultArray:(NSArray *)array titles:(NSString *)titles maxValue:(float)maxValue highLightIndex:(NSInteger)highLightIndex
{
    self.scContent = [[UIScrollView alloc] init];
    [_scContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:_scContent];
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    self.vphase = [[FNPhaseView alloc] init];
    [_scContent addSubview:_vphase];
    [_vphase addIcon];
    [_vphase configureWithPhase:FN_PHASE_FEEDBACK index:0 total:[FNLoginInfo shareLoginInfo].arrayNewsId.count];
    [_vphase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_scContent.mas_top);//.offset(88);
        make.height.equalTo(@100);
    }];
    
    self.lblTip1 = [[UILabel alloc] init];
    _lblTip1.numberOfLines = 0;
    [_lblTip1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _lblTip1.text = @"Thank you very much for completing the trail! Here is the feedback for your performance\nYour weighted score out of 100 is:";
    [_scContent addSubview:_lblTip1];
    [_lblTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_vphase.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    self.lblScore = [[UILabel alloc] init];
    _lblScore.numberOfLines = 0;
    [_lblScore setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _lblScore.text = [[FNLoginInfo shareLoginInfo].dictTotalAnswers  stringForKeyPath:@"score"];
    _lblScore.textColor = [UIColor colorWithHexValue:@"FF8888"];
    [_scContent addSubview:_lblScore];
    [_lblScore mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_lblTip1.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    self.lblTip2 = [[UILabel alloc] init];
    _lblTip2.numberOfLines = 0;
    [_lblTip2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _lblTip2.text = @"Total time used:";
    [_scContent addSubview:_lblTip2];
    [_lblTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_lblScore.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    self.lblTime = [[UILabel alloc] init];
    _lblTime.numberOfLines = 0;
    [_lblTime setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    NSInteger totalTime = [FNLoginInfo shareLoginInfo].totalTime;
    NSInteger minute = totalTime / 60;
    _lblTime.text = minute == 0 ? [NSString stringWithFormat:@"%d seconds", totalTime] : [NSString stringWithFormat:@"%d minutes", minute];
    _lblTime.textColor = [UIColor colorWithHexValue:@"FF8888"];
    [_scContent addSubview:_lblTime];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_lblTip2.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    self.lblTip3 = [[UILabel alloc] init];
    _lblTip3.numberOfLines = 0;
    [_lblTip3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _lblTip3.text = @"Your performance among all participants:";
    [_scContent addSubview:_lblTip3];
    [_lblTip3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_lblTime.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    
    //    NSArray *array = @[@81, @4,@9,@4,@0];
//    NSArray *array = @[@"81.0%", @"4.0%",@"9.0%",@"4.0%",@"0.0%"];
    LCChartViewModel *model = [LCChartViewModel modelWithColor:[UIColor colorWithHexValue:@"8888FF"] plots:array project:nil];
    model.hightlightIndex = highLightIndex;
    model.hightlightColor = [UIColor blueColor];
    NSArray *dataSource = @[model];
    self.chartViewBar = [[LCChartView alloc] initWithFrame:CGRectMake(0, 0, screenWidth() - 40, 250) chartViewType:LCChartViewTypeBar];
    
    NSMutableArray *arrayTitles = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = 0; i < 5; ++ i) {
        [arrayTitles addObject:[NSString stringWithFormat:@"%d - %d", 20 * i, 20 + 20 * i]];
    }
    
    _chartViewBar.xAxisTitleArray = arrayTitles;
    _chartViewBar.barWidth = (screenWidth() - 80)/ 5 - 30;
    _chartViewBar.barMargin = 20;
    _chartViewBar.userInteractionEnabled = NO;
    NSInteger upperMaxValue = (NSInteger)(maxValue / 10 + 1) * 10;
    _chartViewBar.yAxisCount = (NSInteger)(maxValue / 10) + 1;
    [self.view addSubview:_chartViewBar];
    [self.chartViewBar showChartViewWithYAxisMaxValue:upperMaxValue dataSource:dataSource];
    [_chartViewBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@250);
        make.top.equalTo(_lblTip3.mas_bottom).offset(20);
    }];
    
    self.btnLeave = [[UIButton alloc] init];
    _btnLeave.backgroundColor = [UIColor lightGrayColor];
    [_btnLeave setTitle:@"LEAVE" forState:UIControlStateNormal];
    [_btnLeave addTarget:self action:@selector(leaveClick) forControlEvents:UIControlEventTouchUpInside];
    [_scContent addSubview:_btnLeave];
    
    [_btnLeave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chartViewBar.mas_bottom).offset(20);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@120);
    }];
    
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_btnLeave.mas_bottom).offset(20);
    }];
    
    [[FNLoginInfo shareLoginInfo] uploadJsonToServer:^{
        
    }];
}

- (void)leaveClick
{
    [[FNLoginInfo shareLoginInfo] clearLastInfo];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
