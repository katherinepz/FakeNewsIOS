

#import <UIKit/UIKit.h>
#import "FNBaseController.h"
#import "FNPhase.h"

//typedef enum FN_INSTRUCTION
//{
//    FN_INSTRUCTION_1,
//    FN_INSTRUCTION_2
//}
//FN_INSTRUCTION;

@interface FNInstructionController : FNBaseController

@property (nonatomic, strong) UIScrollView *scContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UIImageView *ivScale;
@property (nonatomic, strong) UILabel *lblContent2;
@property (nonatomic, strong) UIButton *btnNext;
//@property (nonatomic, assign) FN_INSTRUCTION state;
@property (nonatomic, assign) FN_PHASE phase;
@property (nonatomic, assign) BOOL embed;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@end
