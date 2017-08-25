//
//  ABProfileViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABProfileViewController.h"
#import "ABProfileViewCell.h"
#import "ABRecordViewController.h"
#import "ABSettingViewController.h"
#import "ABAboutUsViewController.h"
#import "ABManagerWalletsViewController.h"

@interface ABProfileViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) UIView *walletInfoView;

// tableView
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ABProfileViewController



- (NSArray *)group {

    if (_group == nil) {
        
        TableViewCellItem *item1 = [TableViewCellItemArrow settingItemWithIcon:@"icon_jiaoyijilu" andTitle:@"交易记录"];
        TableViewCellItem *item2 = [TableViewCellItemArrow settingItemWithIcon:@"icon_shoukuanren" andTitle:@"收款人"];
        TableViewCellItem *item3 = [TableViewCellItemArrow settingItemWithIcon:@"icon_shezhi" andTitle:@"设置"];
        TableViewCellItem *item4 = [TableViewCellItemArrow settingItemWithIcon:@"icon_women" andTitle:@"关于我们"];
        _group = @[item1, item2, item3, item4];
    }
    
    return _group;
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.walletInfoView.frame) + AdaptedHeight(15), ABScreenWidth, ABScreenHeight - navHight - 49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
        
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    [self setUpWalletinfoView];
}

- (void)setUpNav {

    // title
    self.navigationItem.title = @"";
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"我的"];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    // 设置导航条的背景颜色
    [self wg_setNavBarBarTintColor:[UIColor colorWithRed:28/255.0 green:40/255.0 blue:52/255.0 alpha:1.0]];
    
    // 将导航条的透明度设置为透明
    [self wg_setNavBarBackgroundAlpha:0];
}

- (void)setUpWalletinfoView {

    UIView *walletInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ABScreenWidth, AdaptedHeight(200))];
    walletInfoView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.view addSubview:walletInfoView];
    self.walletInfoView = walletInfoView;
    
    // 背景图片
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:walletInfoView.bounds];
    bgImg.image = [UIImage imageNamed:@"bg_me_Low poly"];
    [walletInfoView insertSubview:bgImg atIndex:0];
    
    // 钱包管理
    UILabel *walletLable = [UILabel labelWithFrame:CGRectZero textColor:@"ffffff" backgroundColor:nil textFont:18 textAlignment:NSTextAlignmentCenter text:@"管理钱包"];
    [walletInfoView addSubview:walletLable];
    [walletLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(walletInfoView.mas_centerX);
        make.bottom.equalTo(bgImg.mas_bottom).offset(AdaptedHeight(-30));
    }];
    
    // 钱包
    UIImageView *walletImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_women-1"]];
    walletImg.userInteractionEnabled = YES;
    [walletInfoView addSubview:walletImg];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cheakMyWallets:)];
    [walletImg addGestureRecognizer:tap];
    
    [walletImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(walletInfoView.mas_centerX);
        make.bottom.equalTo(walletLable.mas_top).offset(AdaptedHeight(-10));
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CELLID = @"CELLID";
    ABProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (cell == nil) {
        
        cell = [[ABProfileViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELLID];
    }
    cell.item = self.group[indexPath.row];
    
    // 设置cell的高亮效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  
    switch (indexPath.row) {
        case 0:
        {
            ABRecordViewController *recordVc = [[ABRecordViewController alloc] init];
            [self.navigationController pushViewController:recordVc animated:YES];
        }
            break;
            
        case 2:
        {
            ABSettingViewController *settingVc = [[ABSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVc animated:YES];
        }
            break;
            
        case 3:
        {
            ABAboutUsViewController *aboutVc = [[ABAboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)cheakMyWallets:(UITapGestureRecognizer *)sender {

    ABManagerWalletsViewController *manager = [[ABManagerWalletsViewController alloc] init];
    [self.navigationController pushViewController:manager animated:YES];
}



@end
