//
//  NSMutableDictionary+KS.h
//  KSToolkit
//
//  Created by bing.hao on 14/11/27.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSMutableDictionary (KS)

/**
 * @brief 添加一个任意类型值到字典中
 */
- (void)add:(id)key objectValue:(id)obj;
/**
 * @brief 添加一个String值到字典中
 */
- (void)add:(NSString *)key stringValue:(NSString *)val;
/**
 * @brief 添加一个Int值到字典中
 */
- (void)add:(NSString *)key intValue:(NSInteger)val;
/**
 * @brief 添加一个Double值到字典中
 */
- (void)add:(NSString *)key doubleValue:(double)val;
/**
 * @brief 添加一个Float值到字典中
 */
- (void)add:(NSString *)key floatValue:(float)val;

@end
