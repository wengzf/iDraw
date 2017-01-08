//
//  FSPopMenu.m
//  SystemNavigation
//
//  Created by 翁志方 on 16/5/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSPopMenu.h"

const CGFloat capHeight = 7;
const CGFloat contentWidth = 108;
CGFloat contentHeight;
const CGFloat cellHeight = 44;

@interface FSPopMenu()
{
    UIView *contentView;
    UIView *containerView;
    void(^operationBlock)();
    
    UITapGestureRecognizer *tap;
}

@end

@implementation FSPopMenu

- (instancetype)initWithImages:(NSArray *) images
                        titles:(NSArray *) titles
                         block:(void(^)(NSInteger index)) block
{
    self = [super init];
 
    if (self) {
        operationBlock = block;
        
        // 背景气泡绘制
        contentHeight = cellHeight*[titles count]+capHeight;
        
        CGFloat proportion = (contentWidth-16-6)/contentWidth;
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth-contentWidth-18)+contentWidth*(proportion-0.5), -20, contentWidth, contentHeight)];
        
        contentView.backgroundColor = [UIColor blackColor];
        
        contentView.layer.anchorPoint = CGPointMake(proportion, 0);
        contentView.layer.shadowRadius = 5;
        
        // 绘制气泡
        CAShapeLayer *layer = [CAShapeLayer layer];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, 4, capHeight);
        CGPathAddLineToPoint(path, nil, contentWidth-12-16, capHeight);
        CGPathAddLineToPoint(path, nil, contentWidth-6-16, 0);
        CGPathAddLineToPoint(path, nil, contentWidth-16, capHeight);
        
        CGPathAddArcToPoint(path, nil, contentWidth, capHeight, contentWidth, contentHeight, 4);
        CGPathAddArcToPoint(path, nil, contentWidth, contentHeight, 0, contentHeight, 4);
        CGPathAddArcToPoint(path, nil, 0, contentHeight, 0, capHeight, 4);
        CGPathAddArcToPoint(path, nil, 0, capHeight, 4, capHeight, 4);
        
        CGPathCloseSubpath(path);
        
//        CGPathAddLineToPoint(path, nil, capHeight-4, capHeight);
        
        layer.path = path;
        contentView.layer.mask = layer;
        
        // cells
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, capHeight, contentWidth, cellHeight*[titles count])];
        [contentView addSubview:containerView];
        
        CGFloat posy;
        for (int i=0; i<[titles count]; ++i) {
//            // 图片
//            UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(18, posy+12, 20, 20)];
//            NSObject *obj = images[i];
//            if ([obj isKindOfClass:[NSString class]]) {
//                [imgview sd_setImageWithURL:[NSURL URLWithString:(NSString *)obj] placeholderImage:nil];
//            }else{
//                imgview.image = (UIImage *)obj;
//            }
//            [containerView addSubview:imgview];
            
            // 标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, posy+12, 80, 20)];
            titleLabel.text = titles[i];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:16];
            [containerView addSubview:titleLabel];
            
            // 按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, posy, contentWidth, cellHeight)];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClked:) forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:btn];
            
            // 分割线
            if (i!=0) {
                UIView *devider = [[UIView alloc]initWithFrame:CGRectMake(14, posy, contentWidth-28, 1)];
                devider.backgroundColor = [UIColor lightGrayColor];
                [containerView addSubview:devider];
            }
            
            posy += cellHeight;
        }
        
        [self addSubview:contentView];
    }
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;
    return self;
}

- (void)btnClked:(UIButton *)btn
{
    [self dismiss];
    
    operationBlock(btn.tag);
    
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [view addGestureRecognizer:tap];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        contentView.transform = CGAffineTransformMakeScale(0.65, 0.65);
        contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.superview removeGestureRecognizer:tap];
        
        [self removeFromSuperview];
    }];
}


@end
