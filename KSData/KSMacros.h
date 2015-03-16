//
//  NBCommon.h
//  NB
//
//  Created by bing.hao on 14/11/20.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma --mark
#pragma --mark Print Log
//=====================================================================>
//Log

/** DEBUG LOG **/
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

/*
#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif
*/

#pragma --mark
#pragma --mark Object
//=====================================================================>
//Object

/**
 * @brief 释放一个对象
 */
#define KSRelease(_v) if(_v) _v = nil;
/**
 * @brief 获取一个NSNull对象
 */
#define KS_NULL [NSNull null]
/**
 * @brief 根据类名创建一个对象
 */
#define KS_NEW_OBJECT(CN) [NSClassFromString(CN) new]
/**
 * @brief 解决BLOCK在Controller中引起循环引用而定义宏,将当前SELF转换为一个弱引用在BLOCK中调用
 */
#define KS_BLOCK_WEAK(t, alias) __weak __typeof(t)alias = t
/**
 * @brief 在BLOCK中装弱引用转化为强引用。出BLOCK后会自动释放
 */
#define KS_BLOCK_STRONG(t, alias) __strong __typeof(t)alias = t

#pragma --mark
#pragma --mark System Version
//=====================================================================>
//Version

/**
 * @brief 判断IOS7以上版本
 */
#define __IOS7_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 7.0f
/**
 * @brief 判断IOS8以上版本
 */
#define __IOS8_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f

#define KS_IOS7_OR_LATER __IOS7_OR_LATER
#define KS_IOS8_OR_LATER __IOS8_OR_LATER

#define KS_APP_VERSION         [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]
#define KS_APP_BUILDER_VERSION [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"]
#define KS_APP_IDENTIFIER      [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]

#pragma --mark
#pragma --mark Frame
//=====================================================================>
//Frame

/**
 * @brief 获取屏幕尺寸
 */
#define KS_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
/**
 * @brief 获取屏幕宽
 */
#define KS_SCREEN_WIDTH  KS_SCREEN_BOUNDS.size.width
/**
 * @brief 获取屏幕高
 */
#define KS_SCREEN_HEIGHT KS_SCREEN_BOUNDS.size.height

#define KS_IPHONE_4_SCREEN_WIDTH       320
#define KS_IPHONE_4_SCREEN_HEIGHT      480
#define KS_IPHONE_5_SCREEN_WIDTH       320
#define KS_IPHONE_5_SCREEN_HEIGHT      568
#define KS_IPHONE_6_SCREEN_WIDTH       375
#define KS_IPHONE_6_SCREEN_HEIGHT      667
#define KS_IPHONE_6_PLUS_SCREEN_WIDTH  414
#define KS_IPHONE_6_PLUS_SCREEN_HEIGHT 736

#define KS_DEFAULT_SCREEN_WIDTH  KS_IPHONE_5_SCREEN_WIDTH
#define KS_DEFAULT_SCREEN_HEIGHT KS_IPHONE_5_SCREEN_HEIGHT

/**
 * @brief 获取一个可缩放的尺寸值
 */
CG_INLINE CGFloat KSFrameValue(CGFloat v) {
    return (KS_SCREEN_WIDTH == KS_DEFAULT_SCREEN_WIDTH) ? v : (v * (KS_SCREEN_WIDTH / KS_DEFAULT_SCREEN_WIDTH));
}

/**
 * @brief 获取一个Rect会自动做屏幕尺寸缩放
 */
CG_INLINE CGRect KSFrameRectMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
    return CGRectMake(KSFrameValue(x), KSFrameValue(y), KSFrameValue(w), KSFrameValue(h));
}
//
//CG_INLINE CGRect KSRectMakePixel(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
//    
//    return CGRectMake(KSGetFrameXPixel(x), KSGetFrameYPixel(y), KSGetFrameWidthPixel(w), KSGetFrameHeightPixel(h));
//}

#pragma --mark
#pragma --mark Math
//=====================================================================>
//Math

/**
 * @brief 获取一个范围随机数
 */
#define KS_M_RANDOM(from, to) from + (arc4random() % (to - from + 1))

#pragma --mark
#pragma --mark Color
//=====================================================================>
//Color
/**
 * @brief 获取一个RBGA颜色值
 */
#define KS_C_RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green: g / 255.0f blue:b / 255.0f alpha:a]
#define RGBA(r,g,b,a) KS_C_RGBA(r,g,b,a)

/**
 * @brief 获取一个16进制颜色值
 */
#define KS_C_HEX(v, a) [UIColor colorWithRed:((Byte)(v >> 16))/255.0 green:((Byte)(v >> 8))/255.0 blue:((Byte)v)/255.0 alpha:a]
#define CHEX(v,a) KS_C_HEX(v,a)

#pragma --mark
#pragma --mark Path
//=====================================================================>
//Path
#define KS_PATH_HOME     NSHomeDirectory()
#define KS_PATH_TEMP     NSTemporaryDirectory()

#define KS_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KS_PATH_CACHE    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define KS_PATH_HOME_FORMAT(s, ...)    [KS_PATH_HOME stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_TEMP_FORMAT(s, ...)    [KS_PATH_TEMP stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_DOCUMENT_FORMAT(s,...) [KS_PATH_DOCUMENT stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_CACHE_FORMAT(s,...)    [KS_PATH_CACHE stringByAppendingFormat:(s), ##__VA_ARGS__]

#define KS_RESOURCE_PATH(N, E)  [[NSBundle mainBundle] pathForResource:(N) ofType:(E)]
#define KS_RESOURCE_PATH_PNG(N) KS_RESOURCE_PATH(N, @"png")
#define KS_RESOURCE_PATH_JPG(N) KS_RESOURCE_PATH(N, @"jpg")
#define KS_RESOURCE_PATH_MP4(N) KS_RESOURCE_PATH(N, @"mp4")
#define KS_RESOURCE_PATH_MOV(N) KS_RESOURCE_PATH(N, @"mov")

#define KS_NEW_FILE_PATH(n,e) [KS_PATH_CACHE_FORMAT(@"%@", n) stringByAppendingFormat:@"/%f.%@", [[NSDate date] timeIntervalSince1970], e]
#define KS_NEW_FILE_PATH_PNG(n) KS_NEW_FILE_PATH(n, @"png")
#define KS_NEW_FILE_PATH_JPG(n) KS_NEW_FILE_PATH(n, @"jpg")
#define KS_NEW_FILE_PATH_MP4(n) KS_NEW_FILE_PATH(n, @"mp4")
#define KS_NEW_FILE_PATH_MOV(n) KS_NEW_FILE_PATH(n, @"mov")

#pragma --mark
#pragma --mark KeyBoard
//=====================================================================>
//KeyBoard

//获取键盘的区域
#define KS_KEYBOARD_GET_FRAME(userInfo)              [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]
//获取弹出键盘的动画时间
#define KS_KEYBOARD_GET_ANIMATION_DURATION(userInfo) [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]

#pragma --mark
#pragma --mark Font
//=====================================================================>
//Font

#define KS_FONT(n, s)          [UIFont fontWithName:(N) size:(S)]
#define KS_FONT_SYSTEM_B(s)    [UIFont boldSystemFontOfSize:S]
#define KS_FONT_SYSTEM(s)      [UIFont systemFontOfSize:S]


#pragma --mark
#pragma --mark Thread
//=====================================================================>
//Thread
/**
 * @brief 主线程运行block语句块
 */
CG_INLINE void runDispatchGetMainQueue(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
CG_INLINE void KS_DISPATCH_MAIN_QUEUE(void (^block)(void)) {
    runDispatchGetMainQueue(block);
}
/**
 * @brief 主线程运行block语句块
 */
CG_INLINE void runDispatchGetGlobalQueue(void (^block)(void)) {
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, block);
}
CG_INLINE void KS_DISPATCH_GLOBAL_QUEUE(void (^block)(void)) {
    runDispatchGetGlobalQueue(block);
}

