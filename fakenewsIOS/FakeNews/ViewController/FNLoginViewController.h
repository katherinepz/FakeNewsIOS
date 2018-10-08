

#import <UIKit/UIKit.h>
#import "JMRequestObject.h"
#import "FNBaseController.h"

@interface FNLoginViewController : FNBaseController

@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UITextField *tfCode;
@property (nonatomic, strong) UIButton *btnLogin;
@property (nonatomic, strong) JMRequestObject *loginRequest;

@end
