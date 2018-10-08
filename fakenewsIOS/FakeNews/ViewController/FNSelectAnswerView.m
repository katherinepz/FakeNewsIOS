

#import "FNSelectAnswerView.h"
#import "Masonry.h"
#import "NSDictionary+ValueType.h"
#import "FNRadioButton.h"

@implementation FNSelectAnswerView

- (id)initWithDict:(NSDictionary *)dict index:(NSInteger)index
{
    self = [super init];
    
    if (self)
    {
        self.setSelect = [NSMutableSet set];
        
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        self.lblTitle = [[UILabel alloc] init];
        _lblTitle.numberOfLines = 0;
        _lblTitle.text = [NSString stringWithFormat:@"%d. %@", index, [dict stringForKeyPath:@"q"]];
        [_lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
        
        self.arrayAnswers = [NSMutableArray array];
        
        UIView *lastView = _lblTitle;
        NSArray *array = [dict arrayForKeyPath:@"a"];
        for (NSInteger i = 0; i < array.count; ++ i) {
            FNRadioButton *btn = [[FNRadioButton alloc] init];
            NSString *title = [array objectAtIndex:i];
            btn.lblTitle.text = title;
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.top.equalTo(lastView.mas_bottom).offset(10);
            }];
            
            lastView = btn;
            [_arrayAnswers addObject:btn];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    
    return self;
}

- (void)btnClick:(FNRadioButton *)button
{
    if (_type == FN_SURVERY_TYPE_SINGLE_SELECT || _type == FN_SURVERY_TYPE_TRUE_FALSE)
    {
        if (_setSelect.count > 0)
        {
            FNRadioButton *btn = [_setSelect anyObject];
            btn.selected = NO;
            [_setSelect removeObject:btn];
        }
        
        button.selected = YES;
        [_setSelect addObject:button];
        
//        if ([_delegate respondsToSelector:@selector(selectAnswerViewSelectionChanged:)]) {
//            [_delegate selectAnswerViewSelectionChanged:self];
//        }
    }
    else
    {
        if ([_setSelect containsObject:button])
        {
            button.selected = NO;
            [_setSelect removeObject:button];
        }
        else
        {
            button.selected = YES;
            [_setSelect addObject:button];
        }
        
//        if ([_delegate respondsToSelector:@selector(selectAnswerViewSelectionChanged:)]) {
//            [_delegate selectAnswerViewSelectionChanged:self];
//        }
    }
}

- (NSMutableArray *)getSelectedAnswers
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (FNRadioButton *btn in _setSelect) {
        NSString *selectTitle = btn.lblTitle.text;
        [array addObject:selectTitle];
    }
    
    return array;
}

@end
