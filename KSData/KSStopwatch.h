//
//  KDTimeInterval.h
//  KDFuDao
//
//  Created by bing.hao on 14-7-1.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief KSStopwatch 实例可以测量一个时间间隔的运行时间。
 */
@interface KSStopwatch : NSObject
{
    NSTimeInterval _startTimeInterval;
}

@property (nonatomic, assign) double duration;

+ (id)stopwatchAndStartTime;

- (void)start;
- (void)stop;

@end
