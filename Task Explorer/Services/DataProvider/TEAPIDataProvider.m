//
//  TEAPIDataProvider.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEAPIDataProvider.h"
#import "TEJSONParser.h"
#import "TEConfigurations.h"
#import "TEHelper.h"
#import "TEMemoryCache.h"

#import "TELocationList.h"
#import "TELocation.h"
#import "TEProfile.h"
#import "TETask.h"

static NSString * const TE_ENDPOINT_LOCATION_LIST   = @"locations";
static NSString * const TE_ENDPOINT_LOCATION        = @"location";
static NSString * const TE_ENDPOINT_PROFILE         = @"profile";
static NSString * const TE_ENDPOINT_TASK            = @"task";
static NSString * const TE_ENDPOINT_RESPONSE_TYPE   = @"json";

static int const TE_NETWORK_ERROR_CODE_INVALID_PARAM        = 400;
static NSString * const TE_NETWORK_ERROR_DOMAIN             = @"com.taskexplorer.ios.network";

@interface TEAPIDataProvider () <NSURLSessionDelegate>
@property (nonatomic, strong) id<TEDataToObjectParser>  parser;
@property (nonatomic, strong) NSURL                     *baseURL;
@property (nonatomic, strong) NSURLSession              *session;
@property (nonatomic, strong) id<TEObjectCache>         apiResponseCache;
@property (nonatomic, strong) id<TEObjectCache>         imageCache;
@end

@implementation TEAPIDataProvider

/**
 Convenient factory method to return a shared standard API data provider.
 
 @return an singleton instance of TEAPIDataProvider
 */
+(instancetype) sharedDefaultProvider{
    static TEAPIDataProvider *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TEAPIDataProvider dataProviderWithDefaultConfig];
    });
    return sharedInstance;
}


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
                   imageCache:(id<TEObjectCache>) imageCache{
    self = [super init];
    if (self) {
        self.parser = parser;
        self.baseURL = url;
        self.session = session;
        self.apiResponseCache = apiResponseCache;
        self.imageCache = imageCache;
    }
    return self;
}


/**
 A convenient method to create a default data provider with default config
 
 @return A default data provider with default config
 */
+(instancetype) dataProviderWithDefaultConfig{
    id<TEObjectCache> imageCache = nil;
    id<TEObjectCache> apiResponseCache = nil;
    
    if ([TEConfigurations toCacheImage]) {
        imageCache = [[TEMemoryCache alloc] initWithSize:TE_LARGE_CACHE_SIZE];
    }
    
    if ([TEConfigurations toCacheAPIResponse]){
        apiResponseCache = [[TEMemoryCache alloc] initWithSize:TE_SMALL_CACHE_SIZE];
    }
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[[NSOperationQueue alloc] init]];
    
    return [[TEAPIDataProvider alloc] initWithParser:[TEJSONParser new]
                                                   baseURL:[TEAPIDataProvider apiBaseURL]
                                                   session:session
                                          apiResponseCache:apiResponseCache
                                                imageCache:imageCache
            ];
}



#pragma mark - network helpers

/**
 Simplified Http get method helper
 
 @param endpoint url end point (to be combined with base url)
 @param returnType the expected return type of the response
 @param success success call back block
 @param fail fail call back block
 */
-(void) GET:(NSString*) endpoint
 returnType:(Class) returnType
    success:(void (^)(id responseObject)) success
       fail:(void (^)(NSError *error)) fail{
    
    //check if in cache
    id cachedResponse = [self.apiResponseCache getObjectForKey:endpoint];
    if (cachedResponse) {
        if (success) {
            success(cachedResponse);
        }
        return;
    }
    
    //not cached, fetch new one
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL: [self urlForEndPoint:endpoint]
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *error) {
                                                     if (error) {
                                                         //data task error, abort
                                                         if (fail) {
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 fail(error);
                                                             });
                                                         }
                                                         return;
                                                     }
                                                     NSUInteger dataSize = [data length];
                                                     //data task completed, proceed to parse data
                                                     [self.parser parseData:data
                                                          intoObjectOfClass:returnType
                                                                   complete:^(id resultObject,
                                                                              NSError *parseError) {
                                                                       
                                                                       //if cannot parse, abort
                                                                       if (parseError) {
                                                                           if (fail) {
                                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                   fail(parseError);
                                                                               });
                                                                           }
                                                                           return;
                                                                       }
                                                                       
                                                                       //can parse successfully
                                                                       [self.apiResponseCache cacheObject:resultObject ofSize:dataSize forKey:endpoint];
                                                                       if (success) {
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               success(resultObject);
                                                                           });
                                                                       }
                                                                   }];
                                                 }];
    
    [dataTask resume];
}

/**
 Simplified image download helper with caching
 
 @param imageUrl url of the image to download
 @param success success call back block
 @param fail fail call back block
 */
-(void) downloadImageFromUrl:(NSURL*) imageUrl
                     success:(void (^)(UIImage *image)) success
                        fail:(void (^)(NSError *error)) fail{
    
    //check if in cache
    id cachedResponse = [self.imageCache getObjectForKey:imageUrl.absoluteString];
    if (cachedResponse) {
        if (success) {
            success(cachedResponse);
        }
        return;
    }
    
    //not cached, download new one
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL: imageUrl
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *error) {
                                                     if (!data || error) {
                                                         //download error, abort
                                                         
                                                         if (fail) {
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 fail(error);
                                                             });
                                                         }
                                                         return;
                                                     }
                                                     
                                                     //download completed, convert to image
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     [self.imageCache cacheObject:image ofSize:[data length] forKey:imageUrl.absoluteString];
                                                     
                                                     if (success) {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             success(image);
                                                         });
                                                     }
                                                 }];
    [dataTask resume];
}
#pragma mark - url construction helpers
/**
 Return API base url from config file
 
 @return API base url from config file
 */
+(NSURL*) apiBaseURL{
    NSString *baseUrlString = [TEConfigurations baseURLStringForAPI];
    return [NSURL URLWithString:baseUrlString];
}

-(NSURL*) urlForEndPoint:(NSString *) endpoint{
    return [NSURL URLWithString:endpoint relativeToURL:self.baseURL];
}


/**
 Construct endpoint with components, queries and response type

 @param components components to add to endpoint
 @param queries query dictionary to add to endpoint (name:value)
 @param responseType response type at end of endpoint path
 @return endpoint with components, queries and response type
 */
-(NSString*) endPointWithComponent:(NSArray<NSString*>*) components queries:(NSDictionary<NSString *, NSString *>*) queries responseType:(NSString*) responseType{
    NSString *endpoint = [NSString string];
    //add components
    for (int i = 0; i < [components count]; i++) {
        endpoint = [endpoint stringByAppendingPathComponent:components[i]];
    }
    
    //add response type
    if (![TEHelper isEmptyString:responseType]) {
        endpoint = [endpoint stringByAppendingString:[NSString stringWithFormat:@".%@", responseType]];
    }
    
    NSURLComponents *fullEndpoint = [NSURLComponents componentsWithString:endpoint];
    
    //add queries
    NSMutableArray *queryItems = [NSMutableArray array];
    NSArray *sortedKeys = [[queries allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [(NSString*) obj1 compare:(NSString*) obj2];
    }];
    
    for (NSString *key in sortedKeys) {
        NSString *value = queries[key];
        if (![TEHelper isEmptyString:key] && ![TEHelper isEmptyString:value]) {
            //only add query item if valid string
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key
                                                              value:queries[key]
                                   ]
             ];
        }
    }
    
    if ([queryItems count] > 0) {
        fullEndpoint.queryItems = queryItems;
    }
    

    return fullEndpoint.URL.absoluteString;
}

/**
 Construct image url based on endpoint and base url
 @param endpoint endpoint of the url
 @return the URL to download the image from
 */
-(NSURL*) imageFullURLFromEndpoint:(NSString*) endpoint {
    //remove / prefix
    if ([endpoint hasPrefix:@"/"]) {
        endpoint = [endpoint stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    return [[TEAPIDataProvider apiBaseURL] URLByAppendingPathComponent:endpoint];
}

/**
 Construct an error object to describe the "invalid request param" error with a reason
 
 @return an error object to describe the "invalid request param" error
 */
+(NSError*) invalidRequestParamError:(NSString*) reason{
    NSError *error = [[NSError alloc] initWithDomain:TE_NETWORK_ERROR_DOMAIN
                                                code:TE_NETWORK_ERROR_CODE_INVALID_PARAM
                                            userInfo:[NSDictionary dictionaryWithObject:reason
                                                                                 forKey:NSLocalizedDescriptionKey
                                                      ]
                      ];
    return error;
}

#pragma mark - Implementation of TEDataProvider
/**
 Load all locations available
 
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadAllLocationSuccess:(void (^)(TELocationList *result)) success
                          fail:(void (^)(NSError *error)) fail{
    [self GET:[self endPointWithComponent:@[TE_ENDPOINT_LOCATION_LIST]
                                  queries:nil
                             responseType:TE_ENDPOINT_RESPONSE_TYPE
               ]
   returnType:[TELocationList class]
      success:success
         fail:fail];
}

/**
 Load a location detail from location id
 
 @param locationId the id of the location to load
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadLocationDetailWithId:(NSNumber*) locationId
                         success:(void (^)(TELocation *result)) success
                            fail:(void (^)(NSError *error)) fail{
    
    //check if valid parameters
    if ([TEHelper isEmptyString:locationId.stringValue]) {
        if (fail) {
            fail ([TEAPIDataProvider invalidRequestParamError:NSLocalizedString(@"Missing location id", @"Missing location id")]);
        }
        return;
    }
    
    [self GET:[self endPointWithComponent:@[TE_ENDPOINT_LOCATION, locationId.stringValue]
                                  queries:nil
                             responseType:TE_ENDPOINT_RESPONSE_TYPE
               ]
   returnType:[TELocation class]
      success:success
         fail:fail];
}

/**
 Load a profile detail from profile id
 
 @param profileId the id of the profile to load
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadProfileDetailWithId:(NSNumber*) profileId
                        success:(void (^)(TEProfile *result)) success
                           fail:(void (^)(NSError *error)) fail{
    //check if valid parameters
    if ([TEHelper isEmptyString:profileId.stringValue]) {
        if (fail) {
            fail ([TEAPIDataProvider invalidRequestParamError:NSLocalizedString(@"Missing profile id", @"Missing profile id")]);
        }
        return;
    }
    
    [self GET:[self endPointWithComponent:@[TE_ENDPOINT_PROFILE, profileId.stringValue]
                                  queries:nil
                             responseType:TE_ENDPOINT_RESPONSE_TYPE
               ]
   returnType:[TEProfile class]
      success:success
         fail:fail];
}

/**
 Load a task detail from task id
 
 @param taskId the id of the task to load
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadTaskDetailWithId:(NSNumber*) taskId
                     success:(void (^)(TETask *result)) success
                        fail:(void (^)(NSError *error)) fail{
    //check if valid parameters
    if ([TEHelper isEmptyString:taskId.stringValue]) {
        if (fail) {
            fail ([TEAPIDataProvider invalidRequestParamError:NSLocalizedString(@"Missing task id", @"Missing task id")]);
        }
        return;
    }
    
    [self GET:[self endPointWithComponent:@[TE_ENDPOINT_TASK, taskId.stringValue]
                                  queries:nil
                             responseType:TE_ENDPOINT_RESPONSE_TYPE
               ]
   returnType:[TETask class]
      success:success
         fail:fail];
}
#pragma mark - Implementation of TEImageProvider

/**
 Download a photo from server given an endpoint
 
 @param photoEndpoint the photo endpoint of the url to download. If TEConfigurations enable for caching. A cached version will be returned if downloaded this before.
 @param success success callback block
 @param fail fail callback block
 */
-(void) downloadImageForEndpoint:(NSString*) photoEndpoint
                         success:(void (^)(UIImage *image)) success
                            fail:(void (^)(NSError *error)) fail{
    if ([TEHelper isEmptyString:photoEndpoint]) {
        if (fail) {
            fail([TEAPIDataProvider invalidRequestParamError:NSLocalizedString(@"Missing image url", @"Missing image url")]);
        }
        return;
    }
    
    NSURL *imageUrl = [self imageFullURLFromEndpoint:photoEndpoint];
    [self downloadImageFromUrl:imageUrl success:success fail:fail];
}
@end
