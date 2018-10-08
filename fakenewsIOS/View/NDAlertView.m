//
//  NDAlertView.m
//  NextDress
//
//  Created by ghost on 12-7-27.
//  Copyright 2012年 ghost. All rights reserved.
//

#import "NDAlertView.h"
#import "DEBUGLOG.h"

@interface NDAlertView()

@property (nonatomic, strong) NDAlertViewBlock cancelBlock;
@property (nonatomic, strong) NDAlertViewBlock okBlock;
@property (nonatomic, strong) NDAlertViewBlock otherBlock;
@property (nonatomic, strong) NDAlertViewWithInputBlock inputOKBlock;
@property (nonatomic, strong) NDAlertView *retainSelf;

@end

@implementation NDAlertView

- (void)dealloc
{
    DEBUGLOG(@"NDAlertView dealloc");
}

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    [av show];
}

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
             okButtonTitle:(NSString *)okButtonTitle
         cancelButtonBlock:(void(^)(NSInteger buttonIndex))cancelButtonBlock
             okButtonBlock:(void(^)(NSInteger buttonIndex))okButtonBlock
{
    NDAlertView *alertView = [[NDAlertView alloc] init];
    
    alertView.cancelBlock = cancelButtonBlock;
    alertView.okBlock = okButtonBlock;
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:message
                                                delegate:alertView
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:okButtonTitle, nil];
    [av show];
    
    alertView.retainSelf = alertView;
}

+ (void)inputAlertViewWithTitle:(NSString *)title
                    placeHolder:(NSString *)placeHolder
              cancelButtonTitle:(NSString *)cancelButtonTitle
                  okButtonTitle:(NSString *)okButtonTitle
                  okButtonBlock:(void(^)(UITextField *textField))inputOKButtonBlock
{
    NDAlertView *alertView = [[NDAlertView alloc] init];
    
    alertView.inputOKBlock = inputOKButtonBlock;
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:nil
                                                delegate:alertView
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:okButtonTitle, nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].placeholder = placeHolder;
    [av show];
    
    alertView.retainSelf = alertView;
}

+ (void)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
            buttonOneTitle:(NSString *)buttonOneTitle
            buttonTwoTitle:(NSString *)buttonTwoTitle
          buttonThreeTitle:(NSString *)buttonThreeTitle
          otherButtonBlock:(void(^)(NSInteger buttonIndex))otherButtonBlock
{
    NDAlertView *alertView = [[NDAlertView alloc] init];
    
    alertView.otherBlock = otherButtonBlock;
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title
                                                 message:message
                                                delegate:alertView
                                       cancelButtonTitle:nil
                                       otherButtonTitles:buttonOneTitle, buttonTwoTitle, buttonThreeTitle, nil];
    [av show];
    
    alertView.retainSelf = alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.otherBlock != nil)
    {
        self.otherBlock(buttonIndex);
    }
    else
    {
        if (buttonIndex == alertView.cancelButtonIndex)
        {
            if (self.cancelBlock != nil)
            {
                self.cancelBlock(buttonIndex);
            }
        }
        else
        {
            if (self.inputOKBlock != nil)
            {
                self.inputOKBlock([alertView textFieldAtIndex:0]);
            }
            
            if (self.okBlock != nil)
            {
                self.okBlock(buttonIndex);
            }
        }
    }
    
    self.retainSelf = nil;
}

@end
