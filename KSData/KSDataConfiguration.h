//
//  KSDbConfiguration.h
//  KSToolkit
//
//  Created by bing.hao on 15/2/5.
//  Copyright (c) 2015年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GDataXMLNode.h>
#import <FMDB.h>

#define KS_OBJECT_TYPE_T @"T"
#define KS_OBJECT_TYPE_F @"F"

#define KS_STATEMENT_ID               @"statement_id"
#define KS_STATEMENT_SQL              @"statement_sql"
#define KS_RESULT_MAP                 @"result_map"
#define KS_RESULT_MAP_CLASS           @"class"
#define KS_RESULT_MAP_ITEM            @"item"
#define KS_RESULT_MAP_ITEM_PROPERTY   @"property"
#define KS_RESULT_MAP_ITEM_COLUMN     @"column"
#define KS_RESULT_MAP_ITEM_NULL_VALUE @"null_value"


@interface KSDataConfiguration : NSObject
{
    NSMutableDictionary * _statementCache;
}

@property (nonatomic, strong, readonly) GDataXMLDocument * document;
@property (nonatomic, strong, readonly) NSString         * dbPath;
@property (nonatomic, assign, readonly) NSInteger          dbVersion;

+ (id)newInstance:(NSString *)path dec:(NSString *)key;
- (id)initWithConfigurationPath:(NSString *)path decryptionKey:(NSString *)key;
- (id)initWithConfigurationPath:(NSString *)path decryptionKey:(NSString *)key customPath:(NSString *)customPath;

- (void)initializeDatabase;

- (NSDictionary *)statementBySelectWithId:(NSString *)statementId;
- (NSDictionary *)statementByInsertWithId:(NSString *)statementId;
- (NSDictionary *)statementByUpdateWithId:(NSString *)statementId;
- (NSDictionary *)statementByDeleteWithId:(NSString *)statementId;
- (NSDictionary *)statementByReplaceWithId:(NSString *)statementId;

@end
