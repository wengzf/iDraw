//
//  RWHLoanSuccessViewController.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/11.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "RWHLoanSuccessViewController.h"

@interface RWHLoanSuccessViewController ()

@end

@implementation RWHLoanSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tittleImageView.layer.cornerRadius = self.tittleImageView.bounds.size.width/2;
    self.tittleImageView.layer.masksToBounds = YES;
    
    
}


- (IBAction)downloadBtnClked:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/ren-wo-hua-da-xue-sheng-dai/id1088737488?mt=8"];
    [[UIApplication sharedApplication] openURL:url];
}
@end
