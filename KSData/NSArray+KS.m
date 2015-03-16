//
//  NSArray+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/12/10.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSArray+KS.h"

@implementation NSArray (KS)

- (NSArray *)findByPredicateExpression:(NSString *)exp
{
    NSPredicate * p = [NSPredicate predicateWithFormat:exp];
    
    return [self filteredArrayUsingPredicate:p];
}

- (NSArray *)findByPredicateExpression:(NSString *)exp args:(NSArray *)args
{
    NSPredicate * p = [NSPredicate predicateWithFormat:exp argumentArray:args];
    
    return [self filteredArrayUsingPredicate:p];
}

- (BOOL)existsByPredicateExpression:(NSString *)exp
{
    return [[self findByPredicateExpression:exp] count] > 0;
}

- (BOOL)existsByPredicateExpression:(NSString *)exp args:(NSArray *)args
{
    return [[self findByPredicateExpression:exp args:args] count] > 0;
}

- (id)singeByPredicateExpression:(NSString *)exp
{
    return [[self findByPredicateExpression:exp] firstObject];
}

- (id)singeByPredicateExpression:(NSString *)exp args:(NSArray *)args
{
    return [[self findByPredicateExpression:exp args:args] firstObject];
}

//+ (NSArray *)memberArrayWithNewData:(NSArray *)arr1
//                     newUniqueFiled:(NSString *)f1
//                        withOldData:(NSArray *)arr2
//                     oldUniqueFiled:(NSString *)f2
//{
//    NSMutableArray * newArr = [NSMutableArray new];
//    NSInteger i = 0;
//    
//    for (i = 0; i < [arr1 count]; i++) {
//        id tmp       = [NSMutableDictionary dictionaryWithCapacity:3];
//        id itemValue = (f1 == nil) ? [arr1 objectAtIndex:i] : [arr1 objectAtIndex:i][f1];
//        
//        [tmp setObject:itemValue forKey:@"UniqueItemValue"];
//        [tmp setObject:@"I" forKey:@"State"];
//        [tmp setObject:[arr1 objectAtIndex:i] forKey:@"Item"];
//        [newArr addObject:tmp];
//    }
//    
//    for (i = 0; i < [arr2 count]; i++) {
//        id itemValue = (f2 == nil) ? [arr2 objectAtIndex:i] : [arr2 objectAtIndex:i][f2];
//        BOOL find = NO;
//        for (int j = 0; j < arr1.count; j++) {
//            NSMutableDictionary * entry = [newArr objectAtIndex:j];
//            if ([[entry objectForKey:@"UniqueItemValue"] isEqual:itemValue]) {
//                find = YES;
//                [entry setObject:@"U" forKey:@"State"];
//                break;
//            }
//        }
//        if (find == NO) {
//            id tmp = [NSMutableDictionary dictionaryWithCapacity:3];
//            
//            [tmp setObject:itemValue forKey:@"UniqueItemValue"];
//            [tmp setObject:@"D" forKey:@"State"];
//            [tmp setObject:[arr2 objectAtIndex:i] forKey:@"Item"];
//            [newArr addObject:tmp];
//        }
//    }
//    
//    return newArr;
//}

@end
