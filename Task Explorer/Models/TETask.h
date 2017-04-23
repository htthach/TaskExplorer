//
//  TETask.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"

@interface TETask : TEBaseModel
@property (nonatomic, copy) NSNumber    *taskId;
@property (nonatomic, copy) NSNumber    *posterId;
@property (nonatomic, copy) NSNumber    *workerId;
@property (nonatomic, copy) NSString    *taskDescription;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *state;
@end
