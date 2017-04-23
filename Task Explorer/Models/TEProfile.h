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

@end
