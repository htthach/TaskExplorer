//
//  TELocationDetailViewController.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationDetailViewController.h"
#import "TELocationDetailLogic.h"
#import "TEHelper.h"
#import "TEMapTableViewCell.h"
#import "TEProfileTableViewCell.h"
#import "TEActivityTableViewCell.h"
#import "TELocation.h"
#import "TEUITheme.h"
static NSString * const TEMapTableViewCellIdentifier = @"TEMapTableViewCellIdentifier";
static NSString * const TEProfileTableViewCellIdentifier = @"TEProfileTableViewCellIdentifier";
static NSString * const TEActivityTableViewCellIdentifier = @"TEActivityTableViewCellIdentifier";
static NSString * const TETableViewSectionHeaderViewIdentifier = @"TETableViewSectionHeaderViewIdentifier";

//If we want more control on biz logic with sections, it's better if we create section control in logic with dynamic section construction
//for now, do simple section
static int const TE_MAP_SECTION_INDEX       = 0;
static int const TE_WORKER_SECTION_INDEX    = 1;
static int const TE_ACTIVITY_SECTION_INDEX  = 2;
static int const TE_TOTAL_SECTION_COUNT     = 3;

@interface TELocationDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TELocationDetailLogicDelegate>
@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) id<TEImageProvider>       imageProvider;
@property (nonatomic, strong) TELocationDetailLogic     *locationLogic;

@end

@implementation TELocationDetailViewController

/**
 Factory method to return an instance of this view controller utilizing the given data & image provider
 
 @param dataProvider data provider to talk to API
 @param imageProvider image provider to download image from api
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
+(instancetype) viewControllerWithDataProvider:(id<TEDataProvider>) dataProvider
                                 imageProvider:(id<TEImageProvider>) imageProvider
                                      location:(TELocation*) location{
    return [[TELocationDetailViewController alloc] initWithDataProvider:dataProvider
                                                          imageProvider:imageProvider
                                                               location:location];
}

/**
 Initialize with basic location list logic
 
 @param dataProvider data provider to talk to API
 @param imageProvider image provider to download image from api
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
-(instancetype)initWithDataProvider:(id<TEDataProvider>) dataProvider
                      imageProvider:(id<TEImageProvider>) imageProvider
                           location:(TELocation*) location{
    self = [super init];
    if (self) {
        self.locationLogic = [[TELocationDetailLogic alloc] initWithDataProvider:dataProvider delegate:self location:location];
        self.imageProvider = imageProvider;
    }
    return self;
}
#pragma mark - view life cycle
-(void)loadView{
    //create a basic view with a UICollectionView and a tag selection banner as subview
    UIView *view = [UIView new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [view addSubview:self.tableView];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = self.locationLogic.location.displayName;
    [self setupConstraints];
    [self setupTableView];
    
    [self.locationLogic loadLocationDetail];
}
#pragma mark - view setup helper
-(void) setupConstraints{
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"tableView":self.tableView}]
     ];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"tableView":self.tableView}]
     ];
}

-(void) setupTableView{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[TEMapTableViewCell nib] forCellReuseIdentifier:TEMapTableViewCellIdentifier];
    [self.tableView registerNib:[TEProfileTableViewCell nib] forCellReuseIdentifier:TEProfileTableViewCellIdentifier];
    [self.tableView registerNib:[TEActivityTableViewCell nib] forCellReuseIdentifier:TEActivityTableViewCellIdentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:TETableViewSectionHeaderViewIdentifier];
}
#pragma mark - functional methods
-(NSString*) nameForSection:(NSInteger) section{
    if (section == TE_MAP_SECTION_INDEX) {
        return NSLocalizedString(@"Map", @"Map");
    }
    if (section == TE_WORKER_SECTION_INDEX) {
        return NSLocalizedString(@"Top Runners", @"Top Runners");
    }
    if (section == TE_ACTIVITY_SECTION_INDEX) {
        return NSLocalizedString(@"Recent Activities", @"Recent Activities");
    }
    return @"";
}
#pragma mark - TELocationDetailLogicDelegate
-(void)locationDetailDidUpdateWorkerAtIndex:(NSInteger)workerIndex{
    [self.tableView reloadData];
    return;
    [UIView performWithoutAnimation:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:workerIndex inSection:TE_WORKER_SECTION_INDEX];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
-(void)locationDetailDidUpdateActivityAtIndex:(NSInteger)activityIndex{
    [self.tableView reloadData];
    return;
    [UIView performWithoutAnimation:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:activityIndex inSection:TE_ACTIVITY_SECTION_INDEX];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
-(void)locationDetailLogicDidEncounterError:(NSError *)error{
    [TEHelper showError:error inViewController:self];
}
#pragma mark - table view delegate

#pragma mark - table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TE_TOTAL_SECTION_COUNT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == TE_MAP_SECTION_INDEX) {
        return 1; //only one row for map
    }
    if (section == TE_WORKER_SECTION_INDEX) {
        return [self.locationLogic numberOfWorkerToShow];
    }
    if (section == TE_ACTIVITY_SECTION_INDEX) {
        return [self.locationLogic numberOfActivityToShow];
    }
    
    //not recognized
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == TE_MAP_SECTION_INDEX) {
        return [tableView dequeueReusableCellWithIdentifier:TEMapTableViewCellIdentifier forIndexPath:indexPath];
    }
    if (indexPath.section == TE_WORKER_SECTION_INDEX) {
        TEProfileTableViewCell *profileCell = [tableView dequeueReusableCellWithIdentifier:TEProfileTableViewCellIdentifier forIndexPath:indexPath];
        [profileCell showProfile:[self.locationLogic workerProfileToShowAtIndex:indexPath.row] withImageProvider:self.imageProvider];
         return profileCell;
    }
    if (indexPath.section == TE_ACTIVITY_SECTION_INDEX) {
        TEActivityTableViewCell *activityCell = [tableView dequeueReusableCellWithIdentifier:TEActivityTableViewCellIdentifier forIndexPath:indexPath];
        [activityCell showActivity:[self.locationLogic activityToShowAtIndex:indexPath.row] withImageProvider:self.imageProvider];
        return activityCell;
    }
    
    //not recognized
    return [UITableViewCell new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
//for simplicity just return a label
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TETableViewSectionHeaderViewIdentifier];
    sectionHeaderView.textLabel.text = [self nameForSection:section];
    sectionHeaderView.textLabel.textColor = [TEUITheme primaryColorDark];
    sectionHeaderView.textLabel.font = [UIFont boldSystemFontOfSize:20];
    return sectionHeaderView;
}
@end
