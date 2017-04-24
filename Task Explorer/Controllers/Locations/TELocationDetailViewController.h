//
//  TELocationDetailViewController.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TEDataProvider;
@protocol TEImageProvider;
@class TELocation;

@interface TELocationDetailViewController : UIViewController
/**
 Factory method to return an instance of this view controller utilizing the given data & image provider
 
 @param dataProvider data provider to talk to API
 @param imageProvider image provider to download image from api
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
+(instancetype) viewControllerWithDataProvider:(id<TEDataProvider>) dataProvider
                                 imageProvider:(id<TEImageProvider>) imageProvider
                                      location:(TELocation*) location;
@end
