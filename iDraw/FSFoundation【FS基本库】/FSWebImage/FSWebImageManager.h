//
//  FSWebImageManager.h
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^FSWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void(^FSWebImageDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);




@interface FSWebImageManager : NSObject
{
    NSMutableArray *operationQueues;
}

+ (FSWebImageManager *)sharedWebImageManager;

- (void)loadImageWithURL:(NSString *)urlStr
          completedBlock:(FSWebImageDownloaderCompletedBlock)completionBlock;


@end
