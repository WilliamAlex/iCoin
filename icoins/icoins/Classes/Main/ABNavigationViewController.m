//
//  ABNavigationViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABNavigationViewController.h"

@interface ABNavigationViewController ()

@end

@implementation ABNavigationViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}



@end
