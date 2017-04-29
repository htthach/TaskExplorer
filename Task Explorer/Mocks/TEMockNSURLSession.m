//
//  TEMockNSURLSession.m
//  Task Explorer
//
//  Created by thach hinh on 29/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEMockNSURLSession.h"
@interface TEMockNSURLSession ()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSData *mockData;
@end
@implementation TEMockNSURLSession

+(instancetype) mockURLSessionWithData:(NSData*) data{
    TEMockNSURLSession *result = [TEMockNSURLSession new];
    result.mockData = data;
    return result;
}
//to mock this method
- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    self.url = url;
    if (completionHandler) {
        completionHandler (self.mockData, nil, nil);
    }
    return nil;
}

//to return the requested URL from the mocked method
- (NSURL *) requestedURL{
    return self.url;
}
@end
