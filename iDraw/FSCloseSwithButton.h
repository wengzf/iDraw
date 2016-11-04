//
//  FSCloseSwithButton.h
//  RRHua
//
//  Created by 翁志方 on 2016/11/3.
//  Copyright © 2016年 yangxiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSCloseSwithButton : UIButton

@property (nonatomic, copy) void(^closeBlock)();


@end
