//
//  NSDictionary+ValueType.h
//  BarCode
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 ghostwasd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (ValueType)

- (id)objectForKeyPath:(NSString *)keyPath;
- (NSString *)percentageForKeyPath:(NSString *)keyPath;
- (NSString *)moneyForKeyPath:(NSString *)keyPath;
- (NSString *)yuanForKeyPath:(NSString *)keyPath;
- (NSString *)stringForKeyPath:(NSString *)keyPath;
- (NSString *)getStringForKeyPath:(NSString *)keyPath;
- (double)doubleForKeyPath:(NSString *)keyPath;
- (NSInteger)integerForKeyPath:(NSString *)keyPath;
- (BOOL)boolForKeyPath:(NSString *)keyPath;
- (CGFloat)floatForKeyPath:(NSString *)keyPath;
- (NSString *)integerStringForKeyPath:(NSString *)keyPath;
- (NSString *)float3StringForKeyPath:(NSString *)keyPath;
- (NSArray *)arrayForKeyPath:(NSString *)keyPath;
- (NSMutableArray *)mutableArrayForKeyPath:(NSString *)keyPath;
- (NSMutableDictionary *)mutableDictionaryForKeyPath:(NSString *)keyPath;
- (NSDictionary *)dictForKeyPath:(NSString *)keyPath;

@end
