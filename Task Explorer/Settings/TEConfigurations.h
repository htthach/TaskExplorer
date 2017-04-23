//
//  TEConfigurations.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEConfigurations : NSObject

+(NSString *) baseURLStringForAPI;

/**
 Return YES if want to enable image caching
 
 @return YES if want to enable image caching
 */
+(BOOL) toCacheImage;

/**
 Return YES if want to enable api response caching
 
 @return YES if want to enable api response caching
 */
+(BOOL) toCacheAPIResponse;

@end
