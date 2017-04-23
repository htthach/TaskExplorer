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

static NSString * const TEMapTableViewCellIdentifier = @"TEMapTableViewCellIdentifier";
static NSString * const TEProfileTableViewCellIdentifier = @"TEProfileTableViewCellIdentifier";
static NSString * const TEActivityTableViewCellIdentifier = @"TEActivityTableViewCellIdentifier";

//If we want more control on biz logic with sections, it's better if we create section control in logic with dynamic section construction
//for now, do simple section
static int const TE_MAP_SECTION_INDEX       = 0;
static int const TE_WORKER_SECTION_INDEX    = 1;
static int const TE_ACTIVITY_SECTION_INDEX  = 2;
static int const TE_TOTAL_SECTION_COUNT     = 3;

@interface TELocationDetailViewController ()<UITableViewDelegate, UITableViewDataSource, TELocationDetailLogicDelegate>
@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) TELocationDetailLogic     *locationLogic;

@end

@implementation TELocationDetailViewController

/**
 Factory method to return an instance of this view controller utilizing the given data provider
 
 @param dataProvider data provider to talk to API
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
+(instancetype) viewControllerWithDataProvider:(id<TEDataProvider>) dataProvider location:(TELocation*) location{
    return [[TELocationDetailViewController alloc] initWithDataProvider:dataProvider location:location];
}

/**
 Initialize with basic location list logic
 
 @param dataProvider data provider to talk to API
 @param location     initial location object
 @return an instance of TELocationDetailViewController
 */
-(instancetype)initWithDataProvider:(id<TEDataProvider>) dataProvider location:(TELocation*) location{
    self = [super init];
    if (self) {
        self.locationLogic = [[TELocationDetailLogic alloc] initWithDataProvider:dataProvider delegate:self location:location];
    }
    return self;
}
#pragma mark - view life cycle
-(void)loadView{
    //create a basic view with a UICollectionView and a tag selection banner as subview
    UIView *view = [UIView new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [view addSubview:self.tableView];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"LOCATIONS", @"LOCATIONS");
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[TEMapTableViewCell nib] forCellReuseIdentifier:TEMapTableViewCellIdentifier];
    [self.tableView registerNib:[TEProfileTableViewCell nib] forCellReuseIdentifier:TEProfileTableViewCellIdentifier];
    [self.tableView registerNib:[TEActivityTableViewCell nib] forCellReuseIdentifier:TEActivityTableViewCellIdentifier];
}
#pragma mark - TELocationDetailLogicDelegate
-(void)locationDetailDidUpdateWorkerAtIndex:(NSInteger)workerIndex{
    
}
-(void)locationDetailDidUpdateActivityAtIndex:(NSInteger)activityIndex{
    
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
        return [tableView dequeueReusableCellWithIdentifier:TEProfileTableViewCellIdentifier forIndexPath:indexPath];
    }
    if (indexPath.section == TE_ACTIVITY_SECTION_INDEX) {
        return [tableView dequeueReusableCellWithIdentifier:TEActivityTableViewCellIdentifier forIndexPath:indexPath];
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

@end
