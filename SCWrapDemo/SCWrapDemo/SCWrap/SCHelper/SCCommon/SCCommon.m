//
//  SCCommon.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "SCCommon.h"
#import <UIKit/UIKit.h>

@implementation SCCommon

/**
 *  find the topest presenting controller 
 *  (the result maybe a navigationController, a tabbarController or a normal controller)
 *
 *  @return a navigationController, a tabbarController or a normal controller
 */
+ (UIViewController *)getTopPresentedViewController {
    
    UIViewController *topViewController = [[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController];
    
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

/**
 *  find the topest controller
 *  (if the result is a navigationController or tabbarController, then find the topest controller of them)
 *
 *  @return a normal controller
 */
+ (UIViewController *)getTopViewController {
    
    UIViewController *topViewController = [[[UIApplication sharedApplication].windows objectAtIndex:0] rootViewController];
    
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)topViewController;
        topViewController = [nav.viewControllers lastObject];
    }
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController*)topViewController;
        topViewController = tab.selectedViewController;
    }
    
    return topViewController;
}

@end
