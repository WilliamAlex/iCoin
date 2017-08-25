//
//  AppDelegate.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "AppDelegate.h"
#import "ABTabBarViewController.h"
#import "ABLeftMenuViewController.h"


@interface AppDelegate ()

@end

UIColor *MainNavBarColor = nil;
UIColor *MainViewColor = nil;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 线程休眠1秒
    [NSThread sleepForTimeInterval:1.0];
    
    // 设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 主视图
    ABTabBarViewController *tabBarVc = [[ABTabBarViewController alloc] init];
    
    // 左视图
    ABLeftMenuViewController *leftVc = [[ABLeftMenuViewController alloc] init];
    
    // 创建滑动菜单
    ABSlideMenuViewController *slideMenu = [[ABSlideMenuViewController alloc] initWithRootViewController:tabBarVc];
    
    // 设置左菜单
    slideMenu.leftViewController = leftVc;
    self.window.rootViewController = slideMenu;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setNavBarAppearence];
    
    return YES;
}

- (void)setNavBarAppearence {
    
    MainNavBarColor = [UIColor colorWithRed:28/255.0 green:40/255.0 blue:52/255.0 alpha:1];
    MainViewColor   = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    
    // 设置导航栏默认的背景颜色
    [UIColor wg_setDefaultNavBarBarTintColor:MainNavBarColor];
    
    // 设置导航栏所有按钮的默认颜色
    [UIColor wg_setDefaultNavBarTintColor:[UIColor whiteColor]];
    
    // 设置导航栏标题默认颜色
    [UIColor wg_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    
    // 统一设置状态栏样式
    [UIColor wg_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    // [UIColor wg_setDefaultNavBarShadowImageHidden:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
