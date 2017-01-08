//
//  NSString+URLConvert.m
//  BlueWhale
//
//  Created by Zhu Boxing on 14-5-5.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "NSString+URLConvert.h"

@implementation NSString (URLConvert)

- (NSString *) URLEncodedString {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
    
}

- (NSString *)URLDecodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    return result;
}
@end
