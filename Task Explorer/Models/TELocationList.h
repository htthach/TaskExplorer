//
//  TELocationList.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEBaseModel.h"
@class TELocation;

@interface TELocationList : TEBaseModel
@property (nonatomic, strong) NSArray <TELocation*> *locations;
@end
