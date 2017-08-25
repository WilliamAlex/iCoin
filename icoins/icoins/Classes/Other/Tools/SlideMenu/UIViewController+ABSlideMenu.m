//
//  UIViewController+ABSlideMenu.m
//  icoins
//
//  Created by Alex Williams on 2017/8/19.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "UIViewController+ABSlideMenu.h"
#import "ABSlideMenuViewController.h"


@implementation UIViewController (ABSlideMenu)

- (ABSlideMenuViewController *)ab_sldeMenu {

    UIViewController *sldeMenu = self.parentViewController;
    while (sldeMenu) {
        
        if ([sldeMenu isKindOfClass:[ABSlideMenuViewController class]]) {
            return (ABSlideMenuViewController *)sldeMenu;
        } else if (sldeMenu.parentViewController && sldeMenu.parentViewController != sldeMenu) {
            sldeMenu = sldeMenu.parentViewController;
        } else {
            sldeMenu = nil;
        }
    }
    return nil;
}
    
@end
