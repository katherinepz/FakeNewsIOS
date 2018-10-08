

#import <UIKit/UIKit.h>
#import "FNSurveyType.h"

//@protocol FNSelectAnswerViewDelegate;

@interface FNSelectAnswerView : UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) NSMutableArray *arrayAnswers;
@property (nonatomic, assign) FN_SURVERY_TYPE type;
@property (nonatomic, strong) NSMutableSet *setSelect;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *key;
//@property (nonatomic, assign) id<FNSelectAnswerViewDelegate> delegate;

- (id)initWithDict:(NSDictionary *)dict index:(NSInteger)index;
- (NSMutableArray *)getSelectedAnswers;

@end

//@protocol FNSelectAnswerViewDelegate <NSObject>
//
//- (void)selectAnswerViewSelectionChanged:(FNSelectAnswerView *)view;
//
//@end
