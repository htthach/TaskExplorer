//
//  TELocationDetailViewController.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TEDataProvider;
@class TELocation;

@interface TELocationDetailViewController : UIViewController
/**
 Factory method to return an instance of this view controller utilizing the given data provider
 
 @param dataProvider data provider to talk to API
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
+(instancetype) viewControllerWithDataProvider:(id<TEDataProvider>) dataProvider location:(TELocation*) location;
@end
