

#import "FNInstructionController.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"
#import "SystemInfo.h"
#import "ZYBarButtonItem.h"

@interface FNInstructionController ()

@end

@implementation FNInstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     self.tvContent = [[UITextView alloc] init];
     [self.view addSubview:_tvContent];
     [_tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
     make.edges.equalTo(self.view);
     }];
     
     _tvContent.text = @"instruction1:\n\
     How accurately can you detect what's true or false?\n\
     \n\
     On each trial you will be shown a news item or headline and asked to respond as to whether you think the item is true or false. Each item has been evaluated by an online app called the BS Detector, which looks for several characteristics of \"Fake News\" and tags articles as either REAL or FAKE. Some of the articles you will see will be tagged as REAL news articles. Other news articles will be tagged as FAKE news. All of the articles are drawn from actual news sources, but some of the articles contain information which is unlikely to be true (according to the BS Detector app). These articles are tagged as containing FAKE news. You will not know which articles have REAL news and which articles have FAKE news. You should respond in the TRUE range (using numbers 5-8) if you think the news is REAL. You should respond in the FALSE range (using numbers 1-4) if you think the news is FAKE. You can also indicate how confident you are in your answer by using the provided scale.Each item will be shown for 5 seconds. During that time, read and think about the item. After 5 seconds, a response screen will appear showing the response scale.?\n\
     \n\
     The response numbers 1 to 4 indicate that you think the item is FALSE (i.e., that the item contains FAKE news), and the response numbers 5 to 8 indicate that you think the item is true (i.e., that the item contains REAL news). You should indicate how confident you are in your decision by using more extreme numbers (1 or 8) for higher confidence and less extreme numbers (4 or 5) for low confidence. You can use the other numbers to indicate confidence in the middle range between low and high.\n\
     \n\
     You have up to 24 hours to finish the survey from the beginning, close the browser and come back anyway.\n\
     \n\
     Instruction2:\n\
     Do you remember hearing about this before?\n\
     \n\
     On each trial you will be shown a news item or headline and asked to respond 1-8 indicating the confidence with which you think you had seen or heard about the content of the item before you started the experiment.\n\
     \n\
     Each item will be shown until you respond.\n\
     \n\
     The response numbers 1 to 4 indicate that you think you haven't heard about the item before, and the response numbers 5 to 8 indicate that you think you [have] heard about the item before. You should also indicate how confident you are in your decision by using more extreme numbers (1 or 8) for higher confidence and less extreme number (4 or 5) for low confidence. You can use the other numbers to indicate confidence in the middle range between low and high.\n";
     */
    
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
    
    self.lblTitle = [[UILabel alloc] init];
    _lblTitle.numberOfLines = 0;
    _lblTitle.font = [UIFont systemFontOfSize:24];
    [_scContent addSubview:_lblTitle];
    [_lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_scContent.mas_top).offset(20);
    }];
    
    self.lblContent = [[UILabel alloc] init];
    _lblContent.numberOfLines = 0;
    _lblContent.font = [UIFont systemFontOfSize:20];
    [_scContent addSubview:_lblContent];
    [_lblContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblContent.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_lblTitle.mas_bottom).offset(20);
        //        make.bottom.mas_equalTo(_scContent.mas_bottom).offset(-10.0);
    }];
    
    self.ivScale = [[UIImageView alloc] init];
    [_scContent addSubview:_ivScale];
    _ivScale.contentMode = UIViewContentModeScaleAspectFit;
//    [_ivScale setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    [_ivScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_lblContent.mas_bottom).offset(20);
    }];
    
    self.lblContent2 = [[UILabel alloc] init];
    _lblContent2.numberOfLines = 0;
    _lblContent2.font = [UIFont systemFontOfSize:20];
    [_scContent addSubview:_lblContent2];
    [_lblContent2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblContent2.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblContent2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_ivScale.mas_bottom).offset(20);
        //        make.bottom.mas_equalTo(_scContent.mas_bottom).offset(-10.0);
    }];
    
    self.btnNext = [[UIButton alloc] init];
    _btnNext.backgroundColor = [UIColor lightGrayColor];
    [_btnNext setTitle:@"Understand And Continue" forState:UIControlStateNormal];
    [_btnNext addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [_scContent addSubview:_btnNext];
    
    [_btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblContent2.mas_bottom).offset(20);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    [_scContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_btnNext.mas_bottom).offset(20);
    }];
    
    if (_phase == FN_PHASE_1) {
        _lblTitle.text = @"How accurately can you detect what's true or false?";
        _lblContent.text = @"On each trial you will be shown a news item or headline and asked to respond as to whether you think the item is true or false. Each item has been evaluated by an online app called the BS Detector, which looks for several characteristics of \"Fake News\" and tags articles as either REAL or FAKE. Some of the articles you will see will be tagged as REAL news articles. Other news articles will be tagged as FAKE news. All of the articles are drawn from actual news sources, but some of the articles contain information which is unlikely to be true (according to the BS Detector app). These articles are tagged as containing FAKE news. You will not know which articles have REAL news and which articles have FAKE news. You should respond in the TRUE range (using numbers 5-8) if you think the news is REAL. You should respond in the FALSE range (using numbers 1-4) if you think the news is FAKE. You can also indicate how confident you are in your answer by using the provided scale.Each item will be shown for 5 seconds. During that time, read and think about the item. After 5 seconds, a response screen will appear showing the response scale.?";
        _ivScale.image = [UIImage imageNamed:@"scale1.png"];
        CGSize size = _ivScale.image.size;
        CGFloat width = screenWidth() - 40;
        CGFloat height = width * size.height / size.width;
        [_ivScale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:width]);
            make.height.equalTo([NSNumber numberWithFloat:height]);
        }];
        
        _lblContent2.text = @"The response numbers 1 to 4 indicate that you think the item is FALSE (i.e., that the item contains FAKE news), and the response numbers 5 to 8 indicate that you think the item is true (i.e., that the item contains REAL news). You should indicate how confident you are in your decision by using more extreme numbers (1 or 8) for higher confidence and less extreme numbers (4 or 5) for low confidence. You can use the other numbers to indicate confidence in the middle range between low and high.\n\
        \n\
        You have up to 24 hours to finish the survey from the beginning, close the browser and come back anyway.";
    }
    else
    {
        _lblTitle.text = @"Do you remember hearing about this before?";
        _lblContent.text = @"On each trial you will be shown a news item or headline and asked to respond 1-8 indicating the confidence with which you think you had seen or heard about the content of the item before you started the experiment.\n\
        \n\
        Each item will be shown until you respond.";
        _ivScale.image = [UIImage imageNamed:@"scale2.png"];
        CGSize size = _ivScale.image.size;
        CGFloat width = screenWidth() - 40;
        CGFloat height = width * size.height / size.width;
        [_ivScale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo([NSNumber numberWithFloat:width]);
            make.height.equalTo([NSNumber numberWithFloat:height]);
        }];
        
        _lblContent2.text = @"The response numbers 1 to 4 indicate that you think you haven't heard about the item before, and the response numbers 5 to 8 indicate that you think you [have] heard about the item before. You should also indicate how confident you are in your decision by using more extreme numbers (1 or 8) for higher confidence and less extreme number (4 or 5) for low confidence. You can use the other numbers to indicate confidence in the middle range between low and high.";
    }
}

- (void)nextClick
{
    if (_embed) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (_target != nil && _action != nil) {
            [_target performSelector:_action];
        }
    }
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
