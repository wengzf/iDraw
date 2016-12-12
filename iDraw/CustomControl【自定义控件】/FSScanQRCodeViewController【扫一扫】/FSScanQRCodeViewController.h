//
//  FSScanQRCodeViewController.h
//  NewProject
//
//  Created by 翁志方 on 15/7/7.
//  Copyright (c) 2015年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSScanQRCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *captureView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *progressingLabel;


@end
