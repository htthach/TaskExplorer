//
//  TEActivity.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEActivity.h"
#import "TEProfile.h"
#import "TETask.h"

static NSString * const TE_ACTIVITY_TEMPLATE_KEY_PROFILE_NAME = @"{profileName}";
static NSString * const TE_ACTIVITY_TEMPLATE_KEY_TASK_NAME = @"{taskName}";
@implementation TEActivity

/**
 Message that was populated with proper info on task and profile
 
 @return Message that was populated with proper info on task and profile
 */
-(NSString*) populatedActivityMessage{
    NSString *populatedMessage = [self.message stringByReplacingOccurrencesOfString:TE_ACTIVITY_TEMPLATE_KEY_PROFILE_NAME withString:self.profile.firstName?:@""];
    populatedMessage = [populatedMessage stringByReplacingOccurrencesOfString:TE_ACTIVITY_TEMPLATE_KEY_TASK_NAME withString:self.task.name?:@""];
    return populatedMessage;
}
@end
