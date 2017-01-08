//
//  ImageAnalysisViewController.m
//  ForceSource
//
//  Created by 翁志方 on 16/3/17.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "ImageAnalysisViewController.h"

@interface ImageAnalysisViewController ()
{
    UIImageView *imageView;
    int curIndex;
    
    CGFloat posx;
    CGFloat posy;
}
@end

@implementation ImageAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    posx = 160;       // 133; 188
    posy = 339;         // 312 367
    UIView *anchor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    anchor.backgroundColor = [UIColor redColor];
    anchor.center = CGPointMake(posx, posy);
    [self.view addSubview:anchor];
    
    [self setImageIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImageIndex:(NSInteger)index
{
    NSString *name = [NSString stringWithFormat:@"_00%02d_图层 %d.jpg",39-curIndex, curIndex+1];
    imageView.image = [UIImage imageNamed:name];
}

- (IBAction)previous:(id)sender {
    
    if (curIndex>0) {
        --curIndex;
        [self setImageIndex:curIndex];
    }
}

- (IBAction)next:(id)sender {
    
    if (curIndex<36) {
        ++curIndex;
        [self setImageIndex:curIndex];
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint curPos = [touch locationInView:self.view];
    
    // 开始计算角度
    CGFloat x = curPos.x - posx;
    CGFloat y = posy - curPos.y;
    
    CGFloat angle = 0;
    if (x==0) {
        if (y>0) {
            angle = M_PI_2;
        }else{
            angle = M_PI_2 + M_PI;
        }
    }else{
        if (x>0) {
            angle = atan(y/x);
        }else{
            angle = atan(y/x)+M_PI;
        }
    }
    
    // 角坐标转换
    if (-M_PI_2 < angle && angle<=M_PI_2) {
        angle = -angle + M_PI_2;
    }else{
        angle = -angle + M_PI_2*5;
    }
    
    printf("当前页 %d :   %lf\n",curIndex,angle);
}




@end
