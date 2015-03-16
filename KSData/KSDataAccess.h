//
//  KSDbAccess.h
//  KSToolkit
//
//  Created by bing.hao on 15/2/5.
//  Copyright (c) 2015年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSDataConfiguration.h"
#import "KSDataObject.h"

#define KS_DB_CONN_RELEASE(DAO) [DAO closeConnection]

#define KS_DB_QUERY_LIST_1(DAO, S, P)         [DAO queryForList:S     parameter:P]
#define KS_DB_QUERY_LIST_2(DAO, S, ...)       [DAO queryForList:S     parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_INTERER_1(DAO, S, P)      [DAO queryForInteger:S  parameter:P]
#define KS_DB_QUERY_INTERER_2(DAO, S, ...)    [DAO queryForInteger:S  parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_MAP_1(DAO,S,P)            [DAO queryForMap:S      parameter:P]
#define KS_DB_QUERY_MAP_2(DAO,S,...)          [DAO queryForMap:S      parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_DOUBLE_1(DAO,S,P)         [DAO queryForDouble:S   parameter:P]
#define KS_DB_QUERY_DOUBLE_2(DAO,S,...)       [DAO queryForDouble:S   parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_FLOAT_1(DAO,S,P)          [DAO queryForFloat:S    parameter:P]
#define KS_DB_QUERY_FLOAT_2(DAO,S,...)        [DAO queryForFloat:S    parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_DATE_1(DAO,S,P)           [DAO queryForDate:S     parameter:P]
#define KS_DB_QUERY_DATE_2(DAO,S,...)         [DAO queryForDate:S     parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_STRING_1(DAO,S,P)         [DAO queryForString:S   parameter:P]
#define KS_DB_QUERY_STRING_2(DAO,S,...)       [DAO queryForString:S   parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_QUERY_OBJECT_1(DAO,S,P)         [DAO queryForObject:S   parameter:P]
#define KS_DB_QUERY_OBJECT_2(DAO,S,...)       [DAO queryForObject:S   parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_DELETE_1(DAO, S, P)             [DAO remove:S           parameter:P]
#define KS_DB_DELETE_2(DAO, S, ...)           [DAO remove:S           parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_INSERT_1(DAO, S, P)             [DAO insert:S           parameter:P]
#define KS_DB_INSERT_2(DAO, S, ...)           [DAO insert:S           parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_UPDATE_1(DAO, S, P)             [DAO update:S           parameter:P]
#define KS_DB_UPDATE_2(DAO, S, ...)           [DAO update:S           parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]
#define KS_DB_REPLACE_1(DAO, S, P)            [DAO replace:S          parameter:P]
#define KS_DB_REPLACE_2(DAO, S, ...)          [DAO replace:S          parameter:[NSArray arrayWithObjects:__VA_ARGS__, nil]]

@interface KSDataAccess : NSObject

@property (nonatomic, weak            ) KSDataConfiguration * config;
@property (nonatomic, strong, readonly) FMDatabase          * fmdb;


- (id)initWithDataConfig:(KSDataConfiguration *)config;

/**
 * @brief 打开连接
 */
- (BOOL)openConnection;
/**
 * @brief 关闭连接
 */
- (BOOL)closeConnection;

/**
 * @brief 获取一个查询列表
 * @param statement 映射ID例:user.find_all_list
 * @param parameter 查询参数，可以是NSNumber,NSString,NSDictionary,NSArray,自定义类对象(类对象会根据属性值去匹配,必须继承NSDataObject)
 * @return 返回一个结果集,具体类型根据映射配置文件对应
 */
- (NSArray *)queryForList:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个对象
 */
- (id)queryForObject:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个字典
 */
- (NSDictionary *)queryForMap:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个int值
 */
- (NSInteger)queryForInteger:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个double值
 */
- (double)queryForDouble:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个float值
 */
- (float)queryForFloat:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个date值
 */
- (NSDate *)queryForDate:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 获取一个string值
 */
- (NSString *)queryForString:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 添加一条记录
 */
- (BOOL)insert:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 删除一条记录
 */
- (BOOL)remove:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 更新一条记录
 */
- (BOOL)update:(NSString *)statement parameter:(id)parameter;
/**
 * @brief 复盖一条记录
 */
- (BOOL)replace:(NSString *)statement parameter:(id)parameter;

@end
