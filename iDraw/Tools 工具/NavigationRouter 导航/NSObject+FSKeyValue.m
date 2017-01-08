//
//  NSObject+FSKeyValue.m
//  SystemNavigation
//
//  Created by 翁志方 on 16/8/25.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "NSObject+FSKeyValue.h"
#import <objc/runtime.h>

@implementation NSObject (FSKeyValue)

+ (instancetype)fs_objectWithDic:(NSDictionary *)dic
{
    return [[[self alloc] init] fs_setKeyValues:dic];
}

+ (NSArray *)fs_ArrayWithDicArr:(NSArray *)arr
{
    NSMutableArray *contentArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        id obj = [[self alloc] init];
        [obj fs_setKeyValues:dic];
        [contentArr addObject:obj];
    }
    
    return contentArr;
}

- (instancetype)fs_setKeyValues:(NSDictionary *)keyValues
{
    NSMutableArray *propertyArr = [NSMutableArray array];
    
    // 枚举所有父类下所有属性
    Class classz = [self class];
    do{
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(classz, &outCount);
        
        for (int i=0; i<outCount; ++i) {
            objc_property_t property = properties[i];
            
            const char *name = property_getName(property);
            const char *attribute = property_getAttributes(property);
            
            [propertyArr addObject:@{@"name":@(name),
                                     @"type":@(attribute)}];
        }
        
        classz = class_getSuperclass(classz);
        
    }while (![self isFromFoundation:classz]);
    
    for (NSDictionary *dic in propertyArr){
        NSString *name = dic[@"name"];
        NSString *type = dic[@"type"];
        
        // 检查对象是否出现设置的keyvalues里面
        if (keyValues[name] == nil){
            continue;
        }
        
        // 检查类型是否正确
        NSRange range = [type rangeOfString:@","];
        if (range.location != NSNotFound) {
            NSRange ran;
            ran.location = 1;
            ran.length = range.location - 1;
            NSString *dtype = [type substringWithRange:ran];
            
            if ((dtype.length > 3) ) {   // 是oc对象类型
                // 判断是否是基本类型，直接赋值
                ran.location = 2;
                ran.length -= 3;
                NSString *typeStr = [dtype substringWithRange:ran];
                Class typeCls = NSClassFromString(typeStr);
                if (![self isFoundationClass:typeCls]) {
                    // 递归调用
                    [self setValue:[[typeCls new] fs_setKeyValues:keyValues[name]]
                            forKey:name];
                    
                }else if (typeCls == [NSArray class] || typeCls == [NSMutableArray class]){
                    // 是否是自定义model的数组
                    if ([self respondsToSelector:@selector(objectClassInArray)]) {
                        SEL sel = NSSelectorFromString(@"objectClassInArray");
                        NSDictionary *dicArrType = [self performSelector:sel withObject:nil];
                        if (dicArrType[name]) {
                            NSArray *arr = [NSClassFromString(dicArrType[name]) fs_ArrayWithDicArr:keyValues[name]] ;
                        
                            [self setValue:arr forKey:name];
                        }else{
                            
                            [self setValue:keyValues[name] forKey:name];
                        }
                    }
                }else{
                    
                    [self setValue:keyValues[name] forKey:name];
                }
            }else{
                // 基本类型
                [self setValue:keyValues[name] forKey:name];
            }
        }
    }
    
    return self;
}

- (BOOL)isFromFoundation:(Class) cls
{
    if (cls == [NSObject class]) {
        return YES;
    }
    NSArray *arr = @[[NSURL class],
                     [NSDate class],
                     [NSValue class],
                     [NSData class],
                     [NSError class],
                     [NSArray class],
                     [NSDictionary class],
                     [NSString class],
                     [NSAttributedString class]];
    
    for (Class cl in arr){
        if (cls == cl || [cls isSubclassOfClass:cl]) {
            return YES;
        }
    }
    
    return NO;
}


- (BOOL)isFoundationClass:(Class) cls
{
    NSArray *arr = @[[NSObject class],
                     [NSURL class],
                     [NSDate class],
                     [NSValue class],
                     [NSData class],
                     [NSError class],
                     [NSArray class],
                     [NSDictionary class],
                     [NSString class],
                     [NSAttributedString class]];
    
    for (Class cl in arr){
        if (cls == cl) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isBaseType:(NSString *)typeCode
{

    return YES;
}


@end
