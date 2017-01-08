//
//  NSObject+FSKeyValue.h
//  SystemNavigation
//
//  Created by 翁志方 on 16/8/25.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPropertyType : NSObject





@end




@interface NSObject (FSKeyValue)

// 模型转字典

// 字典转模型
+ (instancetype)fs_objectWithDic:(NSDictionary *)dic;


- (instancetype)fs_setKeyValues:(NSDictionary *)dic;


@end
