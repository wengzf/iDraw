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
    
    NSInteger maxlen = MAX(llen, rlen);
    NSMutableArray *resArr = [NSMutableArray arrayWithCapacity:maxlen];
    
    BOOL *chooseFlagArr = malloc(sizeof(BOOL)*rlen);
    memset(chooseFlagArr, 0, sizeof(BOOL)*rlen);
    
    // 计算 diffObj
    for (int i=0; i<maxlen; ++i) {
        FSCharacterDiffResult *diffObj = [FSCharacterDiffResult new];
        [resArr addObject:diffObj];
        
        if (i>=llen) {
            diffObj.diffType = kCharacterDiffTypeAdd;
            continue;
        }
        
        unichar lch = [lstr characterAtIndex:i];
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
                    if (i<rlen) {
                        diffObj.diffType = kCharacterDiffTypeMoveAndAdd;
                    }else{
                        diffObj.diffType = kCharacterDiffTypeMove;
                    }
                    diffObj.moveOffset = j - i;
                }
                break;
            }
        }// for(j)
        
        // 字符不在右边字符串
        if (!findCharacter) {
            if (i<rlen) {
                diffObj.diffType = kCharacterDiffTypeReplace;
            }else{
                diffObj.diffType = kCharacterDiffTypeDelete;
            }
            
        }
    }// for(i)
    
    for (int i=0; i<maxlen; ++i) {
        FSCharacterDiffResult *diffObj = resArr[i];
        if (diffObj.diffType == kCharacterDiffTypeMoveAndAdd ||
            diffObj.diffType == kCharacterDiffTypeMove) {
            
            NSInteger index = i + diffObj.moveOffset;
            if (index < maxlen) {
                FSCharacterDiffResult *obj = resArr[index];
                obj.skip = YES;
            }
            
        }
    }
    
    free(chooseFlagArr);
    
    return resArr;
}


@end
