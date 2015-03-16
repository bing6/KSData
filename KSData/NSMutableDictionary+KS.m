//
//  NSMutableDictionary+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/11/27.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSMutableDictionary+KS.h"

@implementation NSMutableDictionary (KS)


- (void)add:(id)key objectValue:(id)obj
{
    if (obj) {
        [self setObject:obj forKey:key];
    } else {
        [self setObject:[NSNull null] forKey:key];
    }
}

- (void)add:(NSString *)key stringValue:(NSString *)val
{
    [self add:key objectValue:val];
}

- (void)add:(NSString *)key intValue:(NSInteger)val
{
    [self add:key objectValue:[NSNumber numberWithInteger:val]];
}

- (void)add:(NSString *)key doubleValue:(double)val
{
    [self add:key objectValue:[NSNumber numberWithDouble:val]];
}

- (void)add:(NSString *)key floatValue:(float)val
{
    [self add:key objectValue:[NSNumber numberWithFloat:val]];
}

@end
