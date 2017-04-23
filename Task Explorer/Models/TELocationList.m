//
//  TELocationList.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationList.h"
#import "TELocation.h"

@implementation TELocationList

#pragma mark - overriding
/**
 Return the name of the property of type array that should be used when we initWithArray
 
 @return the name of the property of type array that should be used when we initWithArray
 */
-(NSString *)getArrayPropertyNameForArrayParsing{
    return @"locations";
}

/**
 if there is a property of type array, return the class of that array's elements
 
 @param arrayName name of that property
 @return class of the array's elements
 */
-(Class) getClassForArrayName:(NSString*) arrayName{
    if ([arrayName isEqualToString:@"locations"]) {
        return [TELocation class];
    }
    return [super getClassForArrayName:arrayName];
}

#pragma mark - public methods
/**
 Number of location in this list
 
 @return number of location in this list
 */
-(NSInteger) numberOfLocations{
    return [self.locations count];
}
/**
 Get the location at an index if within range.
 Return nil if out of range.
 
 @param index index of requested location
 @return a location at an index
 */
-(TELocation*) locationAtIndex:(NSInteger) index{
    if (index >= 0 && index < [self.locations count]) {
        return self.locations[index];
    }
    return nil;
}
@end
