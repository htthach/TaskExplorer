//
//  TELocation.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"
@class TEActivity;
@class TEProfile;
@interface TELocation : TEBaseModel
@property (nonatomic, copy) NSNumber    *locationId;
@property (nonatomic, copy) NSNumber    *latitude;
@property (nonatomic, copy) NSNumber    *longitude;
@property (nonatomic, copy) NSNumber    *workerCount;

@property (nonatomic, copy) NSString    *displayName;

@property (nonatomic, strong) NSArray <NSNumber*>           *workerId;
@property (nonatomic, strong) NSArray <TEActivity*>         *recentActivity;

@property (nonatomic, strong) NSMutableArray <TEProfile*>   *workerProfiles;
/**
 Get number of top workers at this location. We use array count instead of workerCount because not enough documentation to trust that variable
 
 @return number of workers
 */
-(NSInteger) numberOfWorkers;

/**
 Get the worker id at an index
 
 @param index index of requested worker id
 @return the worker id at an index
 */
-(NSNumber*) workerIdAtIndex:(NSInteger) index;

/**
 Get the worker profile at an index
 
 @param index index of requested worker profile
 @return the worker profile at an index
 */
-(TEProfile*) workerProfileAtIndex:(NSInteger) index;

/**
 Get number of latest activities at this location
 
 @return number of activity to show to user
 */
-(NSInteger) numberOfActivities;

/**
 Get the activity at an index
 
 @param index index of requested activity
 @return the activity at an index
 */
-(TEActivity*) activityAtIndex:(NSInteger) index;
@end
