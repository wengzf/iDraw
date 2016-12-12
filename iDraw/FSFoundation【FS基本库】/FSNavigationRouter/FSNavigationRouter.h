//
//  FSRouter.h
//  LetMeSpend
//
//  Created by 翁志方 on 2016/10/8.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FSNavigationRouter : NSObject

+ (FSNavigationRouter *)shareInstance;


// 处理原生请求
- (void)pushCurrentNavVC:(UINavigationController *)curNav
                      to:(NSString *)className
              withParams:(NSDictionary *)params;

- (void)presentCurrentVC:(UIViewController *)vc
                      to:(NSString *)className
              withParams:(NSDictionary *)params;


// 处理webView请求
- (void)handleRequest:(NSURL *)url;


// 处理推送通知
- (void)handlePush:(NSString *)url;



@end
