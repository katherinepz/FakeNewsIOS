
#import "ViewController.h"
#import "ZYBarButtonItem.h"
#import "Masonry.h"
#import "API.h"
#import "FNLoginInfo.h"
#import "NSDictionary+ValueType.h"
#import "NSData+JSONObject.h"
#import "FNInstructionController.h"
#import "NDAlertView.h"
#import "FNSurveyController.h"
#import "NSDate+CHN.h"
#import "DEBUGLOG.h"
#import "NDWaitingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    self.navigationItem.leftBarButtonItem = [[ZYBarButtonItem alloc] initWithTitle:nil target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[ZYBarButtonItem alloc] initWithNormalImage:[UIImage imageNamed:@"more.png"]
                                                                           highLightImage:[UIImage imageNamed:@"more.png"]
                                                                                   target:self
                                                                                   action:@selector(rightNavItemClick)];
    
    self.scContent = [[UIScrollView alloc] init];
    [_scContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:_scContent];
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    self.vphase = [[FNPhaseView alloc] init];
    [_scContent addSubview:_vphase];
    [_vphase addIcon];
    [_vphase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_scContent.mas_top);//.offset(88);
        make.height.equalTo(@100);
    }];
    
    self.qview = [[FNQuestionView alloc] init];
    [_scContent addSubview:_qview];
    [_qview setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_qview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_vphase.mas_bottom).offset(20);
    }];
    
    self.vChoice = [[FNChoiceView alloc] init];
    _vChoice.delegate = self;
    [_vChoice configureWithPhase:_phase];
    [_scContent addSubview:_vChoice];
    [_vChoice.btnNext addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [_vChoice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_qview.mas_bottom);
//        make.bottom.equalTo(_scContent.mas_bottom).offset(-20);
    }];
    
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_vChoice.mas_bottom).offset(20);
    }];
    
    if (_phase == FN_PHASE_2) {
        
        self.vP2End = [[FNPhase2QEnd alloc] init];
        _vP2End.hidden = YES;
        _vP2End.backgroundColor = [UIColor whiteColor];
        [_vP2End.btnSaveAndLeave addTarget:self action:@selector(P2EndSaveAndLeaveClick) forControlEvents:UIControlEventTouchUpInside];
        [_vP2End.btnNext addTarget:self action:@selector(P2EndNextClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_vP2End];
        
        [_vP2End mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    if (_dictNewsDetails == nil){
       self.dictNewsDetails = [NSMutableDictionary dictionary];
    }
    [self generateUploadJson];
    
    NSString *ID = [[FNLoginInfo shareLoginInfo].arrayNewsId objectAtIndex:_currentQuestionIndex];
    [self getQuestionsWithID:ID];
//    [self getQuestionsWithID:@"7445"];
}

- (void)P2EndNextClick
{
    if (_currentQuestionIndex == [FNLoginInfo shareLoginInfo].arrayNewsId.count - 1) {
        
        [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
        
        [[FNLoginInfo shareLoginInfo] uploadJsonToServer:^{
            FNSurveyController *controller = [[FNSurveyController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
    else
    {
        _vP2End.hidden = YES;
        
        NSArray *questionsIds = [FNLoginInfo shareLoginInfo].arrayNewsId;
        ++_currentQuestionIndex;
        NSString *currentId = [questionsIds objectAtIndex:_currentQuestionIndex];
        [self getQuestionsWithID:currentId];
        _vChoice.btnNext.hidden = YES;
        
        [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
        DEBUGLOG(@"%@", [_uploadJson description]);
    }
}

- (void)P2EndSaveAndLeaveClick
{
    [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)generateUploadJson
{
    NSMutableDictionary *dictTotalAnswer = [FNLoginInfo shareLoginInfo].dictTotalAnswers;
    
    if (!_continueTrail)
    {
        self.uploadJson = [NSMutableDictionary dictionary];
        self.arrayAnswers = [NSMutableArray array];
        self.currentQuestionIndex = 0;
        self.phaseStartTime = [[NSDate date] timeStampString];
        
        if (_phase == FN_PHASE_1) {
            [dictTotalAnswer setObject:_uploadJson forKey:@"phase_1"];
            [_uploadJson setObject:@"Classification" forKey:@"phase"];
            [_uploadJson setObject:_arrayAnswers forKey:@"news"];
            [_uploadJson setObject:_phaseStartTime forKey:@"timeStart"];
        }
        else
        {
            [dictTotalAnswer setObject:_uploadJson forKey:@"phase_2"];
            [_uploadJson setObject:@"Familiarity" forKey:@"phase"];
            [_uploadJson setObject:_arrayAnswers forKey:@"news"];
            [_uploadJson setObject:_phaseStartTime forKey:@"timeStart"];
        }
    }
    else
    {
        if (_phase == FN_PHASE_1) {
            self.uploadJson = [dictTotalAnswer mutableDictionaryForKeyPath:@"phase_1"];
            self.arrayAnswers = [_uploadJson mutableArrayForKeyPath:@"news"];
            self.phaseStartTime = [_uploadJson stringForKeyPath:@"timeStart"];
        }
        else
        {
            self.uploadJson = [dictTotalAnswer mutableDictionaryForKeyPath:@"phase_2"];
            self.arrayAnswers = [_uploadJson mutableArrayForKeyPath:@"news"];
            self.phaseStartTime = [_uploadJson stringForKeyPath:@"timeStart"];
        }
        
        self.currentQuestionIndex = _arrayAnswers.count;
        if (_currentQuestionIndex == [[FNLoginInfo shareLoginInfo].arrayNewsId count]) {
            --_currentQuestionIndex;
        }
    }
}

- (void)rightNavItemClick
{
    if (self.ddlist == nil)
    {
        self.ddlist = [[FNDropDownList alloc] init];
        _ddlist.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.view addSubview:_ddlist];
        [_ddlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.height.equalTo(self.view);
            make.left.equalTo(self.view);
        }];
        
        [_ddlist.btnInstruction addTarget:self action:@selector(instructionClick) forControlEvents:UIControlEventTouchUpInside];
        [_ddlist.btnSaveAndExit addTarget:self action:@selector(saveAndExitClick) forControlEvents:UIControlEventTouchUpInside];
        
        if (_phase == FN_PHASE_2) {
            _ddlist.btnSaveAndExit.hidden = YES;
        }
    }
    else
    {
        self.ddlist.hidden = NO;
    }
}

- (void)instructionClick
{
    FNInstructionController *controller = [[FNInstructionController alloc] init];
    controller.embed = YES;
    controller.phase = _phase;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)saveAndExitClick
{
    [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)getQuestionsWithID:(NSString *)ID
{
    NSDictionary *dictQuestion = [_dictNewsDetails dictForKeyPath:ID];
    
    if (dictQuestion == nil) {
        [[NDWaitingView shareWaitingView] show];
        self.questionRequest = [[JMRequestObject alloc] init];
        [_questionRequest startRequestWithRequest:^ASIHTTPRequest *{
            NSString *token = [FNLoginInfo shareLoginInfo].token;
            return [JMAPI getNewsInfoWithNewsId:ID token:token];
        }
                                     successBlock:^(ASIHTTPRequest *request) {
                                         [[NDWaitingView shareWaitingView] hide];
                                         
                                         NSDictionary *dict = [request.responseData JSONObject];
                                         NSDictionary *doc = [dict dictForKeyPath:@"doc"];
                                         
                                         [_dictNewsDetails setObject:doc forKey:ID];
                                         [_qview configureWithDictionary:doc];
                                         [_vphase configureWithPhase:_phase
                                                               index:_currentQuestionIndex + 1
                                                               total:[FNLoginInfo shareLoginInfo].arrayNewsId.count];
                                         
                                         
                                         self.questionBeginTime = [NSDate date];
                                         [_vChoice countDown];
                                         
                                         _scContent.contentOffset = CGPointZero;
                                     }
                                        failBlock:^(ASIHTTPRequest *request) {
                                            [[NDWaitingView shareWaitingView] hide];
                                        }
                                            retry:YES];
    }
    else
    {
        [_qview configureWithDictionary:dictQuestion];
        [_vphase configureWithPhase:_phase
                              index:_currentQuestionIndex + 1
                              total:[FNLoginInfo shareLoginInfo].arrayNewsId.count];
        
        self.questionBeginTime = [NSDate date];
        [_vChoice countDown];
        
        _scContent.contentOffset = CGPointZero;
    }
}

- (void)nextClick
{
    if ([_vChoice getSelectValue] == UISegmentedControlNoSegment)
    {
        [NDAlertView alertViewWithTitle:@"Tip"
                                message:@"Please select one"
                      cancelButtonTitle:@"OK"];
        return;
    }
    
    NSDate *currenttime = [NSDate date];
    NSTimeInterval time = [currenttime timeIntervalSinceDate:_questionBeginTime];
    NSMutableDictionary *dictAnswer = [_arrayAnswers objectAtIndex:_currentQuestionIndex];
    [dictAnswer setObject:[NSString stringWithFormat:@"%d", (NSInteger)(time + 0.9999 - 5)] forKey:@"elapsedTime"];
    
    NSArray *questionsIds = [FNLoginInfo shareLoginInfo].arrayNewsId;
    if (_currentQuestionIndex < questionsIds.count - 1) {
        
        if (_phase == FN_PHASE_2) {
            [self configureP2EndView];
        }
        else
        {
            ++_currentQuestionIndex;
            NSString *currentId = [questionsIds objectAtIndex:_currentQuestionIndex];
            [self getQuestionsWithID:currentId];
            _vChoice.btnNext.hidden = YES;
            
            [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
            DEBUGLOG(@"%@", [_uploadJson description]);
        }
    }
    else
    {
        NSString *endTimeString = [[NSDate date] timeStampString];
        [_uploadJson setObject:endTimeString forKey:@"timeEnd"];
        [_uploadJson setObject:_phaseStartTime forKey:@"timeStart"];
        DEBUGLOG(@"%@", [_uploadJson description]);
        
        if (_phase == FN_PHASE_1) {
            [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
            
            [[FNLoginInfo shareLoginInfo] uploadJsonToServer:^{
                FNInstructionController *controller = [[FNInstructionController alloc] init];
                controller.phase = FN_PHASE_2;
                controller.target = self;
                controller.action = @selector(phase2);
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
        else
        {
            [self configureP2EndView];
        }
    }
}

- (void)configureP2EndView
{
    _vP2End.hidden = NO;
    NSMutableArray *arrayP1Answers = [[FNLoginInfo shareLoginInfo].dictTotalAnswers mutableArrayForKeyPath:@"phase_1.news"];
    NSDictionary *dictAnswer = [arrayP1Answers objectAtIndex:_currentQuestionIndex];
    NSDictionary *dictQ = [_dictNewsDetails dictForKeyPath:[dictAnswer stringForKeyPath:@"newsId"]];
    NSString *label = [dictQ stringForKeyPath:@"label"];
    if ([label isEqualToString:@"REAL"])
    {
        label = @"TRUE";
    }
    NSString *selectLabel = [dictAnswer stringForKeyPath:@"label"];
    NSString *showLabel = selectLabel;
    if ([selectLabel isEqualToString:@"FALSE"])
    {
        selectLabel = @"FAKE";
    }
    DEBUGLOG(@"ql:%@ sl:%@", label, selectLabel);
    NSString *isAgreed = [label isEqualToString:selectLabel] ? @"agreed" : @"disagreed";
    _vP2End.lblContent.text = [NSString stringWithFormat:@"In phase 1, you selected %@, this %@ with the label provided by the BS detector App.", showLabel, isAgreed];
}

- (void)phase2
{
    ViewController *controller = [[ViewController alloc] init];
    controller.phase = FN_PHASE_2;
    controller.dictNewsDetails = _dictNewsDetails;
    [FNLoginInfo shareLoginInfo].phase = FN_PHASE_2;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)choiceView:(FNChoiceView *)choiceView didSelectedValue:(NSInteger)value
{
    NSArray *questionsIds = [FNLoginInfo shareLoginInfo].arrayNewsId;
    NSString *currentId = [questionsIds objectAtIndex:_currentQuestionIndex];
    NSDictionary *dictNews = [_dictNewsDetails dictForKeyPath:currentId];
    
    NSMutableDictionary *dictAnswer = [NSMutableDictionary dictionary];
    if (_phase == FN_PHASE_1) {
        [dictAnswer setObject:[NSString stringWithFormat:@"%d", value] forKey:@"truthRating"];
        
        if (value < FN_TRUE) {
            [dictAnswer setObject:@"FALSE" forKey:@"label"];
        }
        else
        {
            [dictAnswer setObject:@"TRUE" forKey:@"label"];
        }
    }
    else
    {
        [dictAnswer setObject:[NSString stringWithFormat:@"%d", value] forKey:@"familiarityRating"];
        
        if (value < FN_TRUE) {
            [dictAnswer setObject:@"Haven't Heard About It" forKey:@"label"];
        }
        else
        {
            [dictAnswer setObject:@"Have heard about it" forKey:@"label"];
        }
    }
    
    [dictAnswer setObject:currentId forKey:@"newsId"];
    
    if (_currentQuestionIndex < _arrayAnswers.count) {
        [_arrayAnswers replaceObjectAtIndex:_currentQuestionIndex withObject:dictAnswer];
    }
    else
    {
        [_arrayAnswers addObject:dictAnswer];
    }
}

@end
