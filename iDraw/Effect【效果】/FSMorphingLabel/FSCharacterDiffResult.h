//
//  FSCharacterDiffResult.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>

// 计算两个字符串之间区别

typedef NS_ENUM(NSInteger, FSCharacterDiffType){
    kCharacterDiffTypeSame,
    kCharacterDiffTypeAdd,
    kCharacterDiffTypeDelete,
    kCharacterDiffTypeMove,
    kCharacterDiffTypeMoveAndAdd,
    kCharacterDiffTypeReplace
};

@interface FSCharacterDiffResult : NSObject

@property (nonatomic, assign) FSCharacterDiffType diffType;

@property (nonatomic, assign) int moveOffset;

@property (nonatomic, assign) BOOL skip;


// 计算两个字符串之间的区别
+ (NSArray *)compareString:(NSString *)lstr withRightString:(NSString *) rstr;


@end
