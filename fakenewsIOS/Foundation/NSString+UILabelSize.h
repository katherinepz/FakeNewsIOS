//
//  NSString+UILabelSize.h
//  Decorate
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (UILabelSize)

- (CGSize)getContentSizeWithFont:(UIFont *)font constrainToSize:(CGSize)size;

@end
