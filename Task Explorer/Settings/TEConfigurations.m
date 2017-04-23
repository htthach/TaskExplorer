//
//  TEConfigurations.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEConfigurations.h"
static NSString * const TE_CONFIGURATION_FILE_NAME          = @"Configurations";
static NSString * const TE_CONFIGURATION_FILE_EXTENSION     = @"plist";

static NSString * const TE_CONFIGURATION_KEY_FLICK_BASE_URL = @"APIBaseUrl";
static NSString * const TE_CONFIGURATION_KEY_TO_CACHE_IMAGE = @"ToCacheImage";
static NSString * const TE_CONFIGURATION_KEY_TO_CACHE_API_RESPONSE = @"ToCacheAPIResponse";
@implementation TEConfigurations
#pragma mark - file io
+(NSDictionary*) configDictionary{
    static NSDictionary *configDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //read the config file once
        configDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                       pathForResource:TE_CONFIGURATION_FILE_NAME
                                                                       ofType:TE_CONFIGURATION_FILE_EXTENSION]];
    });
    return configDictionary;
}
#pragma mark - configurations

+(NSString *) baseURLStringForAPI {
    NSString* result = [[TEConfigurations configDictionary] objectForKey:TE_CONFIGURATION_KEY_FLICK_BASE_URL];
    NSAssert(result, @"Missing API Base URL configuration");
    return result;
}

/**
 Return YES if want to enable image caching
 
 @return YES if want to enable image caching
 */
+(BOOL) toCacheImage{
    return [[[TEConfigurations configDictionary] objectForKey:TE_CONFIGURATION_KEY_TO_CACHE_IMAGE] boolValue];
}

/**
 Return YES if want to enable api response caching
 
 @return YES if want to enable api response caching
 */
+(BOOL) toCacheAPIResponse{
    return [[[TEConfigurations configDictionary] objectForKey:TE_CONFIGURATION_KEY_TO_CACHE_API_RESPONSE] boolValue];
}
@end
