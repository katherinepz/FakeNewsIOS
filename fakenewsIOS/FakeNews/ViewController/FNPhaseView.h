

#import <UIKit/UIKit.h>
#import "FNPhase.h"

@interface FNPhaseView : UIView

@property (nonatomic, strong) UIImageView *ivPhase1;
@property (nonatomic, strong) UIImageView *ivPhase2;
@property (nonatomic, strong) UIImageView *ivSurvey;
@property (nonatomic, strong) UIImageView *ivFeedBack;

@property (nonatomic, strong) UIImageView *ivDot1;
@property (nonatomic, strong) UIImageView *ivDot2;
@property (nonatomic, strong) UIImageView *ivDot3;

@property (nonatomic, strong) UILabel *lblPhase1;
@property (nonatomic, strong) UILabel *lblPhase2;
@property (nonatomic, strong) UILabel *lblSurvey;
@property (nonatomic, strong) UILabel *lblFeedBack;

- (void)addIcon;
- (void)configureWithPhase:(FN_PHASE)phase index:(NSInteger)index total:(NSInteger)total;

@end
