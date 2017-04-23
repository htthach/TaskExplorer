//
//  TELocationListLogic.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationListLogic.h"
#import "TEDataProvider.h"
#import "TELocationList.h"
@interface TELocationListLogic ()
@property (nonatomic, strong) id<TEDataProvider>    dataProvider;
@property (nonatomic, strong) TELocationList        *locationList;
@end
@implementation TELocationListLogic

/**
 Initialize this class utilizing the given data provider and delegate
 
 @param dataProvider data provider to talk to API
 @param delegate     callback delegate
 @return an instance of TELocationListLogic
 */
-(instancetype) initWithDataProvider:(id<TEDataProvider>) dataProvider delegate:(id<TELocationListLogicDelegate>) delegate{
    self = [super init];
    if (self) {
        self.dataProvider = dataProvider;
        self.delegate = delegate;
    }
    return self;
}

/**
 Start loading all available locations from backend
 */
-(void) loadAllLocations{
    [self.dataProvider loadAllLocationSuccess:^(TELocationList *result) {
        self.locationList = result;
        [self.delegate locationListDidUpdate];
    } fail:^(NSError *error) {
        [self.delegate locationListLogicDidEncounterError:error];
    }];
}

/**
 Get number of location to show to user
 
 @return number of location to show to user
 */
-(NSInteger) numberOfLocationsToShow{
    return [self.locationList numberOfLocations];
}

/**
 Get the location to display to user at an index
 
 @param index index of requested location
 @return the location to show at an index
 */
-(TELocation*) locationToShowAtIndex:(NSInteger) index{
    return [self.locationList locationAtIndex:index];
}
@end
