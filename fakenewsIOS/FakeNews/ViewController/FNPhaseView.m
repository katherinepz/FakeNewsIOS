
#import "FNPhaseView.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"
#import "SystemInfo.h"

@implementation FNPhaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addIcon
{
    self.ivPhase1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phase.png"]];
    _ivPhase1.highlightedImage = [UIImage imageNamed:@"phase_on.png"];
    [self addSubview:_ivPhase1];
    
    self.ivFeedBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phase.png"]];
    _ivFeedBack.highlightedImage = [UIImage imageNamed:@"phase_on.png"];
    [self addSubview:_ivFeedBack];
    
    self.ivDot1 = [[UIImageView alloc] init];
    _ivDot1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_ivDot1];
    
    self.ivPhase2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phase.png"]];
    _ivPhase2.highlightedImage = [UIImage imageNamed:@"phase_on.png"];
    [self addSubview:_ivPhase2];
    
    [_ivDot1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ivPhase1.mas_right).offset(10);
        make.right.equalTo(_ivPhase2.mas_left).offset(-10);
        make.height.equalTo(@1);
        make.centerY.equalTo(_ivPhase1.mas_centerY);
    }];
    
    self.ivDot2 = [[UIImageView alloc] init];
    _ivDot2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_ivDot2];
    
    self.ivSurvey = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phase.png"]];
    _ivSurvey.highlightedImage = [UIImage imageNamed:@"phase_on.png"];
    [self addSubview:_ivSurvey];
    
    [_ivDot2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ivPhase2.mas_right).offset(10);
        make.right.equalTo(_ivSurvey.mas_left).offset(-10);
        make.height.equalTo(@1);
        make.centerY.equalTo(_ivPhase1.mas_centerY);
    }];
    
    self.ivDot3 = [[UIImageView alloc] init];
    _ivDot3.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_ivDot3];
    
    [_ivDot3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ivSurvey.mas_right).offset(10);
        make.right.equalTo(_ivFeedBack.mas_left).offset(-10);
        make.height.equalTo(@1);
        make.centerY.equalTo(_ivPhase1.mas_centerY);
    }];
    
    UIImage *iphase = [UIImage imageNamed:@"phase.png"];
    
    [@[_ivPhase1, _ivPhase2, _ivSurvey, _ivFeedBack] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:iphase.size.width leadSpacing:40 tailSpacing:40];
    
    [@[_ivPhase1, _ivPhase2, _ivSurvey, _ivFeedBack] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    self.lblPhase1 = [[UILabel alloc] init];
    _lblPhase1.text = @"Phase1\n(0/0)";
    _lblPhase1.numberOfLines = 2;
    [self addSubview:_lblPhase1];
    [_lblPhase1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblPhase1.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblPhase1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_ivPhase1);
        make.top.equalTo(_ivPhase1.mas_bottom).offset(10);
    }];
    
    self.lblPhase2 = [[UILabel alloc] init];
    _lblPhase2.text = @"Phase2\n(0/0)";
    _lblPhase2.numberOfLines = 2;
    [self addSubview:_lblPhase2];
    [_lblPhase2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblPhase2.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblPhase2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_ivPhase2);
        make.top.equalTo(_ivPhase2.mas_bottom).offset(10);
    }];
    
    self.lblSurvey = [[UILabel alloc] init];
    _lblSurvey.text = @"Survey";
    _lblSurvey.numberOfLines = 1;
    [self addSubview:_lblSurvey];
    [_lblSurvey setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblSurvey.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblSurvey mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_ivSurvey);
        make.top.equalTo(_ivSurvey.mas_bottom).offset(10);
    }];
    
    self.lblFeedBack = [[UILabel alloc] init];
    _lblFeedBack.text = @"FeedBack";
    _lblFeedBack.numberOfLines = 1;
    [self addSubview:_lblFeedBack];
    [_lblFeedBack setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
    _lblFeedBack.textColor = [UIColor colorWithHexValue:@"888888"];
    [_lblFeedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_ivFeedBack);
        make.top.equalTo(_ivFeedBack.mas_bottom).offset(10);
    }];/**/
}

- (void)configureWithPhase:(FN_PHASE)phase index:(NSInteger)index total:(NSInteger)total
{
    if (phase == FN_PHASE_1) {
        _ivPhase1.highlighted = YES;
        _lblPhase1.text = [NSString stringWithFormat:@"Phase1\n(%d/%d)", index, total];
        _lblPhase2.text = [NSString stringWithFormat:@"Phase2\n(0/%d)", total];
    }
    else if (phase == FN_PHASE_2)
    {
        _ivPhase1.highlighted = YES;
        _ivPhase2.highlighted = YES;
        _lblPhase2.text = [NSString stringWithFormat:@"Phase2\n(%d/%d)", index, total];
        _lblPhase1.text = [NSString stringWithFormat:@"Phase1\n(%d/%d)", total, total];
    }
    else if (phase == FN_PHASE_SURVEY)
    {
        _ivPhase1.highlighted = YES;
        _ivPhase2.highlighted = YES;
        _ivSurvey.highlighted = YES;
        _lblPhase1.text = [NSString stringWithFormat:@"Phase1\n(%d/%d)", total, total];
        _lblPhase2.text = [NSString stringWithFormat:@"Phase2\n(%d/%d)", total, total];
    }
    else
    {
        _ivPhase1.highlighted = YES;
        _ivPhase2.highlighted = YES;
        _ivSurvey.highlighted = YES;
        _ivFeedBack.highlighted = YES;
        _lblPhase1.text = [NSString stringWithFormat:@"Phase1\n(%d/%d)", total, total];
        _lblPhase2.text = [NSString stringWithFormat:@"Phase2\n(%d/%d)", total, total];
    }
}

@end
