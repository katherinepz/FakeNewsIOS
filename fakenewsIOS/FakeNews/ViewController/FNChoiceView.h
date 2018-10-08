

#import <UIKit/UIKit.h>
#import "FNPhase.h"

extern const NSInteger FN_FALSE;
extern const NSInteger FN_TRUE;

@protocol FNChoiceViewDelegate;

@interface FNChoiceView : UIView

@property (nonatomic, strong) UILabel *lblTitle1;
@property (nonatomic, strong) UISegmentedControl *scTrue;
@property (nonatomic, strong) UILabel *lblTitle2;
@property (nonatomic, strong) UISegmentedControl *scFalse;
@property (nonatomic, strong) UIButton *btnNext;
@property (nonatomic, weak) id<FNChoiceViewDelegate> delegate;

- (NSInteger)getSelectValue;
- (void)countDown;
- (void)configureWithPhase:(FN_PHASE)phase;

@end

@protocol FNChoiceViewDelegate <NSObject>

- (void)choiceView:(FNChoiceView *)choiceView didSelectedValue:(NSInteger)value;

@end
