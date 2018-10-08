//
//  NSString+UILabelSize.m
//  Decorate
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 jiemeihome. All rights reserved.
//

#import "NSString+UILabelSize.h"


@implementation NSString (UILabelSize)

- (CGSize)getContentSizeWithFont:(UIFont *)font constrainToSize:(CGSize)size
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

@end
