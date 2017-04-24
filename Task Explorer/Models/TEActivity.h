//
//  TEActivity.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"
@class TETask;
@class TEProfile;

@interface TEActivity : TEBaseModel
@property (nonatomic, copy) NSNumber    *taskId;
@property (nonatomic, copy) NSNumber    *profileId;

@property (nonatomic, copy) NSString    *message;
@property (nonatomic, copy) NSString    *createdAt;
@property (nonatomic, copy) NSString    *event;

@property (nonatomic, strong) TETask    *task;
@property (nonatomic, strong) TEProfile *profile;


/**
 Message that was populated with proper info on task and profile

 @return Message that was populated with proper info on task and profile
 */
-(NSString*) populatedActivityMessage;

@end
