//
//  NSString+NZExtended.h
//  FireShadow
//
//  Created by 翁志方 on 15/8/6.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NZExtended)

// 数字字符串转成带‘，’的金额字符串
- (NSString *)moneyString;

//带逗号的钱数 转化 成float
- (float)stringFormaterToFloat:(NSString *)string;



- (NSString *)stringByTrimZero;

@end
