//
//  FSRouter.m
//  LetMeSpend
//
//  Created by 翁志方 on 2016/10/8.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import "FSNavigationRouter.h"
#import "NSObject+FSKeyValue.h"

@implementation FSNavigationRouter


+ (FSNavigationRouter *)shareInstance
{
    static FSNavigationRouter *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[FSNavigationRouter  alloc] init];
    });
    return obj;
}


// 处理原生请求
- (void)pushCurrentNavVC:(UINavigationController *)curNav to:(NSString *)className withParams:(NSDictionary *)params
{
    id obj = [[NSClassFromString(className) alloc] init];
    
    [obj fs_setKeyValues:params];
    
    [curNav pushViewController:obj animated:YES];
}

- (void)presentCurrentVC:(UIViewController *)vc to:(NSString *)className withParams:(NSDictionary *)params
{
    id obj = [[NSClassFromString(className) alloc] init];
    
    [obj fs_setKeyValues:params];
    
    [vc presentViewController:obj];
}


// 处理webView请求
- (void)handleRequest:(NSURL *)url
{
    
}


// 处理推送通知
- (void)handlePush:(NSString *)url
{
    
}


@end
