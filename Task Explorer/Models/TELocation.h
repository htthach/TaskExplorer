//
//  TELocation.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"
@class TETask;

@interface TELocation : TEBaseModel
@property (nonatomic, copy) NSNumber    *locationId;
@property (nonatomic, copy) NSNumber    *latitude;
@property (nonatomic, copy) NSNumber    *longitude;
@property (nonatomic, copy) NSNumber    *workerCount;

@property (nonatomic, copy) NSString    *displayName;

@property (nonatomic, strong) NSArray <NSNumber*>   *workerId;
@property (nonatomic, strong) NSArray <TETask*>     *recentActivity;
@end
