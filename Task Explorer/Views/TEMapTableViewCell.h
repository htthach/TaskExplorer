//
//  TEMapTableViewCell.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 24/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
@interface TEMapTableViewCell : UITableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEMapTableViewCell
 */
+ (UINib *)nib;


/**
 Show a coordinate (latitude and longitude) in the map of this cell
 
 @param coordinate coordinate to show

 */
-(void) showCoordinate:(CLLocationCoordinate2D) coordinate;
@end
