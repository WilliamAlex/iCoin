//
//  ABCoinViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABCoinViewController.h"
#import "ABManagerWalletsViewCell.h"


@interface ABCoinViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ABCoinViewController


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        CGRect frame = CGRectMake(AdaptedWidth(15), AdaptedHeight(15), ABScreenWidth - AdaptedWidth(30), ABScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = AdaptedHeight(100);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABManagerWalletsViewCell class]) bundle:nil] forCellReuseIdentifier:@"MANAGERWALLET"];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ABManagerWalletsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MANAGERWALLET"];
    cell.type = kABCoinOfETHType;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

@end









