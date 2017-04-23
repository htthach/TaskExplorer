//
//  TELocationListViewController.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TELocationListViewController.h"
#import "TELocationTableViewCell.h"

static NSString * const TELocationTableViewCellIdentifier = @"TELocationTableViewCellIdentifier";

@interface TELocationListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView      *tableView;
@end

@implementation TELocationListViewController
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
    [self setupConstraints];
    [self setupTableView];
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
    [self.tableView registerNib:[TELocationTableViewCell nib] forCellReuseIdentifier:TELocationTableViewCellIdentifier];
}

#pragma mark - table view delegate

#pragma mark - table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
