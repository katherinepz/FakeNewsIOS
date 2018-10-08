

#import <UIKit/UIKit.h>

@interface FNQuestionView : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblContent;
//@property (nonatomic, strong) UITextView *tvContent;

- (void)configureWithDictionary:(NSDictionary *)dict;

@end
