//
//  FSWebImageCache.m
//  iDraw
//
//  Created by 方洁 on 2016/12/9.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSWebImageCache.h"
#import <CommonCrypto/CommonDigest.h>

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
        
        NSString *path = [self pathWithKey:key];
        
        NSLog(@"保存路径 %@",path);
        // 存储图片到硬盘中
        NSData *imageData = UIImagePNGRepresentation(img);
        BOOL flag= [imageData writeToFile:path atomically:YES];
        NSLog(@"%@",flag?@"保存成功":@"保存失败");
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
                // 把图片存储到内存中
                [self.cacheDic setObject:img forKey:key];
                
                // 如果内存超过一定限制的话，删除最早的图片
                
                
                return img;
            }
        }
    }
    return nil;
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

- (NSString *)pathWithKey:(NSString *)key
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    path = [path stringByAppendingPathComponent:@"CacheImages"];
    
    // 检查文件夹是否存在
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    NSString *fileName = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:fileName];
}


@end
