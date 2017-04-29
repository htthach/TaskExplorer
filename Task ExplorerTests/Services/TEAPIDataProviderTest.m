//
//  TEAPIDataProviderTest.m
//  Task Explorer
//
//  Created by thach hinh on 29/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TEMockNSURLSession.h"
#import "TEAPIDataProvider.h"
#import "TEJSONParser.h"
#import "TELocation.h"

@interface TEAPIDataProviderTest : XCTestCase

@end

@implementation TEAPIDataProviderTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadLocationDetail {
    NSString *jsonString = @"{\"display_name\":\"Rockdale NSW2216,Australia\",\"id\":5,\"latitude\":\"-33.95082\",\"longitude\":\"151.1388\",\"worker_count\":4,\"worker_ids\":[1,2,3,4],\"recent_activity\":[{\"task_id\":5,\"profile_id\":1,\"message\":\"{profileName}askedaquestionabout{taskName}\",\"created_at\":\"\",\"event\":\"comment\"},{\"task_id\":4,\"profile_id\":5,\"message\":\"{profileName}posted{taskName}\",\"created_at\":\"\",\"event\":\"post\"},{\"task_id\":5,\"profile_id\":2,\"message\":\"{profileName}posted{taskName}\",\"created_at\":\"\",\"event\":\"post\"}]}";
    
    
    NSData *mockData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    TEMockNSURLSession *mockSession = [TEMockNSURLSession mockURLSessionWithData:mockData];
    TEAPIDataProvider *dataProvider = [[TEAPIDataProvider alloc] initWithParser:[TEJSONParser new]
                                                                                    baseURL:[NSURL URLWithString:@"https://baseurl.com"]
                                                                                    session:mockSession
                                                                           apiResponseCache:nil
                                                                                 imageCache:nil];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Parsing Method"];
    
    NSString *expectedUrlString = @"https://baseurl.com/location/5.json";
    
    [dataProvider loadLocationDetailWithId:@(5) success:^(TELocation *result) {
        XCTAssertEqualObjects(result.displayName, @"Rockdale NSW2216,Australia", @"Data provider should return data from mock session");
        [expectation fulfill];
    } fail:^(NSError *error) {
        XCTAssert(NO, @"Fail block should not be called");
        [expectation fulfill];
    }];
    
    XCTAssertEqualObjects(expectedUrlString, [mockSession requestedURL].absoluteString, @"data provider should construct the correct url");
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}
- (void)testSearchPhotoWithTextFail {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Parsing Method"];
    NSData *mockData = [@"corrupted data" dataUsingEncoding:NSUTF8StringEncoding];
    TEMockNSURLSession *mockSession = [TEMockNSURLSession mockURLSessionWithData:mockData];
    TEAPIDataProvider *dataProvider = [[TEAPIDataProvider alloc] initWithParser:[TEJSONParser new]
                                                                                    baseURL:[NSURL URLWithString:@"https://baseurl.com"]
                                                                                    session:mockSession
                                                                           apiResponseCache:nil
                                                                                 imageCache:nil];
    [dataProvider loadLocationDetailWithId:@(5) success:^(TELocation *result) {
        XCTAssert(NO, @"Data provider should not call back success for corrupted data");
        [expectation fulfill];
    } fail:^(NSError *error) {
        XCTAssertNotNil(error, @"Fail block should be called with error object");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}
@end
