

#import <UIKit/UIKit.h>

@interface FNTextAnswerView : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UITextField *tfAnswer;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *key;

- (id)initWithDict:(NSDictionary *)dict index:(NSInteger)index;

@end
