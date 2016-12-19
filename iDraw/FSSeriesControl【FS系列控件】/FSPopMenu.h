//
//  FSPopMenu.h
//  SystemNavigation
//
//  Created by 翁志方 on 16/5/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPopMenu : UIView

- (instancetype)initWithImages:(NSArray *) images
                        titles:(NSArray *) titles
                         block:(void(^)(NSInteger index)) block;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
