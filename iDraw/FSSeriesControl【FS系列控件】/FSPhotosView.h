//
//  FSPhotosView.h
//  DEyes
//
//  Created by 翁志方 on 14-10-24.
//
//

#import <UIKit/UIKit.h>

@interface FSPhotosView : UIView<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    
    UIPageControl *pageControl;
    
    UIButton *chooseBtn;
    
    NSArray *imgArr;
    NSInteger curIdx;
    NSArray *frameArr;
    BOOL *chooseArr;

    UIView *bgView;
    
    NSMutableArray *contentImageViewArr;
    NSMutableArray *imageViewArr;
    
    BOOL isImage;
    
    void(^completionBlock)();
}

@property (nonatomic, strong) NSArray *imagesArr;       // 相册数组
@property (nonatomic, strong) UIImageView *tmpImgView;


- (void) configureWithImgArr:(NSArray *) aImageArr
                    curIndex:(NSInteger) acurindex
                    frameArr:(NSArray*) aframeArr
                   chooseArr:(BOOL *) aChooseArr
                  completion:(void(^)()) block;




// 点击戈迹上的某一图片，
// 首先在本视图同一个位置，展开图片到全屏


// 怎么解决图片的尺寸问题？？？
// 用全屏尺寸的进行自然显示，添加在一个窗口上进行裁剪

// 微信，scrollView 滑动时，会有一个小的黑色分隔区域，缩放
//


// 先用全屏的方式做
// 




@end

