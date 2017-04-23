//
//  TEProfileTableViewCell.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEProfileTableViewCell.h"

@implementation TEProfileTableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEProfileTableViewCell
 */
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([TEProfileTableViewCell class]) bundle:nil];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
