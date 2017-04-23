//
//  TELocationDetailLogic.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TELocation;
@class TEProfile;
@class TEActivity;

@protocol TEDataProvider;

@protocol TELocationDetailLogicDelegate <NSObject>
-(void) locationDetailDidUpdateWorkerAtIndex:(NSInteger) workerIndex;
-(void) locationDetailDidUpdateActivityAtIndex:(NSInteger) activityIndex;
-(void) locationDetailLogicDidEncounterError:(NSError*) error;
@end

@interface TELocationDetailLogic : NSObject
@property (weak) id<TELocationDetailLogicDelegate> delegate;
/**
 Initialize this class utilizing the given data provider and delegate
 
 @param dataProvider data provider to talk to API
 @param delegate     callback delegate
 @param location     initialize location object
 @return an instance of TELocationDetailLogic
 */
-(instancetype) initWithDataProvider:(id<TEDataProvider>) dataProvider delegate:(id<TELocationDetailLogicDelegate>) delegate location:(TELocation*) location;

/**
 Start loading all available locations from backend
 */
-(void) loadLocationDetail;

/**
 Get number of worker to show to user
 
 @return number of worker to show to user
 */
-(NSInteger) numberOfWorkerToShow;

/**
 Get the worker profile to display to user at an index
 
 @param index index of requested worker profile
 @return the worker profile to show at an index
 */
-(TEProfile*) workerProfileToShowAtIndex:(NSInteger) index;

/**
 Get number of activity to show to user
 
 @return number of activity to show to user
 */
-(NSInteger) numberOfActivityToShow;

/**
 Get the activity to display to user at an index
 
 @param index index of requested activity
 @return the activity to show at an index
 */
-(TEActivity*) activityToShowAtIndex:(NSInteger) index;
@end
