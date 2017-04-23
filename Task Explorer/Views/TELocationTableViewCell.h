//
//  TELocationTableViewCell.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TELocation;
@interface TELocationTableViewCell : UITableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TELocationTableViewCell
 */
+ (UINib *)nib;


/**
 Default height for this cell. Used for cell height estimation only.

 @return Default height for this cell. Used for cell height estimation
 */
+(CGFloat) defaultHeight;

/**
 Display a location in this cell

 @param location the location to display
 */
-(void) showLocation:(TELocation*) location;
@end
