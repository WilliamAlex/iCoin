//
//  ABQuotesViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABQuotesViewController.h"
#import "ABQuotesViewCell.h"
#import "ABQuotesHeadView.h"


@interface ABQuotesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


static NSString *QUOTESCELLID = @"QUOTESCELLID";
@implementation ABQuotesViewController

- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ABScreenWidth, ABScreenHeight-AdaptedHeight(100)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"121921"];
        _tableView.rowHeight = AdaptedHeight(100);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
}


- (void)setUpNav {

    // titleView
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"行情"];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"121921"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"121921"]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"19232e"]]];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ABQuotesViewCell class] forCellReuseIdentifier:QUOTESCELLID];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QUOTESCELLID forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ABQuotesHeadView *headView =[[ABQuotesHeadView alloc] init];
    headView.frame = self.tableView.tableHeaderView.bounds;
    self.tableView.tableHeaderView = headView;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  AdaptedHeight(50);
}


@end
