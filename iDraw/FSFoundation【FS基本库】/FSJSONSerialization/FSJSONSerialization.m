//
//  FSJSONSerialization.m
//  SystemNavigation
//
//  Created by 翁志方 on 16/8/22.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSJSONSerialization.h"

@implementation FSJSONSerialization


- (id)objectWithString:(NSString *)string
{
    // 去除空格等特殊字符
    curStr = [NSMutableString string];
    for (int i=0; i<string.length; ++i) {
        unichar ch = [string characterAtIndex:i];
        if (![[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:ch]){
            unichar cStr[2];
            cStr[0] = ch;
            cStr[1] = 0;
            [curStr appendString:[NSString stringWithCString:cStr encoding:NSUTF8StringEncoding]];
        }
    }
    
    curIndex = 0;
    
    if ([curStr characterAtIndex:0] == '\{') {
        return [self findDictionary];
    }else{
        return [self findArray];
    }
}

- (id)findDictionary
{
    if ([self checkChar:'{']) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        while (1) {
            unichar tmpch = [curStr characterAtIndex:curIndex];
            
            if (tmpch != '\"' && [self checkChar:'}']) {
                return dic;
            }
            NSString *keyStr = [self findString];
            
            if (keyStr == nil) {
                if ([self checkChar:'}']) {
                    return dic;
                }
            }else if ([self checkChar:':']) {
                unichar ch = [curStr characterAtIndex:curIndex];
                
                id value = [NSNull null];
                
                if (ch == '{') {
                    value = [self findDictionary];
                }else if (ch == '[') {
                    value = [self findArray];
                }else if (ch == '\"') {
                    value = [self findString];
                }else if ('0'<=ch && ch<='9') {
                    value = [self findNumber];
                }else if ([self checkTrue]) {
                    value = [NSNumber numberWithBool:true];
                }else if ([self checkFalse]) {
                    value = [NSNumber numberWithBool:false];
                }
                
                NSLog(@"%@",dic);
                NSLog(@"keyStr %@ value\n%@",keyStr, value);
                [dic setObject:value forKey:keyStr];
                
                if (![self checkChar:',']) {
                    //  }
                    return dic;
                }
            }
        }
    }
    return nil;
}

- (id)findArray
{
    if ([self checkChar:'[']) {
        NSMutableArray *arr = [NSMutableArray array];
        
        while (1) {
            unichar ch = [curStr characterAtIndex:curIndex];
            
            id value = [NSNull null];
            
            if (ch == '{') {
                value = [self findDictionary];
            }else if (ch == '[') {
                value = [self findArray];
            }else if (ch == '\"') {
                value = [self findString];
            }else if ('0'<=ch && ch<='9') {
                value = [self findNumber];
            }else if ([self checkTrue]) {
                value = [NSNumber numberWithBool:true];
            }else if ([self checkFalse]) {
                value = [NSNumber numberWithBool:false];
            }else if ([self checkChar:']']){
                return arr;
            }
            
            [arr addObject:value];
            
            if (![self checkChar:',']) {    // ]
                return arr;
            }
        }
    }
    return nil;
}
- (NSString *)findString
{
    NSMutableString *tmpStr = [NSMutableString string];
    if ([self checkChar:'\"']) {
        while (1) {
            unichar ch = [curStr characterAtIndex:curIndex++];
            if (ch != '\"'){
                unichar cStr[2];
                cStr[0] = ch;
                cStr[1] = 0;
                [tmpStr appendString:[NSString stringWithCString:cStr encoding:NSUTF8StringEncoding]];
            }else{
                break;
            }
            
        }
    }
    
    return tmpStr;
}
- (NSNumber *)findNumber
{
    double pow = 1;
    double sum = 0;
    BOOL decimalFlag = NO;
    while (1) {
        unichar ch = [curStr characterAtIndex:curIndex];
        if ('0'<=ch && ch<='9'){
            if (!decimalFlag) {
                sum = sum*10 + ch - '0';
            }else{
                pow /= 10.0;
                sum += (ch - '0')*pow;
            }
        }else if (ch == '.'){
            decimalFlag = YES;
        }else{
            break;
        }
        ++curIndex;
    }
    
    return [NSNumber numberWithDouble:sum];
}
- (BOOL)checkChar:(unichar) ch
{
    return [curStr characterAtIndex:curIndex++] == ch;
}

- (BOOL)checkTrue
{
    BOOL flag = [[curStr substringFromIndex:curIndex] hasPrefix:@"true"];
    if (flag) {
        curIndex += 4;
        return YES;
    }
    return NO;
}
- (BOOL)checkFalse
{
    BOOL flag = [[curStr substringFromIndex:curIndex] hasPrefix:@"false"];
    if (flag) {
        curIndex += 5;
        return YES;
    }
    return NO;
}
- (BOOL)checkNull
{
    BOOL flag = [[curStr substringFromIndex:curIndex] hasPrefix:@"null"];
    if (flag) {
        curIndex += 4;
        return YES;
    }
    return NO;
}


@end
