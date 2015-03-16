//
//  NSDictionary+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/11/27.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSDictionary+KS.h"

@implementation NSDictionary (KS)

- (NSString *)getStringValue:(id)key
{
    if ([self objectForKey:key] == nil || [[self objectForKey:key] isEqual:[NSNull null]]) {
        return @"";
    }
    
    if ([[self objectForKey:key]respondsToSelector:@selector(stringValue)]) {
        return [[self objectForKey:key] stringValue];
    }
    
    return [self objectForKey:key];
}

- (NSInteger)getIntegerValue:(id)key
{
    if ([self objectForKey:key] == nil || [[self objectForKey:key] isEqual:[NSNull null]]) {
        return 0;
    }
    return [[self objectForKey:key] integerValue];
}

- (double)getDoubleValue:(id)key
{
    if ([self objectForKey:key] == nil || [[self objectForKey:key] isEqual:[NSNull null]]) {
        return 0;
    }
    return [[self objectForKey:key] doubleValue];
}

- (CGFloat)getFloatValue:(id)key
{
    if ([self objectForKey:key] == nil || [[self objectForKey:key] isEqual:[NSNull null]]) {
        return 0;
    }
    return [[self objectForKey:key] floatValue];
}


@end
