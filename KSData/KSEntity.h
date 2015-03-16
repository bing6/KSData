//
//  KSEntity.h
//  KSData
//
//  Created by bing.hao on 15/3/16.
//
//

#import <Foundation/Foundation.h>
#import "KSDataObject.h"

@interface  KSUserEntity : KSDataObject

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userAvatar;

@end

@interface  KSUserDetialEntity : KSDataObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userAddress;
@property (nonatomic, assign) NSInteger userUnread;

@end
