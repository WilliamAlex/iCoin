//
//  ABAboutUsViewController.m
//  icoins
//
//  Created by williamalex on 2017/8/24.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABAboutUsViewController.h"
#import "ABAboutUsViewCell.h"



@interface ABAboutUsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ABAboutUsViewController

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
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"关于我们"];
    self.navigationItem.titleView = titleLabel;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"icon_return" target:self action:@selector(back)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABAboutUsViewCell class]) bundle:nil] forCellReuseIdentifier:@"ABOUTUSCELL"];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ABAboutUsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABOUTUSCELL"];
    switch (indexPath.section) {
        case 0:
        {
            cell.title.text = @"使用协议";
            cell.detialTitle.text = @"";
        }
            break;
            
        case 1:
        {
            cell.title.text = @"隐私条款";
            cell.detialTitle.text = @"";
        }
            break;
        case 2:
        {
            cell.title.text = @"隐私条款";
            cell.detialTitle.text = @"最新版V2.0";
        }
            break;
        default:
            break;
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
