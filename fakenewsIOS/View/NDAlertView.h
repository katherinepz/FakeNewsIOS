//
//  NDAlertView.h
//  NextDress
//
//  Created by ghost on 12-7-27.
//  Copyright 2012年 ghost. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NDAlertViewBlock) (NSInteger buttonIndex);
typedef void (^NDAlertViewWithInputBlock) (UITextField *textField);

@interface NDAlertView : NSObject <UIAlertViewDelegate>

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
             okButtonTitle:(NSString *)okButtonTitle
         cancelButtonBlock:(void(^)(NSInteger buttonIndex))cancelButtonBlock
             okButtonBlock:(void(^)(NSInteger buttonIndex))okButtonBlock;

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
            buttonOneTitle:(NSString *)buttonOneTitle
            buttonTwoTitle:(NSString *)buttonTwoTitle
          buttonThreeTitle:(NSString *)buttonThreeTitle
          otherButtonBlock:(void(^)(NSInteger buttonIndex))otherButtonBlock;

+ (void)inputAlertViewWithTitle:(NSString *)title
                    placeHolder:(NSString *)placeHolder
              cancelButtonTitle:(NSString *)cancelButtonTitle
                  okButtonTitle:(NSString *)okButtonTitle
                  okButtonBlock:(void(^)(UITextField *textField))inputOKButtonBlock;

@end
