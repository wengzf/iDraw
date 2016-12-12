//
//  FSWebImageCache.h
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FSWebImageCache : NSObject

+ (FSWebImageCache *)sharedWebImageCache;

- (UIImage *)loadImageFromKey:(NSString *)key;

- (BOOL)storeImage:(UIImage *) img key:(NSString *)key;



@end
