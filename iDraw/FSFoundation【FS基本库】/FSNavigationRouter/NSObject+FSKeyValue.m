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

+ (NSArray *)fs_arrayWithDicArr:(NSArray *)arr
{
    NSMutableArray *contentArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        
        id obj = [[self alloc] init];
        
        
        if ([dic isKindOfClass:[NSArray class]]) {
            [[obj class] fs_arrayWithDicArr:(NSArray *)dic];
        }else{
            [obj fs_setKeyValues:dic];
        }
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
    
    NSDictionary *replaceKeyDic = nil;
    if ([[self class] respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        
        replaceKeyDic = [[self class] performSelector:@selector(replacedKeyFromPropertyName)
                                           withObject:nil];
        
    }
    
    for (NSDictionary *dic in propertyArr){
        NSString *name = dic[@"name"];
        NSString *type = dic[@"type"];
        
        NSString *keyName = name;
        if (replaceKeyDic[name]) {
            keyName = replaceKeyDic[name];
        }
        // 检查对象是否出现设置的keyvalues里面
        id keyObj = keyValues[keyName];
        
        if (keyObj == nil){
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
                
                ran.location = 2;
                ran.length -= 3;
                NSString *typeStr = [dtype substringWithRange:ran];
                Class typeCls = NSClassFromString(typeStr);
                
                if ([self isFoundationClass:typeCls]) {
                    
                    if (typeCls == [NSArray class] || typeCls == [NSMutableArray class]){
                        // 数组类型
                        NSArray *arr = [self arrayWithName:name keyValues:keyObj];
                        if (typeCls == [NSMutableArray class]) {
                            NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
                            [self setValue:mArr forKey:name];
                        }else{
                            [self setValue:arr forKey:name];
                        }
                        
                    }else{
                        // Foundation 类型
                        [self setValue:keyObj forKey:name withType:typeCls];
                    }
                }else {
                    // 自定义类型，递归遍历
                    [self setValue:[[typeCls new] fs_setKeyValues:keyObj]
                            forKey:name];
                }
            }else{
                // 基本类型 char int floag 等
                [self setValue:keyObj forKey:name];
            }
        }
    }
    
    return self;
}
- (NSArray *)arrayWithName:(NSString *)name keyValues:(id)keyValues
{
    // 是否是自定义model的数组
    if ([[self class] respondsToSelector:@selector(objectClassInArray)]) {
        
        NSDictionary *dicArrType = [[self class] performSelector:@selector(objectClassInArray)
                                                      withObject:nil];
        if (dicArrType[name]) {
            NSArray *arr = [NSClassFromString(dicArrType[name]) fs_arrayWithDicArr:keyValues] ;
            return arr;
        }else{
            return keyValues;
        }
        
    }else{
        
        return keyValues[name];
    }
}
- (void)setValue:(id)value forKey:(NSString *)key withType:(Class) cls;
{
    if ([cls isSubclassOfClass:[NSString class]]){
        
        id obj = value;
        if ([value isKindOfClass:[NSNumber class]]) {
            obj = [value stringValue];
        }
        if ([cls isSubclassOfClass:[NSMutableString class]]) {
            obj = [NSMutableString stringWithString:obj];
        }
        [self setValue:obj forKey:key];
    }else if ([cls isSubclassOfClass:[NSNumber class]]){
        
        id obj = value;
        if ([value isKindOfClass:[NSString class]]) {
            NSNumberFormatter *fomatter = [[NSNumberFormatter alloc] init];
            obj = [fomatter numberFromString:value];
        }
        [self setValue:obj forKey:key];
    }
}

- (BOOL)isFromFoundation:(Class) cls
{
    if (cls == [NSObject class]) {
        return YES;
    }
    
    NSArray *arr = [self foundationArray];
    
    for (Class cl in arr){
        if (cls == cl || [cls isSubclassOfClass:cl]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isFoundationClass:(Class) cls
{
    NSArray *arr = [self foundationArray];
    
    for (Class cl in arr){
        if (cls == cl) {
            return YES;
        }
    }
    return NO;
}
- (NSArray *)foundationArray
{
    return @[[NSObject class],
             [NSURL class],
             [NSDate class],
             [NSValue class],
             [NSData class],
             [NSError class],
             [NSArray class],
             [NSMutableArray class],
             [NSDictionary class],
             [NSMutableDictionary class],
             [NSString class],
             [NSNumber class],
             [NSAttributedString class]];
}

- (BOOL)isBaseType:(NSString *)typeCode
{
    return YES;
}


@end
