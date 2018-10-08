

#import "FNTextAnswerView.h"
#import "Masonry.h"
#import "NSDictionary+ValueType.h"

@implementation FNTextAnswerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithDict:(NSDictionary *)dict index:(NSInteger)index
{
    self = [super init];
    
    if (self) {
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        self.lblTitle = [[UILabel alloc] init];
        _lblTitle.numberOfLines = 0;
        [_lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _lblTitle.text = [NSString stringWithFormat:@"%d. %@", index, [dict stringForKeyPath:@"q"]];
        [self addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
        
        self.tfAnswer = [[UITextField alloc] init];
        [self addSubview:_tfAnswer];
        _tfAnswer.layer.borderColor = [UIColor blackColor].CGColor;
        _tfAnswer.layer.borderWidth = 0.5f;
        [_tfAnswer addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEnd];
        [_tfAnswer addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_tfAnswer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_lblTitle.mas_bottom).offset(10);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@44);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
    }
    
    return self;
}

@end
