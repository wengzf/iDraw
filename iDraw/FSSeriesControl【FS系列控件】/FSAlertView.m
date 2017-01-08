//
//  FSAlertView.m
//  LetMeSpend
//
//  Created by 翁志方 on 16/5/26.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import "FSAlertView.h"

@implementation FSAlertView


- (FSAlertView *)initWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                   cancelBlock:(void(^)())cancelBlock
                     sureBlock:(void(^)())sureBlock
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:sureButtonTitle, nil];
    
    self.delegate = self;
    
    cancelBlk = cancelBlock;
    sureBlk = sureBlock;
    
    return self;
}

// title cancel
- (FSAlertView *)initWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                   cancelBlock:(void(^)())cancelBlock
{
    return [self initWithTitle:title
                       message:nil
             cancelButtonTitle:cancelButtonTitle
               sureButtonTitle:nil
                   cancelBlock:cancelBlock
                     sureBlock:nil];
}

// title cancel sure
- (FSAlertView *)initWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                   cancelBlock:(void(^)())cancelBlock
                     sureBlock:(void(^)())sureBlock
{
    return [self initWithTitle:title
                       message:nil
             cancelButtonTitle:cancelButtonTitle
               sureButtonTitle:nil
                   cancelBlock:cancelBlock
                     sureBlock:nil];
}

// message cancel
- (FSAlertView *)initWithMessage:(NSString *)message
               cancelButtonTitle:(NSString *)cancelButtonTitle
                     cancelBlock:(void(^)())cancelBlock
{
    return [self initWithTitle:nil
                       message:message
             cancelButtonTitle:cancelButtonTitle
               sureButtonTitle:nil
                   cancelBlock:cancelBlock
                     sureBlock:nil];
}

// message cancel sure
- (FSAlertView *)initWithMessage:(NSString *)message
               cancelButtonTitle:(NSString *)cancelButtonTitle
                 sureButtonTitle:(NSString *)sureButtonTitle
                     cancelBlock:(void(^)())cancelBlock
                       sureBlock:(void(^)())sureBlock
{
    return [self initWithTitle:nil
                       message:message
             cancelButtonTitle:cancelButtonTitle
               sureButtonTitle:sureButtonTitle
                   cancelBlock:cancelBlock
                     sureBlock:sureBlock];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        if (cancelBlk)  cancelBlk();
    }else{
        if (sureBlk) sureBlk();
    }
}

@end









