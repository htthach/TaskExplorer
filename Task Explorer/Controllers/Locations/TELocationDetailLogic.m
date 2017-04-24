//
//  TELocationDetailLogic.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationDetailLogic.h"
#import "TELocation.h"
#import "TEDataProvider.h"
#import "TEActivity.h"
#import "TETask.h"
#import "TEProfile.h"

@interface TELocationDetailLogic ()
@end
@implementation TELocationDetailLogic
/**
 Initialize this class utilizing the given data provider and delegate
 
 @param dataProvider data provider to talk to API
 @param delegate     callback delegate
 @param location     initialize location object
 @return an instance of TELocationDetailLogic
 */
-(instancetype) initWithDataProvider:(id<TEDataProvider>) dataProvider delegate:(id<TELocationDetailLogicDelegate>) delegate location:(TELocation*) location{
    self = [super init];
    if (self) {
        self.dataProvider = dataProvider;
        self.delegate = delegate;
        self.location = location;
    }
    return self;
}

/**
 Start loading all available locations from backend
 */
-(void) loadLocationDetail{
    [self.dataProvider loadLocationDetailWithId:self.location.locationId success:^(TELocation *result) {
        self.location = result;
        [self loadWorkerDetails];
        [self loadActivityDetails];
    } fail:^(NSError *error) {
        [self.delegate locationDetailLogicDidEncounterError:error];
    }];
}


/**
 Hydrate worker details
 */
-(void) loadWorkerDetails{
    NSInteger workerCount = [self.location numberOfWorkers];
    for (NSInteger i = 0; i < workerCount; i++) {
        [self.dataProvider loadProfileDetailWithId:[self.location workerIdAtIndex:i] success:^(TEProfile *result) {
            //use result to update location
            [self.location updateWorkerProfile:result atIndex:i];
            [self.delegate locationDetailDidUpdateWorkerAtIndex:i];
        } fail:^(NSError *error) {
            [self.delegate locationDetailLogicDidEncounterError:error];
        }];
    }
}


/**
 Hydrate activity details
 */
-(void) loadActivityDetails{
    NSInteger activityCount = [self.location numberOfActivities];
    for (NSInteger i = 0; i < activityCount; i++) {
        TEActivity *activity = [self.location activityAtIndex:i];
        [self loadDetailForActivity:activity atIndex:i];
    }
}


/**
 Hydrate detail of one activity

 @param activity activity to load detail of profile and task for
 @param index index of this activity in our location
 */
-(void) loadDetailForActivity:(TEActivity*) activity atIndex:(NSInteger) index{
    __block NSError *profileError = nil;
    __block NSError *taskError = nil;
    
    dispatch_group_t loadActivityGroup = dispatch_group_create();
    
    //load profile detail
    dispatch_group_enter(loadActivityGroup);
    [self.dataProvider loadProfileDetailWithId:activity.profileId success:^(TEProfile *result) {
        activity.profile = result;
        dispatch_group_leave(loadActivityGroup);
    } fail:^(NSError *error) {
        profileError = error;
        dispatch_group_leave(loadActivityGroup);
    }];
    
    // load task detail
    dispatch_group_enter(loadActivityGroup);
    [self.dataProvider loadTaskDetailWithId:activity.taskId success:^(TETask *result) {
        activity.task = result;
        dispatch_group_leave(loadActivityGroup);
    } fail:^(NSError *error) {
        taskError = error;
        dispatch_group_leave(loadActivityGroup);
    }];
    
    dispatch_group_notify(loadActivityGroup,dispatch_get_main_queue(),^{
        if (profileError) {
            [self.delegate locationDetailLogicDidEncounterError:profileError];
        }
        if (taskError) {
            [self.delegate locationDetailLogicDidEncounterError:taskError];
        }
        [self.delegate locationDetailDidUpdateActivityAtIndex:index];
    });
}


/**
 Get number of worker to show to user
 
 @return number of worker to show to user
 */
-(NSInteger) numberOfWorkerToShow{
    return [self.location numberOfWorkers];
}

/**
 Get the worker profile to display to user at an index
 
 @param index index of requested worker profile
 @return the worker profile to show at an index
 */
-(TEProfile*) workerProfileToShowAtIndex:(NSInteger) index{
    return [self.location workerProfileAtIndex:index];
}

/**
 Get number of activity to show to user
 
 @return number of activity to show to user
 */
-(NSInteger) numberOfActivityToShow{
    return [self.location numberOfActivities];
}

/**
 Get the activity to display to user at an index
 
 @param index index of requested activity
 @return the activity to show at an index
 */
-(TEActivity*) activityToShowAtIndex:(NSInteger) index{
    return [self.location activityAtIndex:index];
}

/**
 Get the coordinate of the location to show
 
 @return the coordinate of the location to show
 */
-(CLLocationCoordinate2D) coordinateOfLocation{
    return CLLocationCoordinate2DMake([self.location.latitude doubleValue], [self.location.longitude doubleValue]);
}
@end
