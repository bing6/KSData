//
//  KSDbAccess.m
//  KSToolkit
//
//  Created by bing.hao on 15/2/5.
//  Copyright (c) 2015年 bing.hao. All rights reserved.
//

#import "KSDataAccess.h"
#import "NSArray+KS.h"
#import "NSMutableArray+KS.h"
#import "NSDictionary+KS.h"
#import "NSMutableDictionary+KS.h"

@implementation KSDataAccess

- (id)initWithDataConfig:(KSDataConfiguration *)config
{
    self = [super init];
    if (self) {
        _config = config;
    }
    return self;
}

- (void)dealloc
{
    if (_fmdb) {
        [self closeConnection];
    }
    
    _fmdb   = nil;
    _config = nil;
}

- (BOOL)openConnection
{
    if (_fmdb == nil) {
        _fmdb = [FMDatabase databaseWithPath:_config.dbPath];
    }
    if ([self.fmdb goodConnection] == NO) {
        [self.fmdb open];
        return YES;
    }
    return NO;
}

- (BOOL)closeConnection
{
    if ([self.fmdb goodConnection]) {
        [self.fmdb close];
        return YES;
    }
    return NO;
}

- (NSArray *)queryForList:(NSString *)statement parameter:(id)parameter
{
    NSDictionary   * sobj   = [self.config statementBySelectWithId:statement];
    NSMutableArray * result = [NSMutableArray new];
    FMResultSet    * set    = nil;
    
    //打开数据库连接
    [self openConnection];
    //判断查询参数数据类型
    if (parameter == nil) {
        set = [self.fmdb executeQuery:[sobj getStringValue:KS_STATEMENT_SQL]];
    } else if ([parameter isKindOfClass:[NSNumber class]] || [parameter isKindOfClass:[NSString class]]) {
        set = [self.fmdb executeQuery:[sobj getStringValue:KS_STATEMENT_SQL] withArgumentsInArray:@[ parameter ]];
    } else if ([parameter isKindOfClass:[NSArray class]]) {
        set = [self.fmdb executeQuery:[sobj getStringValue:KS_STATEMENT_SQL] withArgumentsInArray:parameter];
    } else if ([parameter isKindOfClass:[NSDictionary class]]) {
        set = [self.fmdb executeQuery:[sobj getStringValue:KS_STATEMENT_SQL] withParameterDictionary:parameter];
    } else {
        set = [self.fmdb executeQuery:[sobj getStringValue:KS_STATEMENT_SQL] withParameterDictionary:[parameter dictionaryValue]];
    }
    NSString * resultType = [sobj valueForKeyPath:@"result_map.class"];
    NSArray  * resultItem = [sobj valueForKeyPath:@"result_map.item"];
    
    //获取返回值
    while ([set next]) {
        if ([resultType isEqualToString:@"NSString"]) {
            [result addObject:[set stringForColumnIndex:0]];
        } else if ([resultType isEqualToString:@"NSNumber"]) {
            [result addObject:[set objectForColumnIndex:0]];
        } else if ([resultType isEqualToString:@"NSDate"]) {
            [result addObject:[set dateForColumnIndex:0]];
        } else if ([resultType isEqualToString:@"NSDictionary"]) {
            [result addObject:[set resultDictionary]];
        }  else {
            id obj = [KSDataObject objectWithName:resultType];
            for (NSDictionary * entry in resultItem) {
                NSString * pname = [entry getStringValue:KS_RESULT_MAP_ITEM_PROPERTY];
                NSString * dname = [entry getStringValue:KS_RESULT_MAP_ITEM_COLUMN];
                id val = [set objectForColumnName:dname];
                if ([val isEqual:[NSNull null]]) {
                    id def = [entry valueForKey:KS_RESULT_MAP_ITEM_NULL_VALUE];
                    if (def) {
                        [obj setValue:def forKeyPath:pname];
                    }
                } else {
                    [obj setValue:val forKeyPath:pname];
                }
            }
            [result addObject:obj];
        }
    }
    
    return result;
}


- (id)queryForObject:(NSString *)statement parameter:(id)parameter
{
    return [[self queryForList:statement parameter:parameter] firstObject];
}

- (NSDictionary *)queryForMap:(NSString *)statement parameter:(id)parameter
{
    return [[self queryForList:statement parameter:parameter] firstObject];
}

- (NSInteger)queryForInteger:(NSString *)statement parameter:(id)parameter
{
    return [[[self queryForList:statement parameter:parameter] firstObject] integerValue];
}

- (double)queryForDouble:(NSString *)statement parameter:(id)parameter
{
    return [[[self queryForList:statement parameter:parameter] firstObject] doubleValue];
}

- (float)queryForFloat:(NSString *)statement parameter:(id)parameter
{
    return [[[self queryForList:statement parameter:parameter] firstObject] floatValue];
}

- (NSDate *)queryForDate:(NSString *)statement parameter:(id)parameter
{
    return [[self queryForList:statement parameter:parameter] firstObject];
}

- (NSString *)queryForString:(NSString *)statement parameter:(id)parameter
{
    return [[self queryForList:statement parameter:parameter] firstObject];
}

- (BOOL)executeUpdate:(NSDictionary *)sobj paramenter:(id)parameter
{
    BOOL result = NO;
    
    [self openConnection];
    if (parameter == nil) {
        result = [self.fmdb executeUpdate:[sobj getStringValue:KS_STATEMENT_SQL]];
    } else if ([parameter isKindOfClass:[NSNumber class]] || [parameter isMemberOfClass:[NSString class]]) {
        result = [self.fmdb executeUpdate:[sobj getStringValue:KS_STATEMENT_SQL] withArgumentsInArray:@[ parameter ]];
    } else if ([parameter isKindOfClass:[NSArray class]]) {
        result = [self.fmdb executeUpdate:[sobj getStringValue:KS_STATEMENT_SQL] withArgumentsInArray:parameter];
    } else if ([parameter isKindOfClass:[NSDictionary class]]) {
        result = [self.fmdb executeUpdate:[sobj getStringValue:KS_STATEMENT_SQL] withParameterDictionary:parameter];
    } else {
        result = [self.fmdb executeUpdate:[sobj getStringValue:KS_STATEMENT_SQL] withParameterDictionary:[parameter dictionaryValue]];
    }
    return result;
}

- (BOOL)insert:(NSString *)statement parameter:(id)parameter
{
    return [self executeUpdate:[self.config statementByInsertWithId:statement] paramenter:parameter];
}

- (BOOL)update:(NSString *)statement parameter:(id)parameter
{
    return [self executeUpdate:[self.config statementByUpdateWithId:statement] paramenter:parameter];
}

- (BOOL)remove:(NSString *)statement parameter:(id)parameter
{
    return [self executeUpdate:[self.config statementByDeleteWithId:statement] paramenter:parameter];
}

- (BOOL)replace:(NSString *)statement parameter:(id)parameter
{
    return [self executeUpdate:[self.config statementByReplaceWithId:statement] paramenter:parameter];
}


@end
