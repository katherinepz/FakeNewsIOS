

#import "FNChoiceView.h"
#import "Masonry.h"
#import "SystemInfo.h"

const NSInteger FN_FALSE = 1;
const NSInteger FN_TRUE = 5;

@implementation FNChoiceView

- (id)init
{
    self = [super init];
    
    if (self) {
        self.lblTitle1 = [[UILabel alloc] init];
        _lblTitle1.text = @"Haven't Heard About It";
        _lblTitle1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblTitle1];
        [_lblTitle1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
        [_lblTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@44);
        }];
        
        self.scFalse = [[UISegmentedControl alloc] initWithItems:@[@"1",@"2",@"3",@"4"]];
        _scFalse.tintColor = [UIColor greenColor];
        [_scFalse addTarget:self action:@selector(falseClick:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_scFalse];
        [_scFalse mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lblTitle1);
            make.right.equalTo(_lblTitle1);
            make.top.equalTo(_lblTitle1.mas_bottom);
            make.height.equalTo(@44);
        }];
        
        self.lblTitle2 = [[UILabel alloc] init];
        _lblTitle2.text = @"Have Heard About It";
        _lblTitle2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblTitle2];
        [_lblTitle2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
        [_lblTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_lblTitle1);
            make.top.equalTo(_scFalse.mas_bottom);
            make.right.equalTo(_lblTitle1);
            make.height.equalTo(@44);
        }];
        
        self.scTrue = [[UISegmentedControl alloc] initWithItems:@[@"5",@"6",@"7",@"8"]];
        _scTrue.tintColor = [UIColor redColor];
        
        [_scTrue addTarget:self action:@selector(trueClick:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_scTrue];
        
        [_scTrue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lblTitle2);
            make.right.equalTo(_lblTitle2);
            make.top.equalTo(_lblTitle2.mas_bottom);
            make.height.equalTo(@44);
        }];
        
        self.btnNext = [[UIButton alloc] init];
        _btnNext.hidden = YES;
        _btnNext.backgroundColor = [UIColor lightGrayColor];
        [_btnNext setTitle:@"Next" forState:UIControlStateNormal];
        [self addSubview:_btnNext];
        
        [_btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scTrue.mas_bottom).offset(20);
            make.height.equalTo(@44);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@120);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
    }
    
    return self;
}

- (void)configureWithPhase:(FN_PHASE)phase
{
    if (phase == FN_PHASE_2) {
        _lblTitle1.text = @"Haven't Heard About It";
        _lblTitle2.text = @"Have Heard About It";
    }
    else
    {
        _lblTitle1.text = @"FALSE";
        _lblTitle2.text = @"TRUE";
    }
}

- (void)falseClick:(UISegmentedControl *)scFalse
{
    _scTrue.selectedSegmentIndex = UISegmentedControlNoSegment;
    if ([_delegate respondsToSelector:@selector(choiceView:didSelectedValue:)]) {
        [_delegate choiceView:self didSelectedValue:scFalse.selectedSegmentIndex+FN_FALSE];
    }
}

- (void)trueClick:(UISegmentedControl *)scTrue
{
    _scFalse.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    if ([_delegate respondsToSelector:@selector(choiceView:didSelectedValue:)]) {
        [_delegate choiceView:self didSelectedValue:scTrue.selectedSegmentIndex+FN_TRUE];
    }
}

- (NSInteger)getSelectValue
{
    //选分细则
    if (_scFalse.selectedSegmentIndex == UISegmentedControlNoSegment
        && _scTrue.selectedSegmentIndex == UISegmentedControlNoSegment)
    {
        return UISegmentedControlNoSegment;
    }
    else if (_scFalse.selectedSegmentIndex != UISegmentedControlNoSegment) {
        return _scFalse.selectedSegmentIndex + FN_FALSE;
    }
    else
    {
        return _scTrue.selectedSegmentIndex + FN_TRUE;
    }
}

- (void)countDown
{
    _scTrue.selectedSegmentIndex = UISegmentedControlNoSegment;
    _scFalse.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _btnNext.hidden = NO;
    });
}

@end
