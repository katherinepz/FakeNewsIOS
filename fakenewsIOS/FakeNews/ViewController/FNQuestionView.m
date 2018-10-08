
#import "FNQuestionView.h"
#import "UIColor+HexColor.h"
#import "Masonry.h"
#import "NSDictionary+ValueType.h"
#import "SystemInfo.h"
#import "NSString+UILabelSize.h"
#import "DEBUGLOG.h"

@implementation FNQuestionView

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
        self.lblTitle = [[UILabel alloc] init];
        _lblTitle.numberOfLines = 0;
        _lblTitle.font = [UIFont systemFontOfSize:24];
        [self addSubview:_lblTitle];
        [_lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self);
        }];
        
        self.lblContent = [[UILabel alloc] init];
        _lblContent.numberOfLines = 0;
//        _lblContent.lineBreakMode = NSLineBreakByCharWrapping;
//        _lblContent.backgroundColor = [UIColor blackColor];
//        _lblContent.preferredMaxLayoutWidth = screenWidth() - 40;
        _lblContent.font = [UIFont systemFontOfSize:14];
        [self addSubview:_lblContent];
        [_lblContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _lblContent.textColor = [UIColor colorWithHexValue:@"888888"];
        [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(_lblTitle.mas_bottom);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-10.0).priorityHigh();

        }];
        
//        self.tvContent = [[UITextView alloc] init];
//        _tvContent.font = [UIFont systemFontOfSize:20];
//        _tvContent.textContainerInset = UIEdgeInsetsZero;
////        _tvContent.userInteractionEnabled = NO;
//        [self addSubview:_tvContent];
//        [_tvContent setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal|UILayoutConstraintAxisVertical];
//        _tvContent.textColor = [UIColor colorWithHexValue:@"888888"];
//        [_tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self).offset(20);
//            make.right.equalTo(self).offset(-20);
//            make.top.equalTo(_lblTitle.mas_bottom);
//        }];

//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(_tvContent.mas_bottom).offset(20);
//        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_lblContent.mas_bottom).offset(20);
        }];
    }
    
    return self;
}
- (void)configureWithDictionary:(NSDictionary *)dict
{
    _lblTitle.text = [dict stringForKeyPath:@"title"];
    _lblContent.text = [dict stringForKeyPath:@"text"];
    
    if (_lblContent.text.length > 10000) {
        _lblContent.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        _lblContent.font = [UIFont systemFontOfSize:16];
    }
//    _tvContent.text = [dict stringForKeyPath:@"text"];
//
//    [_tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@0).priorityHigh();
//    }];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CGSize newSize = [_tvContent sizeThatFits:CGSizeMake(screenWidth() - 40, MAXFLOAT)];
//        [_tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo([NSNumber numberWithFloat:newSize.height + 30]).priorityHigh();
//        }];
//
//        [self setNeedsLayout];
//    });
    
//    CGSize size = [_lblContent.text getContentSizeWithFont:_lblContent.font constrainToSize:CGSizeMake(screenWidth()-40, MAXFLOAT)];
//    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.height.equalTo([NSNumber numberWithFloat:size.height]).priorityHigh();
//    }];
}


@end
