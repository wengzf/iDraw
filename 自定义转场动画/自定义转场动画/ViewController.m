//
//  ViewController.m
//  自定义转场动画
//
//  Created by 翁志方 on 16/3/22.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CustomPushAnimation.h"
#import "CustomPopAnimation.h"

@interface ViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
{
    SecondViewController *secondVC;
    
    CustomPushAnimation *cusPushAnimation;
    CustomPopAnimation *cusPopAnimation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    secondVC = [SecondViewController new];
    
    cusPushAnimation = [[CustomPushAnimation alloc] init];
    cusPopAnimation = [[CustomPopAnimation alloc] init];
    self.navigationController.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)push:(id)sender {
    
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return cusPushAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        return cusPopAnimation;
    }
    
    return nil;
}
@end
