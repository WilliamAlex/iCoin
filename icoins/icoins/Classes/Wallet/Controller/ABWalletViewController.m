//
//  ABWalletViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABWalletViewController.h"
#import "ABWalletCoinView.h"
#import "ABQRScanViewController.h"
#import "ABAddressViewController.h"

@interface ABWalletViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

// 币种View
@property (nonatomic, weak) ABWalletCoinView *coinView;

// 地址卡片数组
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, weak) ABNewPageFlowView *pageFlowView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation ABWalletViewController

- (NSMutableArray *)imageArray {
    
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIScrollView *)scrollView {

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    [self setUpAddressPageView];
    [self setUpCoinView];
}

- (void)setUpNav {

    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    // 钱包按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"header-1" target:self action:@selector(showLeftBTCView)];

    // 官方公告
    UIBarButtonItem *msg = [[UIBarButtonItem alloc] initWithImage:[UIImage wg_imageWithOriginalRender:@"header-3"] style:UIBarButtonItemStyleDone target:self action:@selector(checkMessageFromOfficial)];
    
    // 二维码
    UIBarButtonItem *qr = [[UIBarButtonItem alloc] initWithImage:[UIImage wg_imageWithOriginalRender:@"header-2"] style:UIBarButtonItemStyleDone target:self action:@selector(scanAddress)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:msg, qr, nil];
    
    // title
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, titleWidth, titleHight) textColor:@"ffffff" backgroundColor:nil textFont:18.0 textAlignment:NSTextAlignmentCenter text:@"钱包"];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
}

- (void)setUpAddressPageView {

    for (int index = 1; index < 7; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"a%d",index]];
        [self.imageArray addObject:image];
    }
    
    ABNewPageFlowView *pageFlowView = [[ABNewPageFlowView alloc] initWithFrame:CGRectMake(0, AdaptedHeight(margin), ABScreenWidth, AdaptedHeight(173))];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = NO;
    
    //初始化pageControl
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 32, ABScreenWidth, 8)];
//    pageFlowView.pageControl = pageControl;
//    [pageFlowView addSubview:pageControl];
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    [self.scrollView addSubview:pageFlowView];
    self.pageFlowView = pageFlowView;
    [pageFlowView reloadData];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(ABNewPageFlowView *)flowView {
    
    return CGSizeMake(ABScreenWidth - AdaptedWidth(60), AdaptedHeight(173));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(ABNewPageFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(ABNewPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    ABBannerSubView *bannerView = (ABBannerSubView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[ABBannerSubView alloc] initWithFrame:CGRectMake(0, 0, ABScreenWidth, AdaptedHeight(173))];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 10;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(ABNewPageFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

- (void)setUpCoinView {

    ABWalletCoinView *coinView1 = [[ABWalletCoinView alloc] init];
    coinView1.backgroundColor = [UIColor whiteColor];
    coinView1.frame = CGRectMake(0, CGRectGetMaxY(self.pageFlowView.frame) + AdaptedHeight(margin), ABScreenWidth, AdaptedHeight(88));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkAddress)];
    [coinView1 addGestureRecognizer:tap];
    [self.scrollView addSubview:coinView1];
    
    ABWalletCoinView *coinView2 = [[ABWalletCoinView alloc] init];
    coinView2.backgroundColor = [UIColor whiteColor];
    coinView2.frame = CGRectMake(0, CGRectGetMaxY(coinView1.frame) + AdaptedHeight(margin), ABScreenWidth, AdaptedHeight(88));
    [self.scrollView addSubview:coinView2];
    self.coinView = coinView2;
}

#pragma mark 事件
- (void)showLeftBTCView {

    [self.ab_sldeMenu showLeftViewControllerAnimated:true];
}

- (void)checkMessageFromOfficial {
    
    NSLog(@"查看官方公告");
}

- (void)scanAddress {
    
    ABQRScanViewController *qrVc = [[ABQRScanViewController alloc] init];
    [self.navigationController pushViewController:qrVc animated:YES];
}

- (void)checkAddress {

    ABAddressViewController *addressVc = [[ABAddressViewController alloc] init];
    [self.navigationController pushViewController:addressVc animated:YES];
    
}

@end



















