//
//  UIView+Category.m
//  FireShadow
//
//  Created by liuhongmei on 15/5/19.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//

#import "UIView+Category.h"
#import "MBProgressHUD.h"

@implementation UIView (Category)

+ (instancetype)autolayoutView
{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    if (message) {
        hud.labelText = message;
        hud.mode = MBProgressHUDModeText;
    }
    else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (second > 0) {
        [hud hide:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

/**
 *  功能:添加一个像素的分割线
 */
- (void)addTopOnePixelDevider
{
    CGFloat lineWidth;
    
    if (ScreenWidth == 414) {
        lineWidth = 0.334;
    }else{
        lineWidth = 0.5;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, lineWidth)];
    label.backgroundColor = UIColorWithHex(0xd2d2d2);
    [self addSubview:label];
}


/**
 *  功能:添加一个像素的分割线
 */
- (void)addBottomOnePixelDevider
{
    CGFloat lineWidth;
    
    if (ScreenWidth == 414) {
        lineWidth = 0.334;
    }else{
        lineWidth = 0.5;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height -lineWidth, self.bounds.size.width, lineWidth)];
    label.backgroundColor = UIColorWithHex(0xececec);
    [self addSubview:label];
}


#pragma mark - 设置当前所有subview中tag为911的分割线为一个像素
- (void)resetDeviderLineToOnePixel
{
    if ([self shouldResetDeviderLineToOnePixel]) {
        [self layoutIfNeeded];
        [self updateConstraints];
    }
}

- (BOOL)shouldResetDeviderLineToOnePixel
{
    // 找出每一个view下所有的分割线，更新它的高度或者宽度为0.5, iPhone 6plus为0.334
    // 分割线的tag固定为 911
    BOOL flag = NO;
    
    for (UIView *view in self.subviews) {
        if (view.tag == 911) {
            // 枚举view下所有的subview
            for (NSLayoutConstraint *constraint in view.constraints)
            {
                if (constraint.firstAttribute == NSLayoutAttributeWidth ||
                    constraint.firstAttribute == NSLayoutAttributeHeight) {
                    
                    if (ScreenWidth == 414) {
                        constraint.constant = 0.334;
                    }else{
                        constraint.constant = 0.5;
                    }
                    
                    flag = YES;
                }
            }
        }else{
            if ([view shouldResetDeviderLineToOnePixel]) {
                flag = YES;
            }
        }
    }
    return flag;

}




@end
