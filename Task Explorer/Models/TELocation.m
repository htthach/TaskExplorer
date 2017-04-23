//
//  TELocation.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocation.h"
#import "TETask.h"
#import "TEProfile.h"
@implementation TELocation
#pragma mark - override methods
/**
 Return the key map between json key vs this object property name. By default we set property name using camel case and JSON tag from server as snake case.
 Child class can override this if there is mismatch between object property name and json tag.
 
 @return the key map between json key vs this object property name
 */
-(NSMutableDictionary *)getKeyMap{
    NSMutableDictionary *keyMap = [super getKeyMap];
    [keyMap setObject:@"locationId" forKey:@"id"];
    return keyMap;
}

/**
 if there is a property of type array, return the class of that array's elements
 
 @param arrayName name of that property
 @return class of the array's elements
 */
-(Class) getClassForArrayName:(NSString*) arrayName{
    if ([arrayName isEqualToString:@"workerId"]) {
        return [NSNumber class];
    }
    if ([arrayName isEqualToString:@"recentActivity"]) {
        return [TETask class];
    }
    
    return [super getClassForArrayName:arrayName];
}

//override worker id array setter
-(void)setWorkerId:(NSArray<NSNumber *> *)workerId{
    _workerId = workerId;
    _workerProfiles = [NSMutableArray array];
    for (int i = 0; i < [workerId count]; i++) {
        TEProfile *workerProfile = [TEProfile new];
        workerProfile.profileId = workerId[i];
        [_workerProfiles addObject:workerProfile];
    }
}

/**
 Get number of top workers at this location. We use array count instead of workerCount because not enough documentation to trust that variable
 
 @return number of workers
 */
-(NSInteger) numberOfWorkers{
    if (self.workerProfiles) {
        return [self.workerProfiles count];
    }
    else {
        return [self.workerId count];
    }
}

/**
 Get the worker id at an index
 
 @param index index of requested worker id
 @return the worker id at an index
 */
-(NSNumber*) workerIdAtIndex:(NSInteger) index{
    if (index >= 0 && index < [self.workerId count]) {
        return self.workerId[index];
    }
    return nil;
}

/**
 Get the worker profile at an index
 
 @param index index of requested worker profile
 @return the worker profile at an index
 */
-(TEProfile*) workerProfileAtIndex:(NSInteger) index{
    if (index >= 0 && index < [self.workerProfiles count]) {
        return self.workerProfiles[index];
    }
    return nil;
}

/**
 Get number of latest activities at this location
 
 @return number of activity to show to user
 */
-(NSInteger) numberOfActivities{
    return [self.recentActivity count];
}

/**
 Get the activity at an index
 
 @param index index of requested activity
 @return the activity at an index
 */
-(TEActivity*) activityAtIndex:(NSInteger) index{
    if (index >= 0 && index < [self.recentActivity count]) {
        return self.recentActivity[index];
    }
    return nil;
}
@end
