//
//  AnimationCurveViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/8.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "AnimationCurveViewController.h"

@interface AnimationCurveViewController ()

@end

@implementation AnimationCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)testView
{
    UIView *view = [[UIView alloc] initWithFrame:ScreenBounds];
    view.backgroundColor = [UIColor lightGrayColor];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
    // 计算参数
    CGFloat arr[] = {
        16,  26,  35,  39,  42,
        42,  39,  39,  38,  33,
        27,  26,  23,  22,  18,
        16,  14,  12,  11,  11,
        9,  8,  5,  5,  4,
        4,  4,  3,  3,  3,
        3,  2,  2,  2,  2,
        1,  1};
    
    int num = 37;
    CGFloat sum = 0;
    CGFloat acc = 0;
    for (int i=0; i<num; ++i) {
        sum += arr[i];
    }
    CGFloat sx,sy;
    CGFloat width = 414-60;
    CGFloat unitWidth = width / num;
    
    sx = 30;
    sy = 400;
    
    
    acc = sum;
    for (int i=0; i<num; ++i) {
        acc -= arr[i];
        CGFloat proportion = acc/sum;
        
        printf("%.6lf,\n",acc/sum);
        CGFloat height = proportion * 300;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy-height, unitWidth-5, height)];
        label.backgroundColor = [UIColor darkGrayColor];
        [view addSubview:label];
        
        sx += unitWidth;
    }
}


@end
