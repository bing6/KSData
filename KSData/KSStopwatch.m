//
//  KDTimeInterval.m
//  KDFuDao
//
//  Created by bing.hao on 14-7-1.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "KSStopwatch.h"
#import <mach/mach_time.h>

@implementation KSStopwatch

+ (id)stopwatchAndStartTime
{
    KSStopwatch * sw = [[KSStopwatch alloc] init];
    
    [sw start];
    
    return sw;
}

- (void)start
{
    _startTimeInterval = mach_absolute_time();
}

- (void)stop
{
    self.duration = [self getElapsed];
}

- (double)getElapsed
{
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    
    uint64_t timeInterval = mach_absolute_time() - _startTimeInterval;
    
    timeInterval *= info.numer;
    timeInterval /= info.denom;
    
    //纳秒转换为秒
    double duration = (timeInterval * 1.0f) / 1000000000;
    
    return duration;
}

@end
