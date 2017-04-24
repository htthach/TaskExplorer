//
//  TEActivityTableViewCell.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 24/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEActivityTableViewCell.h"
#import "TEImageProvider.h"
#import "TEHelper.h"
#import "TEActivity.h"
#import "TEProfile.h"
#import "TETask.h"

@interface TEActivityTableViewCell()
@property (nonatomic, strong) TEActivity *currentActivity;
@end
@implementation TEActivityTableViewCell
/**
 *  Convenient method to return the nib of this cell class in main bundle
 *
 *  @return the nib of TEActivityTableViewCell
 */
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([TEActivityTableViewCell class]) bundle:nil];
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
    self.activityDescriptionLabel.text = @"";
}

/**
 Display an activity in this cell
 
 @param activity activity to show
 @param imageProvider image provider to download image from api
 */
-(void) showActivity:(TEActivity*) activity withImageProvider:(id<TEImageProvider>) imageProvider{
    self.currentActivity = activity;
    //update description
    self.activityDescriptionLabel.text = [self descriptionTextForActivity:activity];
    //download image
    [imageProvider downloadImageForEndpoint:activity.profile.avatarMiniUrl success:^(UIImage *image) {
        if ([activity.profile isSameProfileAs:self.currentActivity.profile]) {
            //still showing the same profile inside the activity in this cell
            [self.profileImageView setImage:image];
        }
    } fail:^(NSError *error) {
        //leave blank with placeholder
    }];
}

/**
 Create a simple description of an activity
 
 @param activity activity to describe
 @return simple description of an activity
 */
-(NSString*) descriptionTextForActivity:(TEActivity*) activity{
    return [NSString stringWithFormat:@"%@:%@\n%@:%@",
            NSLocalizedString(@"Description", @"Description"), [activity populatedActivityMessage]?:@"-",
            NSLocalizedString(@"Type", @"Type"), activity.event?:@"-"
            ];
}
@end