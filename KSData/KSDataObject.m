//
//  KSDataObject.m
//  KSToolkit
//
//  Created by bing.hao on 14/12/5.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "KSDataObject.h"
#import <objc/runtime.h>

@implementation KSDataObject

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        for (NSString * entry in dict.allKeys) {
            id val = [dict valueForKey:entry];
            [self setValue:val forKeyPath:entry];
        }
    }
    return self;
}

- (NSDictionary *)dictionaryValue
{
    //获得类属性的数量
    u_int count;
    objc_property_t *allProperties = class_copyPropertyList([self class], &count);

    NSMutableDictionary * tmp = [NSMutableDictionary new];
    
    for (int i = 0; i < count; i++) {
        
        //获取属性名与属性类型
        NSString * name = [NSString stringWithUTF8String:property_getName(allProperties[i])];
        
        id val = [self valueForKeyPath:name];
        
        if (val) {
            [tmp setObject:val forKey:name];
        } else {
            [tmp setObject:[NSNull null] forKey:name];
        }
    }
    
    return tmp;
}

//- (NSString *)description
//{
//    return [self dictionaryValue].description;
//}

- (NSString *)description
{
    u_int count;
    objc_property_t * allProperties = class_copyPropertyList([self class], &count);
    
//    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"'%@' = {\n", NSStringFromClass([self class])];
    NSMutableString * str = [[NSMutableString alloc] initWithString:@"{"];
    
    for (int i = 0; i < count; i++) {
        
        NSString * name = [NSString stringWithUTF8String:property_getName(allProperties[i])];
        
        id selfValue = [self valueForKeyPath:name];
        
        [str appendFormat:@"'%@' = '%@',", name, selfValue];
    }
    
    if ([str characterAtIndex:str.length - 1] == ',') {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    [str appendString:@"}"];
    
    free(allProperties);
    
    return str;
}

+ (id)objectWithName:(NSString *)className
{
    id obj = [NSClassFromString(className) new];
    if (![obj isKindOfClass:[self class]]) {
        obj = nil;
    }
    return obj;
}

@end
