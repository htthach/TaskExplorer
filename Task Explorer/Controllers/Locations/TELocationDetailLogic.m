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
@interface TELocationDetailLogic ()
@property (nonatomic, strong) id<TEDataProvider>    dataProvider;
@property (nonatomic, strong) TELocation            *location;
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
        //
    }
}


/**
 Hydrate activity details
 */
-(void) loadActivityDetails{
    
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
@end
