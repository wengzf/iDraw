//
//  FSWebImageCache.m
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSWebImageCache.h"


@interface FSWebImageCache()
{
    
}
@property (nonatomic, strong) NSMutableDictionary *cacheDic;

@end


@implementation FSWebImageCache


+ (FSWebImageCache *)sharedWebImageCache
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (NSMutableDictionary *)cacheDic
{
    if (_cacheDic) {
        _cacheDic = [NSMutableDictionary dictionary];
    }
    return _cacheDic;
}

- (BOOL)storeImage:(UIImage *) img key:(NSString *)key
{
    @synchronized (self) {
        [self.cacheDic setObject:img forKey:key];
    }
    return YES;
    
}

- (UIImage *)loadImageFromKey:(NSString *)key
{
    // 先从内存中寻找
    UIImage *img = [_cacheDic objectForKey:key];
    if (img) {
        // 返回内存中图片
        return img;
    }else{
        // 检查硬盘中是否有图片
        NSString *path = [self pathWithKey:key];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL]) {
            UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
            if (img) {
                return img;
            }
        }
    }
    return nil;
}

- (NSString *)pathWithKey:(NSString *)key
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    path = [path stringByAppendingPathComponent:@"CacheImages"];
    return [path stringByAppendingPathComponent:key];
}


@end
