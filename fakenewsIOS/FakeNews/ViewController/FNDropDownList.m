

#import "FNDropDownList.h"
#import "Masonry.h"
#import "UIColor+HexColor.h"

@implementation FNDropDownList


- (id)init
{
    self = [super init];
    if (self)
    {
        self.btnInstruction = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnInstruction.backgroundColor = [UIColor whiteColor];
        [_btnInstruction setTitleColor:[UIColor colorWithHexValue:@"888888"] forState:UIControlStateNormal];
        [_btnInstruction setTitle:@"Instruction" forState:UIControlStateNormal];
        [self addSubview:_btnInstruction];
        [_btnInstruction mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_centerX);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@44);
        }];
        
        self.btnSaveAndExit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSaveAndExit.backgroundColor = [UIColor whiteColor];
        [_btnSaveAndExit setTitleColor:[UIColor colorWithHexValue:@"888888"] forState:UIControlStateNormal];
        [_btnSaveAndExit setTitle:@"Save And Exit" forState:UIControlStateNormal];
        [self addSubview:_btnSaveAndExit];
        [_btnSaveAndExit mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_centerX);
            make.right.equalTo(self);
            make.top.equalTo(_btnInstruction.mas_bottom);
            make.height.equalTo(@44);
        }];
        
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)hide
{
    self.hidden = YES;
}

@end
