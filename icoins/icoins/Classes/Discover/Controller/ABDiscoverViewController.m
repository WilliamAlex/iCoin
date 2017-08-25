//
//  ABDiscoverViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABDiscoverViewController.h"
#import "ABMenuView.h"
#import "ABArticleTableViewCell.h"

@interface ABDiscoverViewController ()<UIScrollViewDelegate, ABMenuViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ABDiscoverViewController

- (UIScrollView *)scrollView {

    if (!_scrollView) {
    
        // 添加UIScrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

- (UITableView *)tableView {

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ABScreenWidth, ABScreenHeight - AdaptedHeight(100)) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        
        [self.scrollView addSubview:_tableView];
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
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"发现"];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ABArticleTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ArticleCell"];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tableView.frame) + AdaptedHeight(100));
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ABArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 120;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%ld===============", indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    headView.frame = self.tableView.tableHeaderView.bounds;
    self.tableView.tableHeaderView = headView;
    
    ABMenuView *menuView = [[ABMenuView alloc] initWithFrame:CGRectMake(0, 0, ABScreenWidth, AdaptedHeight(194)) Arrange:3 Rank:2];
    menuView.titles = @[@"新手引导",@"区块链",@"联系我们",@"安全",@"常见问题"];
    menuView.icons = @[@"icon_Newbie-guide",@"icon_Block-chain",@"icon_Contact-us",@"icon_safe",@"icon_FAQ"];
    menuView.viewEdgeInsets = UIEdgeInsetsMake(AdaptedHeight(margin), AdaptedWidth(margin), AdaptedHeight(margin), AdaptedWidth(margin));  //四周边距
    menuView.interitemSpacing = AdaptedWidth(20);      //列距
    menuView.lineSpacing = AdaptedHeight(5);           //行距
    menuView.backgroundColor = [UIColor whiteColor]; //背景颜色
    menuView.delegate = self;
    [headView addSubview:menuView];
    
    UILabel *article = [UILabel labelWithFrame:CGRectZero textColor:@"333333" backgroundColor:nil textFont:15 textAlignment:NSTextAlignmentLeft text:@"推荐文章"];
    [headView addSubview:article];
    [article mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(menuView.mas_bottom);
        make.height.equalTo(@(50));
        make.left.equalTo(headView.mas_left).offset(AdaptedWidth(15));
    }];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return AdaptedHeight(244);
}


- (void)menuViewDidSelectedItemWithIndex:(NSInteger)index
{
    NSLog(@"%ld===============", index);
}








@end
