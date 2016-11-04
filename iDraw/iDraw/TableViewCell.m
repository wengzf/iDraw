//
//  TableViewCell.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/4.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.label.preferredMaxLayoutWidth = ScreenWidth - 160;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
