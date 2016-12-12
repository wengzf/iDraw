//
//  LMSTaskpoolTableViewCell.h
//  LetMeSpend
//
//  Created by 翁志方 on 2016/12/12.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMSTaskpoolTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UIView *contrainView;

@property (nonatomic, weak) IBOutlet UIImageView *bgImgView;

@property (nonatomic, weak) IBOutlet UIImageView *maskImgView;

@property (nonatomic, weak) IBOutlet UIImageView *headImgView;

@property (nonatomic, weak) IBOutlet UIImageView *sexImgView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *classLabel;

@property (nonatomic, weak) IBOutlet UILabel *schoolLabel;

@property (nonatomic, weak) IBOutlet UILabel *takeFeeLabel;


@property (nonatomic, weak) IBOutlet UIImageView *finishImageView;

@property (nonatomic, weak) IBOutlet UIButton *taskBtn;


@property (nonatomic, weak) IBOutlet UIView *blackView;

@property (nonatomic, weak) IBOutlet UIView *lastView;

@property (nonatomic, weak) IBOutlet UIView *rightView;

@property (nonatomic, weak) IBOutlet UIView *strokeView;


//  takeFeeTopContraint: NSLayoutConstraint!



@end
