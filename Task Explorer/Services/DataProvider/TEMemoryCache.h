//
//  TEMemoryCache.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEObjectCache.h"
static NSUInteger const TE_SMALL_CACHE_SIZE     = 10 * 1024 * 1024; //10 MB
static NSUInteger const TE_MEDIUM_CACHE_SIZE    = 20 * 1024 * 1024; //20 MB
static NSUInteger const TE_LARGE_CACHE_SIZE     = 50 * 1024 * 1024; //50 MB

/**
 A simple in memory cache with NSCache and a naive cost function
 */
@interface TEMemoryCache : NSObject <TEObjectCache>

/**
 Init a new cache instance with custom size
 
 @param cacheSize target cache size
 @return new cache instance with custom size
 */
-(instancetype) initWithSize:(NSUInteger) cacheSize;
@end
