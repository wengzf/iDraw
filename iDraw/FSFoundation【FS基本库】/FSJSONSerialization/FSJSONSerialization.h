//
//  FSJSONSerialization.h
//  SystemNavigation
//
//  Created by 翁志方 on 16/8/22.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSJSONSerialization : NSObject
{
    NSMutableString *curStr;
    NSInteger curIndex;
}
- (id)objectWithString:(NSString *)string;


@end
