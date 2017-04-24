//
//  TEProfile.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"

@interface TEProfile : TEBaseModel
@property (nonatomic, copy) NSNumber    *profileId;
@property (nonatomic, copy) NSNumber    *rating;
@property (nonatomic, copy) NSNumber    *locationId;
@property (nonatomic, copy) NSString    *firstName;
@property (nonatomic, copy) NSString    *avatarMiniUrl;
@property (nonatomic, copy) NSString    *profileDescription;


/**
 Check if this profile is same as another one

 @param otherProfile the profile to compare to
 @return YES if same profile id, NO otherwise.
 */
-(BOOL) isSameProfileAs:(TEProfile*) otherProfile;
@end
