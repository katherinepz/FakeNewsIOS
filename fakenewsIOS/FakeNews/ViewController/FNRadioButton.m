

#import "FNRadioButton.h"
#import "Masonry.h"

@implementation FNRadioButton

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
    
    if (self)
    {
        self.ivRadio = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phase.png"]];
        _ivRadio.highlightedImage = [UIImage imageNamed:@"phase_on.png"];
        [self addSubview:_ivRadio];
        
        self.lblTitle = [[UILabel alloc] init];
        _lblTitle.text = @"title";
        [self addSubview:_lblTitle];
        [_lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_ivRadio.mas_right).offset(8);
            make.top.equalTo(_ivRadio);
            make.right.equalTo(self);
            make.bottom.equalTo(_ivRadio);
        }];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _ivRadio.highlighted = selected;
}

@end
