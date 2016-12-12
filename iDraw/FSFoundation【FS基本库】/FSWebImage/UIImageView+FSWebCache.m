//
//  UIImageView+FSWebCache.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "UIImageView+FSWebCache.h"

#import "FSWebImageManager.h"



@implementation UIImageView (FSWebCache)



- (void)fs_setImageURLStr:(NSString *)url placeHolderImage:(UIImage *)placeholder
{
    self.image = placeholder;
 
    [[FSWebImageManager sharedWebImageManager] loadImageWithURL:url completedBlock:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        self.image = image;
    }];
}

@end
