//
//  TEDataProvider.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TELocationList;
@class TELocation;
@protocol TEDataProvider <NSObject>
/**
 Load all locations available
 
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadAllLocationSuccess:(void (^)(TELocationList *result)) success
                          fail:(void (^)(NSError *error)) fail;

/**
 Load a location detail from location id
 
 @param locationId the id of the location to load
 @param success success callback block
 @param fail    failure callback block
 */
-(void) loadLocationDetailWithId:(NSNumber*) locationId
                         success:(void (^)(TELocation *result)) success
                            fail:(void (^)(NSError *error)) fail;
@end
