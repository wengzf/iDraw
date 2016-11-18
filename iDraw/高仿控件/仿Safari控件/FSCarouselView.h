//
//  FSCarouselView.h
//  iDraw
//
//  Created by 翁志方 on 2016/11/16.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSCarouselView;


@protocol  FSCarouselViewDatasource<NSObject>

// item数量
- (NSInteger)numberOfItemsInCarouselView:(FSCarouselView *)carouselView;

// item视图
- (UIView *)carouselView:(FSCarouselView *)carouselView itemAtIndex:(NSInteger) index;

@optional

- (void)carouselView:(FSCarouselView *)carouselView didSelectedAtIndex:(NSInteger) index;

@end

@protocol  FSCarouselViewDelegate<NSObject>

@optional
- (void)carouselView:(FSCarouselView *)carouselView didSelectedAtIndex:(NSInteger) index;

@end



@interface FSCarouselView : UIView


@property (nonatomic, weak) IBOutlet id<FSCarouselViewDatasource> dataSource;
@property (nonatomic, weak) IBOutlet id<FSCarouselViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentItemIndex;

@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL bounces;

@property (nonatomic, readonly, getter=isDragging) BOOL dragging;
@property (nonatomic, readonly) BOOL didDrag;
@property (nonatomic, readonly, getter=isScrolling) BOOL scrolling;
@property (nonatomic, readonly, getter=isDecelerating) BOOL decelerating;


@property (nonatomic, assign) CGFloat scrollOffset;




- (void)reloadData;



@end

