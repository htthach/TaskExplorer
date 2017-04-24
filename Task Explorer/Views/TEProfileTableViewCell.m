//
//  TEProfileTableViewCell.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEProfileTableViewCell.h"
#import "TEProfile.h"
#import "TEImageProvider.h"
#import "TEHelper.h"

@interface TEProfileTableViewCell ()
@property (nonatomic, strong) TEProfile *currentProfile;
@end
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

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.profileImageView setImage:[TEHelper imagePlaceholder]];
    self.profileDescriptionLabel.text = @"";
}

/**
 Display a profile in this cell. Use the given image provider to load image if any
 
 @param profile profile to display
 @param imageProvider image provider to download image from api
 */
-(void) showProfile:(TEProfile*) profile
  withImageProvider:(id<TEImageProvider>) imageProvider{
    self.currentProfile = profile;
    //update description
    self.profileDescriptionLabel.text = [self descriptionTextForProfile:profile];
    //download image
    [imageProvider downloadImageForEndpoint:profile.avatarMiniUrl success:^(UIImage *image) {
        if ([profile isSameProfileAs:self.currentProfile]) {
            //still showing the same profile in this cell
            [self.profileImageView setImage:image];
        }
    } fail:^(NSError *error) {
        //leave blank with placeholder
    }];
}


/**
 Create a simple description of a profile

 @param profile profile to describe
 @return simple description of a profile
 */
-(NSString*) descriptionTextForProfile:(TEProfile*) profile{
    return [NSString stringWithFormat:@"%@:%@\n%@:%@\n%@:%@",
            NSLocalizedString(@"Name", @"Name"), profile.firstName?:@"-",
            NSLocalizedString(@"Rating", @"Rating"), profile.rating?:@"-",
            NSLocalizedString(@"Description", @"Description"), profile.profileDescription?:@"-"];
}
@end
