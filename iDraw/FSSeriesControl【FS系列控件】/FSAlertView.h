//
//  FSAlertView.h
//  LetMeSpend
//
//  Created by 翁志方 on 16/5/26.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSAlertView : UIAlertView<UIAlertViewDelegate>
{
    void(^cancelBlk)();
    void(^sureBlk)();
}

- (FSAlertView *)initWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                   cancelBlock:(void(^)())cancelBlock
                     sureBlock:(void(^)())sureBlock;


// title cancel
- (FSAlertView *)initWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                   cancelBlock:(void(^)())cancelBlock;
// title cancel sure
- (FSAlertView *)initWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                   cancelBlock:(void(^)())cancelBlock
                     sureBlock:(void(^)())sureBlock;

// message cancel
- (FSAlertView *)initWithMessage:(NSString *)message
               cancelButtonTitle:(NSString *)cancelButtonTitle
                     cancelBlock:(void(^)())cancelBlock;

// message cancel sure
- (FSAlertView *)initWithMessage:(NSString *)message
               cancelButtonTitle:(NSString *)cancelButtonTitle
                 sureButtonTitle:(NSString *)sureButtonTitle
                     cancelBlock:(void(^)())cancelBlock
                       sureBlock:(void(^)())sureBlock;



@end
