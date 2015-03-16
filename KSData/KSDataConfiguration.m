//
//  KSDbConfiguration.m
//  KSToolkit
//
//  Created by bing.hao on 15/2/5.
//  Copyright (c) 2015年 bing.hao. All rights reserved.
//

#import "KSDataConfiguration.h"
#import "NSString+KS.h"
#import "NSDictionary+KS.h"
#import "NSMutableDictionary+KS.h"
#import "NSArray+KS.h"
#import "KSMacros.h"
#import "KSStopwatch.h"

#define KS_STATEMENT_EXP(t,s) [NSString stringWithFormat:@"/datasource/data_mapper/statement/%@[@id='%@']", t, s]
#define KS_RESULT_MAP_EXP(r)  [NSString stringWithFormat:@"/datasource/data_mapper/result_map/item[@id='%@']", r]

@implementation KSDataConfiguration

@synthesize document  = _document;
@synthesize dbPath    = _dbPath;
@synthesize dbVersion = _dbVersion;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _statementCache = [NSMutableDictionary new];
    }
    return self;
}

+ (id)newInstance:(NSString *)path dec:(NSString *)key
{
    return [[self alloc] initWithConfigurationPath:path decryptionKey:key];
}

- (id)initWithConfigurationPath:(NSString *)path decryptionKey:(NSString *)key
{
    return [self initWithConfigurationPath:path decryptionKey:key customPath:nil];
}

- (id)initWithConfigurationPath:(NSString *)path decryptionKey:(NSString *)key customPath:(NSString *)customPath
{
    self = [self init];
    if (self) {
        NSString * str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
//        if ([NSString isNullOrEmpty:key] == NO) {
//            if ([NSString isNullOrEmpty:key] == NO) {
//                str = [str toAESDecryptionWithKey:key];
//            }
//        }
        
        NSError * error = nil;
        NSData  * data  = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        _document = [[GDataXMLDocument alloc] initWithData:data error:&error];
        
        if (error) DLog(@"%@", error);
        
        _dbVersion = [[[[_document rootElement] attributeForName:@"version"] stringValue] integerValue];
        _dbPath    = [[[_document rootElement] attributeForName:@"connection"] stringValue];
        
        if (customPath) {
            _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_CUSTOM}" withString:customPath];
        } else {
            _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_CACHE}" withString:KS_PATH_CACHE];
            _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_TEMP}" withString:KS_PATH_TEMP];
            _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_DOCUMENT}" withString:KS_PATH_DOCUMENT];
        }
    }
    return self;
}

//- (NSString *)dbPath
//{
//    if (_dbPath == nil) {
//        _dbPath = [[[_document rootElement] attributeForName:@"connection"] stringValue];
//        _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_CACHE}" withString:KS_PATH_CACHE];
//        _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_TEMP}" withString:KS_PATH_TEMP];
//        _dbPath = [_dbPath stringByReplacingOccurrencesOfString:@"${APP_DOCUMENT}" withString:KS_PATH_DOCUMENT];
//    }
//    return _dbPath;
//}
//
//- (NSInteger)dbVersion
//{
//    if (_dbVersion == 0) {
//        _dbVersion = [[[[_document rootElement] attributeForName:@"version"] stringValue] integerValue];
//    }
//    return _dbVersion;
//}

#pragma --mark
#pragma --mark initializeDatabase

- (void)initializeDatabase
{
    [self createDatabaseDirectory];
    
    KSStopwatch * ti   = [KSStopwatch stopwatchAndStartTime];
    FMDatabase  * fmdb = [[FMDatabase alloc] initWithPath:_dbPath];
    
    [fmdb open];
    [self defdb:fmdb];
    //判断本地数据库是否为最新版本
    if ([self checkVersion:fmdb] >= _dbVersion) {
        [fmdb close];
    } else {
        NSArray * localDbSchema = [self localDatabaseTableScheam:fmdb];
        NSArray * dml           = nil;
        NSArray * ddl           = nil;
        
        [self runSqlScript:localDbSchema dmlScript:&dml ddlScript:&ddl];

//        DLog(@"DML:%@", dml);
//        DLog(@"DDL:%@", ddl);
    
        [fmdb executeStatements:[ddl componentsJoinedByString:@";"]];
        [fmdb executeStatements:[dml componentsJoinedByString:@";"]];
        [fmdb executeUpdate:@"insert into db_vers values (?)", @(_dbVersion)];
        [fmdb close];
    }

    [ti stop];
    
//    DLog(@"Database update end.");
//    DLog(@"Database current version is %@.Execution time is %f seconds.", @(_dbVersion), ti.duration);
}

//创建一个数据库路径
- (void)createDatabaseDirectory
{
    NSString * dir = [NSString pathWithFileName:_dbPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//初始化数据库
- (void)defdb:(FMDatabase *)fmdb
{
    [fmdb executeUpdate:@"create table if not exists db_vers (v integer)"];
    [fmdb executeUpdate:@"create table if not exists db_objs (obj_id text,obj_name text unique,obj_type text,db_type text, db_unique integer,obj_parent text)"];
    
}

//检测数据库版本
- (NSInteger)checkVersion:(FMDatabase *)fmdb
{
    NSInteger dbv = [fmdb intForQuery:@"select ifnull(v,0) from db_vers order by rowid desc limit 1"];
    return dbv;
}

//获取本地数据库表结构
- (NSArray *)localDatabaseTableScheam:(FMDatabase *)fmdb
{
    NSMutableArray * objs = [NSMutableArray new];
    
    FMResultSet * set = [fmdb executeQuery:@"select * from db_objs"];
    
    while ([set next]) {
        [objs addObject:[set resultDictionary]];
    }
    
    return objs;
}
//获取要执行的SQL语句
- (void)runSqlScript:(NSArray *)lds dmlScript:(NSArray **)dmls ddlScript:(NSArray **)ddls
{
    NSMutableArray * dml = [NSMutableArray new];
    NSMutableArray * ddl = [NSMutableArray new];

    GDataXMLNode * tableNodes = [_document firstNodeForXPath:@"/datasource/database_schema" error:nil];
    
    for (GDataXMLElement * entry in [tableNodes children]) {
        NSString * tname = [[entry attributeForName:@"name"] stringValue];
        //判断本地库是否包含主个表,是的情况下我们添加新的字段否则添加新表
        if ([lds existsByPredicateExpression:@"SELF.obj_name = %@" args:@[ tname ]]) {
            //获取本地数据表所包含的字段
            NSArray * tmpLds = [lds findByPredicateExpression:@"SELF.obj_parent = %@" args:@[ tname ]];
            //判断字段是否已经存在了
            for (GDataXMLElement * citem in [entry children]) {
                
                NSString * cname  = [[citem attributeForName:@"name"] stringValue];
                NSString * ctype  = [[citem attributeForName:@"type"] stringValue];
                NSInteger  unique = [[[citem attributeForName:@"unique"] stringValue] integerValue];
                
                if (![tmpLds existsByPredicateExpression:@"SELF.obj_name = %@" args:@[ cname ]]) {

                    [dml addObject:[NSString stringWithFormat:@"insert into db_objs values ('%@','%@','%@','%@','%@','%@')", [NSString GUID],cname,KS_OBJECT_TYPE_F,ctype,@(unique),tname]];
                    if (unique > 0) {
                        [ddl addObject:[NSString stringWithFormat:@"alter table %@ add column %@ %@ unique", tname, cname, ctype]];
                    } else {
                        [ddl addObject:[NSString stringWithFormat:@"alter table %@ add column %@ %@", tname, cname, ctype]];
                    }
                }
            }
        } else {
            
            NSString * osi = [NSString stringWithFormat:@"insert into db_objs values ('%@','%@','%@','%@','%@','%@')", [NSString GUID],tname, KS_OBJECT_TYPE_T, @"", @(0), @""];

            [dml addObject:osi];

            NSMutableString * csql = [[NSMutableString alloc] initWithFormat:@"create table %@ (", tname];

            for (GDataXMLElement * citem in [entry children]) {

                NSString * cname  = [[citem attributeForName:@"name"] stringValue];
                NSString * ctype  = [[citem attributeForName:@"type"] stringValue];
                NSInteger  unique = [[[citem attributeForName:@"unique"] stringValue] integerValue];

                if (unique > 0) {
                    [csql appendFormat:@"%@ %@ unique, ", cname, ctype];
                } else {
                    [csql appendFormat:@"%@ %@, ", cname, ctype];
                }

                [dml addObject:[NSString stringWithFormat:@"insert into db_objs values ('%@','%@','%@','%@','%@','%@')", [NSString GUID],cname,KS_OBJECT_TYPE_F,ctype,@(unique),tname]];
            }
            
            [csql deleteCharactersInRange:NSMakeRange(csql.length - 2, 2)];
            [csql appendString:@")"];
            [ddl addObject:csql];
        }
    }
    *dmls = dml;
    *ddls = ddl;
}

#pragma --mark
#pragma --mark statement

- (GDataXMLElement *)getStatementNodeWithType:(NSString *)t sid:(NSString *)sid
{
    return (GDataXMLElement *)[_document firstNodeForXPath:KS_STATEMENT_EXP(t, sid) error:nil];
}

- (GDataXMLElement *)getResultmapNodeWithId:(NSString *)rid
{
    return (GDataXMLElement *)[_document firstNodeForXPath:KS_RESULT_MAP_EXP(rid) error:nil];
}

- (NSDictionary *)statementWithType:(NSString *)type statementId:(NSString *)statementId
{
    if (![_statementCache objectForKey:statementId]) {
        GDataXMLElement * statementNode = [self getStatementNodeWithType:type sid:statementId];
        if (statementNode) {
            NSString * resultMap = [[statementNode attributeForName:KS_RESULT_MAP] stringValue];
            NSString * script    = [statementNode stringValue];
            
            script = [script stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            script = [script stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            
            if (resultMap) {
                GDataXMLElement * item = [self getResultmapNodeWithId:resultMap];
                
                NSString       * className = [[item attributeForName:KS_RESULT_MAP_CLASS] stringValue];
                NSMutableArray * results   = [NSMutableArray new];
                
                for (GDataXMLElement * entry in item.children) {
                    
                    NSMutableDictionary * rst = [[NSMutableDictionary alloc] initWithCapacity:3];
                    NSString * p = [[entry attributeForName:KS_RESULT_MAP_ITEM_PROPERTY] stringValue];
                    NSString * c = [[entry attributeForName:KS_RESULT_MAP_ITEM_COLUMN] stringValue];
                    NSString * n = [[entry attributeForName:KS_RESULT_MAP_ITEM_NULL_VALUE] stringValue];
                    
                    [rst setObject:p forKey:KS_RESULT_MAP_ITEM_PROPERTY];
                    [rst setObject:c forKey:KS_RESULT_MAP_ITEM_COLUMN];
                    if (n) {
                        [rst setObject:n forKey:KS_RESULT_MAP_ITEM_NULL_VALUE];
                    }
                    [results addObject:rst];
                }
                [_statementCache setObject:@{ KS_STATEMENT_ID  : statementId,
                                              KS_STATEMENT_SQL : script,
                                              KS_RESULT_MAP   : @{ KS_RESULT_MAP_CLASS : className, KS_RESULT_MAP_ITEM : results }}
                                    forKey:statementId];
            } else {
                [_statementCache setObject:@{ KS_STATEMENT_ID  : statementId,
                                              KS_STATEMENT_SQL : script }
                                    forKey:statementId];
            }
        }
    }
    return [_statementCache objectForKey:statementId];
}

- (NSDictionary *)statementBySelectWithId:(NSString *)statementId
{
    return [self statementWithType:@"select" statementId:statementId];
}

- (NSDictionary *)statementByInsertWithId:(NSString *)statementId
{
    return [self statementWithType:@"insert" statementId:statementId];
}

- (NSDictionary *)statementByUpdateWithId:(NSString *)statementId
{
    return [self statementWithType:@"update" statementId:statementId];
}

- (NSDictionary *)statementByDeleteWithId:(NSString *)statementId
{
    return [self statementWithType:@"delete" statementId:statementId];
}

- (NSDictionary *)statementByReplaceWithId:(NSString *)statementId
{
    return [self statementWithType:@"replace" statementId:statementId];
}

@end
