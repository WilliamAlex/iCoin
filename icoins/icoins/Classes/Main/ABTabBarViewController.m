//
//  ABTabBarViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABTabBarViewController.h"
#import "ABNavigationViewController.h"


#import "ABWalletViewController.h"
#import "ABQuotesViewController.h"
#import "ABDiscoverViewController.h"
#import "ABProfileViewController.h"
#import "ABCreateViewController.h"

#import "ABTabBar.h"


@interface ABTabBarViewController ()<ABTabBarDeleagete>

@property (nonatomic, weak) UIButton *plusButton;
@end

@implementation ABTabBarViewController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {

    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = AdaptedFontSize(11);
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = AdaptedFontSize(11);
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpAllChildVc];
    
    // 创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    ABTabBar *tabbar = [[ABTabBar alloc] init];
    tabbar.createDelegate = self;
    
    // kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

- (void)setUpAllChildVc {

    ABWalletViewController *WalletVC = [[ABWalletViewController alloc] init];
    [self setUpOneChildVcWithVc:WalletVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"钱包"];
    
    ABQuotesViewController *QuotesVC = [[ABQuotesViewController alloc] init];
    [self setUpOneChildVcWithVc:QuotesVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"行情"];
    
    ABDiscoverViewController *DisoverVC = [[ABDiscoverViewController alloc] init];
    [self setUpOneChildVcWithVc:DisoverVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"发现"];
    
    ABProfileViewController *ProfileVC = [[ABProfileViewController alloc] init];
    [self setUpOneChildVcWithVc:ProfileVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    ABNavigationViewController *nav = [[ABNavigationViewController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarCreateWalletOnClicked:(ABTabBar *)tabBar {
    
//    // 创建按钮
//    UIButton *creatBtn = [UIButton buttonWithBackImage:nil image:nil title:@"创建钱包" target:self action:@selector(creatAWallet)];
//    [creatBtn setBackgroundColor:[UIColor whiteColor]];
//    [creatBtn setTitleColor:[UIColor colorWithHexString:@"414e5f"] forState:UIControlStateNormal];
//    creatBtn.titleLabel.font = AdaptedFontSize(12);
//    creatBtn.layer.cornerRadius = 32;
//    creatBtn.clipsToBounds = YES;
//    [keyWindow addSubview:creatBtn];
//    [creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(keyWindow.mas_centerX).offset(AdaptedWidth(-15));
//        make.bottom.equalTo(keyWindow.mas_bottom).offset(AdaptedHeight(71));
//        make.size.mas_equalTo(CGSizeMake(64, 64));
//    }];
//    
//    // 导入按钮
//    UIButton *insertBtn = [UIButton buttonWithBackImage:nil image:nil title:@"导入钱包" target:self action:@selector(insertAWallet)];
//    [insertBtn setBackgroundColor:[UIColor whiteColor]];
//    [insertBtn setTitleColor:[UIColor colorWithHexString:@"414e5f"] forState:UIControlStateNormal];
//    insertBtn.titleLabel.font = AdaptedFontSize(12);
//    insertBtn.layer.cornerRadius = 32;
//    insertBtn.clipsToBounds = YES;
//    [keyWindow addSubview:insertBtn];
//    [insertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(keyWindow.mas_centerX).offset(AdaptedWidth(15));
//        make.bottom.equalTo(creatBtn.mas_bottom);
//        make.size.mas_equalTo(CGSizeMake(64, 64));
//    }];
//    
//    
//    //使用弹簧动画效果实现头像的位移
//    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:2 options:UIViewAnimationOptionCurveLinear animations:^{
//        
//        
////        [tabBar.plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_click"] forState:UIControlStateNormal];
//        creatBtn.transform = CGAffineTransformTranslate(creatBtn.transform, 0, AdaptedHeight(kTransform));
//        insertBtn.transform = CGAffineTransformTranslate(insertBtn.transform, 0, AdaptedHeight(kTransform));
//    } completion:^(BOOL finished) {
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
//        [UIView commitAnimations];
//    }];
    
    
}
//
//- (void)creatAWallet {
//
//    NSLog(@"创建钱包");
//}
//
//- (void)insertAWallet {
//    
//    NSLog(@"导入钱包");
//}

@end















