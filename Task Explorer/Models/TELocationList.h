//
//  TELocationList.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"
@class TELocation;

@interface TELocationList : TEBaseModel
@property (nonatomic, strong) NSArray <TELocation*> *locations;


/**
 Number of location in this list

 @return number of location in this list
 */
-(NSInteger) numberOfLocations;

/**
 Get the location at an index if within range. 
 Return nil if out of range.
 
 @param index index of requested location
 @return a location at an index
 */
-(TELocation*) locationAtIndex:(NSInteger) index;
@end
