//
//  RWHLoanSuccessViewController.h
//  iDraw
//
//  Created by 翁志方 on 2017/1/11.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWHLoanSuccessViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *tittleImageView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

- (IBAction)downloadBtnClked:(id)sender;





@end
