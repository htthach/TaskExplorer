//
//  TEAPIDataProvider.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEDataProvider.h"
#import "TEImageProvider.h"
@protocol TEDataToObjectParser;
@protocol TEObjectCache;

/**
 Simplified data and image provider to talk to Server API. For simplicity we implement both protocol in this class. Of course in real world we'll just split them up further.
 */
@interface TEAPIDataProvider : NSObject <TEDataProvider, TEImageProvider>
/**
 Convenient factory method to return a shared standard API data provider.
 
 @return an singleton instance of TEAPIDataProvider
 */
+(instancetype) sharedDefaultProvider;

/**
 Initialize TEAPIDataProvider with proper configuration
 
 @param parser the TEDataToObjectParser parser to use to parse api response NSData to Object
 @param url the base URL to use for all API request
 @param session the session to use for data task
 @param apiResponseCache the api response cache to use. Pass nil if don't want to enable auto API caching.
 @param imageCache the image cache to use. Pass nil if don't want to enable auto image caching.
 @return an instance of TEAPIDataProvider
 */
-(instancetype)initWithParser:(id<TEDataToObjectParser>) parser
                      baseURL:(NSURL *)url
                      session:(NSURLSession*) session
             apiResponseCache:(id<TEObjectCache>) apiResponseCache
                   imageCache:(id<TEObjectCache>) imageCache;
@end
