//
//  TEMockNSURLSession.h
//  Task Explorer
//
//  Created by thach hinh on 29/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEMockNSURLSession : NSURLSession

+(instancetype _Nullable) mockURLSessionWithData:(NSData*_Nullable) data;

//We'll mock this method
//- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

//to return the requested URL from the mocked method
- (NSURL * _Nullable) requestedURL;
@end
