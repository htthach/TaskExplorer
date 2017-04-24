//
//  TEProfile.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEProfile.h"

@implementation TEProfile
/**
 Return the key map between json key vs this object property name. By default we set property name using camel case and JSON tag from server as snake case.
 Child class can override this if there is mismatch between object property name and json tag.
 
 @return the key map between json key vs this object property name
 */
-(NSMutableDictionary *)getKeyMap{
    NSMutableDictionary *keyMap = [super getKeyMap];
    [keyMap setObject:@"profileId" forKey:@"id"];
    [keyMap setObject:@"profileDescription" forKey:@"description"];
    return keyMap;
}

/**
 Check if this profile is same as another one
 
 @param otherProfile the profile to compare to
 @return YES if same profile id, NO otherwise.
 */
-(BOOL) isSameProfileAs:(TEProfile*) otherProfile{
    if (!otherProfile.profileId) {
        return NO;
    }
    
    return [self.profileId isEqualToNumber:otherProfile.profileId];
}
@end
