//
//  TEMapTableViewCell.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 24/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEMapTableViewCell.h"
#import <MapKit/MapKit.h>
@interface TEMapTableViewCell ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
@implementation TEMapTableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEMapTableViewCell
 */
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([TEMapTableViewCell class]) bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mapView.layer.cornerRadius = 6;
    self.mapView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 Show a coordinate (latitude and longitude) in the map of this cell
 
 @param coordinate coordinate to show
 
 */
-(void) showCoordinate:(CLLocationCoordinate2D) coordinate{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (coordinate, 2000, 2000);
    [self.mapView setRegion:region animated:NO];
}
@end
