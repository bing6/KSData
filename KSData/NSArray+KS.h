//
//  NSArray+KS.h
//  KSToolkit
//
//  Created by bing.hao on 14/12/10.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KS)

/**
 * @brief 通过谓词表达式过滤结果,例：SELF.userID = 11
 */
- (NSArray *)findByPredicateExpression:(NSString *)exp;
/**
 * @brief 通过谓词表达式过滤结果,例：SELF.userID = %@
 */
- (NSArray *)findByPredicateExpression:(NSString *)exp args:(NSArray *)args;
/**
 * @brief 通过谓词表达式判断是否包含一个对象
 */
- (BOOL)existsByPredicateExpression:(NSString *)exp;
- (BOOL)existsByPredicateExpression:(NSString *)exp args:(NSArray *)args;
/**
 * @brief 通过谓词表达式获取一个对象
 */
- (id)singeByPredicateExpression:(NSString *)exp;
- (id)singeByPredicateExpression:(NSString *)exp args:(NSArray *)args;;

//+ (NSArray *)memberArrayWithNewData:(NSArray *)arr1
//                     newUniqueFiled:(NSString *)f1
//                        withOldData:(NSArray *)arr2
//                     oldUniqueFiled:(NSString *)f2;

@end
