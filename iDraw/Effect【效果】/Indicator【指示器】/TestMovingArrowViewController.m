//
//  TestMovingArrowViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/15.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "TestMovingArrowViewController.h"

#import "MovingArrow.h"


@interface TestMovingArrowViewController ()
{
    MovingArrow *arrow;
}
@end

@implementation TestMovingArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 小箭头
    {
        arrow = [[MovingArrow alloc] initWithFrame:CGRectMake(100, 100, 120, 100)];
        [self.view addSubview:arrow];
        
        [arrow startAnimation];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 120, 100)];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(btnClked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnClked
{
    static BOOL flag = true;
    
    if (flag) {
        [arrow pauseAnimation];
    }else{
        [arrow resumeAnimation];
    }
    flag = !flag;
}



@end
