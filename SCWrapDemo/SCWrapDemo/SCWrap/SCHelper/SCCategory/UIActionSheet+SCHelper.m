//
//  UIActionSheet+SCHelper.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "UIActionSheet+SCHelper.h"
#import "SCCommon.h"

@implementation UIActionSheet (SCHelper)

/**
 *  show in the tabbarController, navigationController or normal controller
 */
- (void)show {
    
    [self sizeToFit];
    
    UIViewController *topCon = [SCCommon getTopPresentedViewController];
    
    if ([topCon isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabCon = (UITabBarController*)topCon;
        [self showFromTabBar:tabCon.tabBar];
        
    } else if ([topCon isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController*)topCon;
        if (nav.viewControllers.count > 0) {
            UIViewController *con = (UIViewController*)[nav.viewControllers lastObject];
            [self showInView:con.view];
        } else {
            NSLog(@"empty nav");
        }
        
    } else if (topCon) {
        [self showInView:topCon.view];
    }
}

@end
