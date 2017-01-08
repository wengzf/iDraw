//
//  CanvasModel.h
//  iDraw
//
//  Created by 翁志方 on 2016/10/28.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 
 * 全局单例，用于封装函数映射关系
 *
 *
 *
 *
 */

@interface CanvasModel : NSObject

@property (nonatomic, strong) NSDictionary *keyFunctionDic;

- (CanvasModel *)shareInstance;



@end
