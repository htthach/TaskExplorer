//
//  TELocationTableViewCell.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationTableViewCell.h"
#import "TEUITheme.h"
#import "TELocation.h"
@interface TELocationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
@implementation TELocationTableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TELocationTableViewCell
 */
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([TELocationTableViewCell class]) bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.textColor = [TEUITheme primaryColorDark];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
    self.nameLabel.backgroundColor = [TEUITheme primaryColorLight];
    self.nameLabel.layer.cornerRadius = 6;
    self.nameLabel.clipsToBounds = YES;
}


/**
 Default height for this cell. Used for cell height estimation
 
 @return Default height for this cell. Used for cell height estimation
 */
+(CGFloat) defaultHeight{
    return 80;
}

/**
 Display a location in this cell
 
 @param location the location to display
 */
-(void) showLocation:(TELocation*) location{
    [self.nameLabel setText:location.displayName];
}
@end
