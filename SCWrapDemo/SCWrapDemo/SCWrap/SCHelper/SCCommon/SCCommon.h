//
//  SCCommon.h
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WEAKSELF_WRAP           __weak __typeof(&*self)weakSelf = self;
#define SCWrapLocalization      @"SCWrapLocalization"
#define WrapLocalization(key)   NSLocalizedStringFromTable(key, SCWrapLocalization, nil)
#define WRAP_SYSTEM_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

@interface SCCommon : NSObject

/**
 *  find the topest presenting controller
 *  (the result maybe a navigationController, a tabbarController or a normal controller)
 *
 *  @return a navigationController, a tabbarController or a normal controller
 */
+ (UIViewController *)getTopPresentedViewController;

/**
 *  find the topest controller
 *  (if the result is a navigationController or tabbarController, then find the topest controller of them)
 *
 *  @return a normal controller
 */
+ (UIViewController *)getTopViewController;

@end
