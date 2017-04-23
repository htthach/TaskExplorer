//
//  TELocationListViewController.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationListViewController.h"
#import "TELocationTableViewCell.h"
#import "TELocationListLogic.h"
#import "TEHelper.h"
static NSString * const TELocationTableViewCellIdentifier = @"TELocationTableViewCellIdentifier";

@interface TELocationListViewController () <UITableViewDelegate, UITableViewDataSource, TELocationListLogicDelegate>
@property (nonatomic, strong) UITableView           *tableView;

@property (nonatomic, strong) TELocationListLogic   *listLogic;
@end

@implementation TELocationListViewController
/**
 Factory method to return an instance of this view controller utilizing the given data provider
 
 @param dataProvider data provider to talk to API
 @return an instance of TELocationListViewController
 */
+(instancetype) viewControllerWithDataProvider:(id<TEDataProvider>) dataProvider{
    return [[TELocationListViewController alloc] initWithDataProvider:dataProvider];
}

/**
 Initialize with basic location list logic
 
 @param dataProvider data provider to talk to API
 @return an instance of TELocationListViewController
 */
-(instancetype)initWithDataProvider:(id<TEDataProvider>) dataProvider{
    self = [super init];
    if (self) {
        self.listLogic = [[TELocationListLogic alloc] initWithDataProvider:dataProvider delegate:self];
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
    
    [self.listLogic loadAllLocations];
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
    [self.tableView registerNib:[TELocationTableViewCell nib] forCellReuseIdentifier:TELocationTableViewCellIdentifier];
}
#pragma mark - TELocationListLogicDelegate
-(void)locationListDidUpdate{
    [self.tableView reloadData];
}
-(void)locationListLogicDidEncounterError:(NSError *)error{
    [TEHelper showError:error inViewController:self];
}
#pragma mark - table view delegate

#pragma mark - table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listLogic numberOfLocationsToShow];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TELocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TELocationTableViewCellIdentifier forIndexPath:indexPath];
    [cell showLocation:[self.listLogic locationToShowAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TELocationTableViewCell defaultHeight];
}
@end
