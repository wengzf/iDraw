//
//  FSArrowTextView.m
//  iCarrot
//
//  Created by 翁志方 on 2017/2/8.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "FSArrowTextView.h"
#import "UIView+XQ.h"

@implementation FSArrowTextView


- (instancetype)initWithString1:(NSString *)s1 string2:(NSString *)s2
{
    self = [super init];
    
    [self configureWithString1:str1 string2:str2];
    
    return self;
}

- (void)configureWithString1:(NSString *)s1 string2:(NSString *)s2
{
    str1 = s1;
    str2 = s2;
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 60, 20)];
    label1.text = str1;
    label1.textColor = [UIColor orangeColor];
    label1.font = [UIFont boldSystemFontOfSize:20];
    [label1 sizeToFit];
    [self addSubview:label1];
    
    arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3_thread_arrow"]];
    [self addSubview:arrowImage];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 60, 20)];
    label2.text = str2;
    label2.textColor = [UIColor greenColor];
    label2.font = [UIFont boldSystemFontOfSize:20];
    [label2 sizeToFit];
    [self addSubview:label2];
    
    arrowImage.centerY = label1.centerY;
    label2.centerY = label1.centerY;
    
    arrowImage.left = label1.right+4;
    label2.left = arrowImage.right+4;
    
}


@end
