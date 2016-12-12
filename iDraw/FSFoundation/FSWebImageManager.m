//
//  FSWebImageManager.m
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSWebImageManager.h"

@interface FSWebImageManager()

@property (nonatomic, strong) NSMutableArray *operationQueues;

@end


@implementation FSWebImageManager




+ (FSWebImageManager *)sharedWebImageManager
{
    static FSWebImageManager *webImageCache;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webImageCache = [[FSWebImageManager alloc] init];
    });
    return webImageCache;
}


@end
