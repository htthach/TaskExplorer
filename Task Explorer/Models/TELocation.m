//
//  TELocation.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocation.h"

@implementation TELocation
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
@end
