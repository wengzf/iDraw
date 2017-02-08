//
//  FSArrowTextView.h
//  iCarrot
//
//  Created by 翁志方 on 2017/2/8.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSArrowTextView : UIView
{
    UILabel *label1;
    UILabel *label2;
    NSString *str1;
    NSString *str2;
    
    UIImageView *arrowImage;
}
- (instancetype)initWithString1:(NSString *)s1 string2:(NSString *)s2;


@end
