

#import "FNPhase2QEnd.h"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation FNPhase2QEnd

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super init];
    
    if (self) {
        self.lblContent = [[UILabel alloc] init];
        _lblContent.numberOfLines = 0;
        _lblContent.font = [UIFont systemFontOfSize:24];
        [self addSubview:_lblContent];
        [_lblContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
        _lblContent.textColor = [UIColor colorWithHexValue:@"888888"];
        [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(80);
        }];
        
        self.btnSaveAndLeave = [[UIButton alloc] init];
        _btnSaveAndLeave.backgroundColor = [UIColor lightGrayColor];
        [_btnSaveAndLeave setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
        [_btnSaveAndLeave setTitle:@"SAVE AND LEAVE" forState:UIControlStateNormal];
        [self addSubview:_btnSaveAndLeave];
        
        [_btnSaveAndLeave mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(self).offset(-40);
        }];
        
        self.btnNext = [[UIButton alloc] init];
        _btnNext.backgroundColor = [UIColor lightGrayColor];
        [_btnNext setTitle:@"Next" forState:UIControlStateNormal];
        [self addSubview:_btnNext];
        
        [_btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.right.equalTo(self.mas_right).offset(-20);
            make.width.equalTo(@120);
            make.bottom.equalTo(self).offset(-40);
        }];
    }
    
    return self;
}

@end
