//
//  NSString+NZExtended.m
//  FireShadow
//
//  Created by 翁志方 on 15/8/6.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//

#import "NSString+NZExtended.h"

@implementation NSString (NZExtended)


// 数字字符串转成带‘，’的金额字符串
- (NSString *)moneyString
{
    NSMutableString *resStr = [NSMutableString new];
    
    int index = (int)self.length;
    
    // 从字符串尾部查找小数部分
    NSRange range = [self rangeOfString:@"."];
    if (range.length != 0) {
        range.length = self.length - range.location;
        [resStr appendString: [self substringWithRange:range]];
        
        index = (int)range.location;
    }
    
    while (index>0) {
        
        if (index>3) {
            // 加逗号
            range.location = index-3;
            range.length = 3;
            [resStr insertString:[self substringWithRange:range] atIndex:0];
            [resStr insertString:@"," atIndex:0];
            
        }else{
            range.location = 0;
            range.length = index;
            [resStr insertString:[self substringWithRange:range] atIndex:0];
        }
        index -= 3;
    }
    
    return resStr;
}

- (float )stringFormaterToFloat:(NSString *)string
{
    float floatMoney = 0.;
    if (![string isEqualToString:@""] && ![string isEqual:[NSNull null]])
    {
        floatMoney = [[NSString stringWithFormat:@"%.2f",[[string stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]] floatValue];
    }
    return floatMoney;
}


- (NSString *)stringByTrimZero
{
    NSString *str = [NSString stringWithFormat:@"*%@",self];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    return [str substringFromIndex:1];
}


@end
