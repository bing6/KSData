//
//  NSString+KS.m
//  KSToolkit
//
//  Created by bing.hao on 14/12/5.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "NSString+KS.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (KS)

+ (BOOL)isNullOrEmpty:(NSString *)str
{
    if (!str) {
        // null object
        return YES;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return YES;
        } else {
            // is neither empty nor null
            return NO;
        }
    }
}

+ (NSString *)GUID
{
    CFUUIDRef   uuid_ref        = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
}

+ (NSString *)pathWithFileName:(NSString *)fileName
{
    NSURL          * url = [NSURL fileURLWithPath:fileName];
    NSMutableArray * tmp = [NSMutableArray arrayWithArray:[url pathComponents]];
    
    [tmp removeLastObject];

    NSString * path = [tmp componentsJoinedByString:@"/"];
    
    path = [path stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return path;
}

@end
