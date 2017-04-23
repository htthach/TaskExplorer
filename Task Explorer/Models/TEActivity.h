//
//  TEActivity.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"

@interface TEActivity : TEBaseModel
@property (nonatomic, copy) NSNumber    *taskId;
@property (nonatomic, copy) NSNumber    *profileId;

@property (nonatomic, copy) NSString    *message;
@property (nonatomic, copy) NSString    *createdAt;
@property (nonatomic, copy) NSString    *event;
@end
