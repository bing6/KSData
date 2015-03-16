//
//  NSMutableArray+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/12/10.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSMutableArray+KS.h"

@implementation NSMutableArray (KS)

- (void)filterByPredicateExpression:(NSString *)exp
{
    [self filterUsingPredicate:[NSPredicate predicateWithFormat:exp]];
}

- (void)filterByPredicateExpression:(NSString *)exp args:(NSArray *)args
{
    [self filterUsingPredicate:[NSPredicate predicateWithFormat:exp argumentArray:args]];
}

@end
