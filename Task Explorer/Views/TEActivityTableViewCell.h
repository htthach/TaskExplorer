//
//  TEActivityTableViewCell.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 24/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TEActivity;
@protocol TEImageProvider;
@interface TEActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;


/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEActivityTableViewCell
 */
+ (UINib *)nib;


/**
 Display an activity in this cell

 @param activity activity to show
 @param imageProvider image provider to download image from api
 */
-(void) showActivity:(TEActivity*) activity withImageProvider:(id<TEImageProvider>) imageProvider;
@end
