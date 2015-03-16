//
//  NSDictionary+KS.h
//  KSToolkit
//
//  Created by bing.hao on 14/11/27.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSDictionary (KS)

/**
 * @brief 根据键获取一个字符串,如果不存在键活着为NSNull类型将返回一个空字符串
 */
- (NSString *)getStringValue:(id)key;
/**
 * @brief 根据键获取一个整型值,如果不存在或者为NSNull返回0
 */
- (NSInteger)getIntegerValue:(id)key;
/**
 * @brief 根据键获取一个Double值,如果不存在键或者为NSNull返回0
 */
- (double)getDoubleValue:(id)key;
/**
 * @brief 根据键获取一个Float值,如果不存在键或者为NSNull返回0
 */
- (CGFloat)getFloatValue:(id)key;


@end
