

#import "FNLoginViewController.h"
#import "Masonry.h"
#import "API.h"
#import "NDWaitingView.h"
#import "NDAlertView.h"
#import "ViewController.h"
#import "NSData+JSONObject.h"
#import "FNLoginInfo.h"
#import "NSDictionary+ValueType.h"
#import "FNLoginInfo.h"
#import "DEBUGLOG.h"
#import "FNSurveyController.h"
#import "NSDate+CHN.h"
#import "FNInstructionController.h"
#import "FNFeedBackController.h"

@interface FNLoginViewController ()

@end

@implementation FNLoginViewController

- (void)dealloc
{
    [_loginRequest clear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblWelcome = [[UILabel alloc] init];
    [lblWelcome setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    lblWelcome.numberOfLines = 0;
    lblWelcome.font = [UIFont systemFontOfSize:18];
    lblWelcome.text = @"Welcome to FakeNews Test!\nPlease enter the login code here";
    [self.view addSubview:lblWelcome];
    
    [lblWelcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@44);
        make.top.equalTo(self.view).offset(80);
    }];
    
    
    self.tfCode = [[UITextField alloc] init];
    _tfCode.layer.borderColor = [UIColor blackColor].CGColor;
    _tfCode.layer.borderWidth = 0.5f;
    _tfCode.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tfCode];
    [_tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblWelcome);
        make.right.equalTo(lblWelcome);
        make.height.equalTo(@44);
        make.top.equalTo(lblWelcome.mas_bottom).offset(20);
    }];
    
    self.btnLogin = [[UIButton alloc] init];
    _btnLogin.backgroundColor = [UIColor lightGrayColor];
    [_btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnLogin setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    [_btnLogin setTitle:@"Next" forState:UIControlStateNormal];
    [_btnLogin addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLogin];
    [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_tfCode.mas_bottom).offset(40);
        make.height.equalTo(@44);
        make.width.equalTo(@120);
    }];
    
    if([[FNLoginInfo shareLoginInfo] hasLastTrail])
    {
        _tfCode.text = [[NSUserDefaults standardUserDefaults] objectForKey:FN_LAST_CODE];
    }
}

- (void)loginClick
{
    if([[FNLoginInfo shareLoginInfo] hasLastTrail])
    {
        [NDAlertView alertViewWithTitle:@"You have an unfinished trail, click OK to continue, click CANCEL to exit.\n\n*Notice: Trail must be completed within 24 hours!"
                                message:nil
                      cancelButtonTitle:@"cancel"
                          okButtonTitle:@"OK"
                      cancelButtonBlock:nil
                          okButtonBlock:^(NSInteger buttonIndex) {
                              [self loadLastInfo];
                          }];
    }
    else
    {
        [self login];
    }
}

- (void)loadLastInfo
{
    [[FNLoginInfo shareLoginInfo] loadLastInfoFromLocalMemory];
    FN_PHASE phase = [FNLoginInfo shareLoginInfo].phase;
    
    BOOL continueTrail = YES;
    if (phase == FN_PHASE_1) {
        NSInteger currentIndex = [[FNLoginInfo shareLoginInfo].dictTotalAnswers arrayForKeyPath:@"phase_1.news"].count;
        if (currentIndex == [FNLoginInfo shareLoginInfo].arrayNewsId.count) {
            phase = FN_PHASE_2;
            [FNLoginInfo shareLoginInfo].phase = FN_PHASE_2;
            continueTrail = NO;
        }
    }
    else if (phase == FN_PHASE_2)
    {
        NSInteger currentIndex = [[FNLoginInfo shareLoginInfo].dictTotalAnswers arrayForKeyPath:@"phase_2.news"].count;
        if (currentIndex == [FNLoginInfo shareLoginInfo].arrayNewsId.count) {
            phase = FN_PHASE_SURVEY;
        }
    }
    
    switch (phase) {
        case FN_PHASE_1:
        case FN_PHASE_2:
        {
            ViewController *controller = [[ViewController alloc] init];
            controller.phase = phase;
            controller.continueTrail = continueTrail;
            if (phase == FN_PHASE_1) {
                controller.phaseStartTime = [[FNLoginInfo shareLoginInfo].dictTotalAnswers stringForKeyPath:@"phase_1.timeStart"];
            }
            else
            {
                controller.phaseStartTime = [[FNLoginInfo shareLoginInfo].dictTotalAnswers stringForKeyPath:@"phase_2.timeStart"];
            }
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FN_PHASE_SURVEY:
        {
            FNSurveyController *controller = [[FNSurveyController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FN_PHASE_FEEDBACK:
        {
            FNFeedBackController *controller = [[FNFeedBackController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)login
{
    if (_tfCode.text.length > 0)
    {
        [[NDWaitingView shareWaitingView] show];
        
        self.loginRequest = [[JMRequestObject alloc] init];
        [_loginRequest startRequestWithRequest:^ASIHTTPRequest *{
            return [JMAPI loginWithLoginCode:_tfCode.text];
        }
                                  successBlock:^(ASIHTTPRequest *request) {
                                      [[NDWaitingView shareWaitingView] hide];
                                      
                                      NSDictionary *dict = [request.responseData JSONObject];
                                      
                                      FNLoginInfo *shareInfo = [FNLoginInfo shareLoginInfo];
                                      shareInfo.token = [dict stringForKeyPath:@"token"];
                                      NSString *newsIds = [dict stringForKeyPath:@"newsIds"];
                                      shareInfo.arrayNewsId = [newsIds componentsSeparatedByString:@","];
//                                      shareInfo.arrayNewsId = [dict arrayForKeyPath:@"newsIds"];
                                      shareInfo.code = _tfCode.text;
                                      shareInfo.phase = FN_PHASE_1;
                                      [shareInfo saveToLocalMemory];
                                      
                                      FNInstructionController *controller = [[FNInstructionController alloc] init];
                                      controller.phase = FN_PHASE_1;
                                      controller.target = self;
                                      controller.action = @selector(phase1);
                                      [self.navigationController pushViewController:controller animated:YES];
                                  }
                                     failBlock:^(ASIHTTPRequest *request) {
                                         [[NDWaitingView shareWaitingView] hide];
                                         
                                         [NDAlertView alertViewWithTitle:@"Tip"
                                                                 message:@"This code has already been used."
                                                       cancelButtonTitle:@"OK"];
                                     }
                                         retry:NO];
    }
    else
    {
        [NDAlertView alertViewWithTitle:@"Please input code!"
                                message:nil
                      cancelButtonTitle:@"OK"];
    }
}

- (void)phase1
{
    NSDate *now = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:now forKey:FN_LAST_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ViewController *controller = [[ViewController alloc] init];
    controller.phase = FN_PHASE_1;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
