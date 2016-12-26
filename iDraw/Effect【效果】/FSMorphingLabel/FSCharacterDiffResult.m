//
//  FSCharacterDiffResult.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSCharacterDiffResult.h"

@implementation FSCharacterDiffResult

+ (NSArray *)compareString:(NSString *)lstr withRightString:(NSString *) rstr
{
    NSInteger llen = lstr.length;
    NSInteger rlen = rstr.length;
    
    NSMutableArray *resArr = [NSMutableArray arrayWithCapacity:llen];
    
    NSInteger maxlen = MAX(llen, rlen);
    
    BOOL *chooseFlagArr = malloc(sizeof(BOOL)*rlen);
    memset(chooseFlagArr, 0, sizeof(BOOL)*rlen);
    
    // 计算 diffObj
    for (int i=0; i<llen; ++i) {
        
        unichar lch = [lstr characterAtIndex:i];
        
        FSCharacterDiffResult *diffObj = [FSCharacterDiffResult new];
        [resArr addObject:diffObj];
        BOOL findCharacter = NO;
        for (int j=0; j<rlen; ++j) {
            if (chooseFlagArr[j]) {
                continue;
            }
            
            unichar rch = [rstr characterAtIndex:j];
            if (lch == rch) {
                findCharacter = YES;
                chooseFlagArr[j] = YES;
                
                if (i==j) {
                    diffObj.diffType = kCharacterDiffTypeSame;
                }else{
                    diffObj.diffType = kCharacterDiffTypeMove;
                    if (i<rlen) {
                        diffObj.diffType = kCharacterDiffTypeMoveAndAdd;
                    }
                    diffObj.moveOffset = j - i;
                }
                break;
            }
        }// for(j)
        
        // 字符不在右边字符串
        if (!findCharacter) {
            if (i<rlen-1) {
                diffObj.diffType = kCharacterDiffTypeReplace;
            }else{
                diffObj.diffType = kCharacterDiffTypeDelete;
            }
            
        }
    }// for(i)
    
    for (int i=0; i<llen; ++i) {
        FSCharacterDiffResult *diffObj = resArr[i];
        if (diffObj.diffType == kCharacterDiffTypeMoveAndAdd ||
            diffObj.diffType == kCharacterDiffTypeMove) {
            
            NSInteger index = i + diffObj.moveOffset;
            if (index < resArr.count) {
                FSCharacterDiffResult *obj = resArr[index];
                obj.skip = YES;
            }
            
        }
    }
    
    free(chooseFlagArr);
    
    return resArr;
}


@end
