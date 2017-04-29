//
//  TEJSONParserTest.m
//  Task Explorer
//
//  Created by thach hinh on 29/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TEJSONParser.h"
#import "TELocation.h"
#import "TEActivity.h"
#import "TEProfile.h"

@interface TEJSONParserTest : XCTestCase
@property (nonatomic, strong) NSData *testData;
@end

@implementation TEJSONParserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSString *jsonString = @"{\"display_name\":\"RockdaleNSW2216,Australia\",\"id\":5,\"latitude\":\"-33.95082\",\"longitude\":\"151.1388\",\"worker_count\":4,\"worker_ids\":[1,2,3,4],\"recent_activity\":[{\"task_id\":5,\"profile_id\":1,\"message\":\"{profileName}askedaquestionabout{taskName}\",\"created_at\":\"\",\"event\":\"comment\"},{\"task_id\":4,\"profile_id\":5,\"message\":\"{profileName}posted{taskName}\",\"created_at\":\"\",\"event\":\"post\"},{\"task_id\":5,\"profile_id\":2,\"message\":\"{profileName}posted{taskName}\",\"created_at\":\"\",\"event\":\"post\"}]}";
    
    self.testData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParseData {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Parsing Method"];
    
    
    TEJSONParser *parser = [TEJSONParser new];
    [parser parseData:self.testData intoObjectOfClass:[TELocation class] complete:^(id resultObject, NSError *parseError) {
        TELocation *location = resultObject;
        XCTAssertNil(parseError, @"Parser should parse correct data with no error");
        XCTAssert([resultObject isMemberOfClass:[TELocation class]], @"Parser should parse into given class");
        XCTAssertEqualObjects(location.locationId, @(5), @"Parser should parse attribute properly");
        XCTAssertEqual([location numberOfWorkers], 4, @"Parser should parse all array element");
        XCTAssertEqual([location numberOfActivities], 3, @"Parser should parse all array element");
        XCTAssertEqualObjects([location activityAtIndex:0].taskId, @(5), @"Parser should parse nested object");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}
- (void)testParseDataError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Parsing Method"];
    
    TEJSONParser *parser = [TEJSONParser new];
    [parser parseData:[@"corrupted data" dataUsingEncoding:NSUTF8StringEncoding] intoObjectOfClass:[TELocation class] complete:^(id resultObject, NSError *parseError) {
        XCTAssertNotNil(parseError, @"Parser should parse corrupted data with error");
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
