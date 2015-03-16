//
//  KSDataObject.h
//  KSToolkit
//
//  Created by bing.hao on 14/12/5.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDataObject : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (NSDictionary *)dictionaryValue;

+ (id)objectWithName:(NSString *)className;

@end
