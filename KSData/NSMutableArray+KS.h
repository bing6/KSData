//
//  NSMutableArray+KS.h
//  KSToolkit
//
//  Created by bing.hao on 14/12/10.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (KS)

- (void)filterByPredicateExpression:(NSString *)exp;
- (void)filterByPredicateExpression:(NSString *)exp args:(NSArray *)args;

@end
