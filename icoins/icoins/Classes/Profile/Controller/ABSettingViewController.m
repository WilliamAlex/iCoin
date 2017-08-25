//
//  ABSettingViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABSettingViewController.h"
#import "ABSettingViewCell.h"


@interface ABSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups1;
@property (nonatomic, strong) NSArray *groups2;
@end

@implementation ABSettingViewController


- (UITableView *)tableView {

    if (!_tableView) {
        
        CGRect frame = CGRectMake(AdaptedWidth(15), AdaptedHeight(15), ABScreenWidth - AdaptedWidth(30), ABScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = AdaptedHeight(50);
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
}

- (void)setUpNav {

    // title
    self.navigationItem.title = @"";
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"设置"];
    self.navigationItem.titleView = titleLabel;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"icon_return" target:self action:@selector(back)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABSettingViewCell class]) bundle:nil] forCellReuseIdentifier:@"SETTINGCELL"];
    self.groups1 = @[@"简体中文", @"English"];
    self.groups2 = @[@"手势密码"];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.groups1.count;
    }
    
    return self.groups2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ABSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELL"];
    cell.showBottomLine = indexPath.row == self.groups1.count-1 ? NO : YES;
    if (indexPath.section == 0) {
    
        cell.title.text = self.groups1[indexPath.row];
    } else {
    
        cell.title.text = self.groups2[indexPath.row];
        cell.lineView.hidden = YES;
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.00001;
}




- (void)back {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
