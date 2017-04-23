//
//  TELocationListLogic.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TELocation;
@protocol TEDataProvider;

@protocol TELocationListLogicDelegate <NSObject>
-(void) locationListDidUpdate;
-(void) locationListLogicDidEncounterError:(NSError*) error;
@end

/**
 This class will handle most of location list logic. We try to keep the view controller dumb. When business logic grows, we would like business logic to be here because business logic changes less frequently than UI. Leave UI dumb and easy to be replaced.
 One of the thing can be added here is pagination logic, sorting based on user location, etc.
 */
@interface TELocationListLogic : NSObject
@property (weak) id<TELocationListLogicDelegate> delegate;
/**
 Initialize this class utilizing the given data provider and delegate
 
 @param dataProvider data provider to talk to API
 @param delegate     callback delegate
 @return an instance of TELocationListLogic
 */
-(instancetype) initWithDataProvider:(id<TEDataProvider>) dataProvider delegate:(id<TELocationListLogicDelegate>) delegate;

/**
 Start loading all available locations from backend
 */
-(void) loadAllLocations;

/**
 Get number of location to show to user

 @return number of location to show to user
 */
-(NSInteger) numberOfLocationsToShow;

/**
 Get the location to display to user at an index

 @param index index of requested location
 @return the location to show at an index
 */
-(TELocation*) locationToShowAtIndex:(NSInteger) index;
@end
