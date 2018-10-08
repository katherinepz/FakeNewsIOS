

#import "FNSurveyController.h"
#import "NSDictionary+ValueType.h"
#import "FNSelectAnswerView.h"
#import "FNTextAnswerView.h"
#import "Masonry.h"
#import "DEBUGLOG.h"
#import "FNLoginInfo.h"
#import "NDAlertView.h"
#import "API.h"
#import "ZYBarButtonItem.h"
#import "FNFeedBackController.h"

@interface FNSurveyController ()

@end

@implementation FNSurveyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[ZYBarButtonItem alloc] initWithTitle:nil target:nil action:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [_vphase configureWithPhase:FN_PHASE_SURVEY index:0 total:[FNLoginInfo shareLoginInfo].arrayNewsId.count];
    [_vphase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_scContent.mas_top);//.offset(88);
        make.height.equalTo(@100);
    }];
    
    [self loadQuestions];
    
    UIView *lastview = [_arrayQuestionViews lastObject];

    self.btnSubmit = [[UIButton alloc] init];
    _btnSubmit.backgroundColor = [UIColor lightGrayColor];
    [_btnSubmit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [_scContent addSubview:_btnSubmit];

    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastview.mas_bottom).offset(20);
        make.height.equalTo(@44);
        make.centerX.equalTo(lastview.mas_centerX);
        make.width.equalTo(@120);
        make.bottom.equalTo(_scContent.mas_bottom).offset(20);
    }];
    
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(_btnSubmit.mas_bottom).offset(20);
    }];
    
    [FNLoginInfo shareLoginInfo].phase = FN_PHASE_SURVEY;
    [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
}

- (void)loadQuestions
{
    self.arrayQuestionViews = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    NSString *fileFullPath = [filePath stringByAppendingPathComponent:@"survery.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:fileFullPath];
    
    UIView *lastView = nil;
    for (NSInteger i = 0; i < array.count; ++ i)
    {
        NSDictionary *dict = [array objectAtIndex:i];
        
        NSInteger type = [dict integerForKeyPath:@"t"];
        NSString *key = [dict stringForKeyPath:@"k"];
        
        switch (type) {
            case FN_SURVERY_TYPE_SINGLE_SELECT:
            case FN_SURVERY_TYPE_MULTI_SELECT:
            case FN_SURVERY_TYPE_TRUE_FALSE:
                {
                    FNSelectAnswerView *view = [[FNSelectAnswerView alloc] initWithDict:dict index:i + 1];
                    view.index = i;
                    view.key = key;
                    [_scContent addSubview:view];
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self.view);
                        make.right.equalTo(self.view);
                        
                        if (lastView == nil) {
                            make.top.equalTo(_vphase.mas_bottom).offset(20);
                        }
                        else
                        {
                            make.top.equalTo(lastView.mas_bottom);
                        }
                    }];
                    
                    view.type = type;
                    lastView = view;
                }
                break;
            case FN_SURVERY_TYPE_ANSWER:
                {
                    FNTextAnswerView *view = [[FNTextAnswerView alloc] initWithDict:dict index:i + 1];
                    view.index = i;
                    view.key = key;
                    [_scContent addSubview:view];
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self.view);
                        make.right.equalTo(self.view);
                        
                        if (lastView == nil)
                        {
                            make.top.equalTo(_vphase.mas_bottom).offset(20);
                        }
                        else
                        {
                            make.top.equalTo(lastView.mas_bottom);
                        }
                    }];
                    lastView = view;
                }
                break;
            default:
                break;
        }
        
        [_arrayQuestionViews addObject:lastView];
    }
}

- (void)submitClick
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (UIView *v in _arrayQuestionViews) {
        
        if ([v isKindOfClass:[FNSelectAnswerView class]]) {
            FNSelectAnswerView *answerView = (FNSelectAnswerView *)v;
            NSMutableArray *answers = [answerView getSelectedAnswers];
            
            if (answers.count == 0) {
                [NDAlertView alertViewWithTitle:@"Tip"
                                        message:[NSString stringWithFormat:@"Please select choice for Q%d", answerView.index + 1]
                              cancelButtonTitle:@"OK"];
                return;
            }
            if (answerView.type == FN_SURVERY_TYPE_SINGLE_SELECT) {
                [dict setObject:[answers objectAtIndex:0] forKey:answerView.key];
            }
            else if (answerView.type == FN_SURVERY_TYPE_TRUE_FALSE)
            {
                NSString *ans = [answers objectAtIndex:0];
                if ([[ans uppercaseString] isEqualToString:@"YES"]) {
                    [dict setObject:[NSNumber numberWithBool:YES] forKey:answerView.key];
                }
                else
                {
                    [dict setObject:[NSNumber numberWithBool:NO] forKey:answerView.key];
                }
            }
            else
            {
                [dict setObject:answers forKey:answerView.key];
            }
        }
        else
        {
            FNTextAnswerView *answerView = (FNTextAnswerView *)v;
            NSString *answer = answerView.tfAnswer.text;
            [dict setObject:answer forKey:answerView.key];
        }
    }
    
    [self uploadDict:dict];
}

- (void)uploadDict:(NSDictionary *)dict
{
    NSDictionary *answers = [NSDictionary dictionaryWithObject:dict forKey:@"answers"];
    DEBUGLOG(@"%@", [answers description]);
//    [[FNLoginInfo shareLoginInfo].dictTotalAnswers setObject:dict forKey:@"survey"];
    
    self.uploadRequest = [[JMRequestObject alloc] init];
    [_uploadRequest startRequestWithRequest:^ASIHTTPRequest *{
        return [JMAPI surveyWithJson:answers token:[FNLoginInfo shareLoginInfo].token];
    }
                               successBlock:^(ASIHTTPRequest *request) {
                                   //TODO feedback
                                   
                                   [FNLoginInfo shareLoginInfo].phase = FN_PHASE_FEEDBACK;
                                   [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
                                   [NDAlertView alertViewWithTitle:@"Tip"
                                                           message:@"Submit Success"
                                                 cancelButtonTitle:nil
                                                     okButtonTitle:@"OK"
                                                 cancelButtonBlock:nil
                                                     okButtonBlock:^(NSInteger buttonIndex) {
//                                                         [[FNLoginInfo shareLoginInfo] clearLastInfo];
//                                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                                         [FNLoginInfo shareLoginInfo].phase = FN_PHASE_FEEDBACK;
                                                         [[FNLoginInfo shareLoginInfo] saveToLocalMemory];
                                                         FNFeedBackController *controller = [[FNFeedBackController alloc] init];
                                                         [self.navigationController pushViewController:controller animated:YES];
                                                     }];
                                   
                               }
                                  failBlock:^(ASIHTTPRequest *request) {
                                      
                                  }
                                      retry:NO];
}



@end
