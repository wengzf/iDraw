//
//  FSWebImageManager.m
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSWebImageManager.h"
#import "FSWebImageCache.h"


@interface FSWebImageManager()

@property (nonatomic, strong) NSOperationQueue *operationQueues;

@end

@implementation FSWebImageManager


+ (FSWebImageManager *)sharedWebImageManager
{
    static FSWebImageManager *webImageCache;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webImageCache = [[FSWebImageManager alloc] init];
        webImageCache.operationQueues = [[NSOperationQueue alloc] init];
    });
    return webImageCache;
}


- (void)loadImageWithURL:(NSString *)urlStr
          completedBlock:(FSWebImageDownloaderCompletedBlock)completionBlock
{
    // 从缓存中加载
    UIImage *img = [[FSWebImageCache sharedWebImageCache] loadImageFromKey:urlStr];
    if (img) {
        completionBlock(img, nil, nil, YES);
    }else{
        // 开始下载图片
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            NSURL *url = [NSURL URLWithString:urlStr];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionTask *sesstionTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                UIImage *img = [[UIImage alloc] initWithData:data];
                completionBlock(img, nil, nil, YES);
                
                // 保存图片
                [[FSWebImageCache sharedWebImageCache] storeImage:img key:urlStr];
            }];
            
            [sesstionTask resume];
            
        }];
        [self.operationQueues addOperation:operation];
    }
    
}



@end
