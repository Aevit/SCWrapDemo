//
//  SCActionSheetWrap.h
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SCCommon.h"
#import "UIActionSheet+SCHelper.h"

typedef void(^EventBlock)(id anything);

@interface SCActionSheetWrap : NSObject <UIActionSheetDelegate>

/**
 *  add a normal action
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  add a destructive action
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addDestructiveButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  add a cancel action
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addCancelButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  show actionsheet with title
 *
 *  @param title title
 */
- (void)showWithTitle:(NSString*)title;

@end
