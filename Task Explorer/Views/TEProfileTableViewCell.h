//
//  TEProfileTableViewCell.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TEProfile;
@protocol TEImageProvider;
@interface TEProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileDescriptionLabel;

/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEProfileTableViewCell
 */
+ (UINib *)nib;


/**
 Display a profile in this cell. Use the given image provider to load image if any

 @param profile profile to display
 @param imageProvider image provider to download image from api
 */
-(void) showProfile:(TEProfile*) profile withImageProvider:(id<TEImageProvider>) imageProvider;
@end
