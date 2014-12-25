//
//  SCAlertWrap.h
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^EventBlock)(id anything);
typedef void(^TextFieldEventBlock)(UITextField *textField);

@interface SCAlertWrap : NSObject <UIAlertViewDelegate>

/**
 *  add a normal action
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  add a cancel action
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addCancelButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  add a textField action (for iOS8)
 *
 *  @param textFieldEventBlock event
 */
- (void)addTextFieldWithEventBlock:(TextFieldEventBlock)textFieldEventBlock;

/**
 *  add a destructive action (for iOS8)
 *
 *  @param title      title
 *  @param eventBlock event
 */
- (void)addDestructiveButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock;

/**
 *  show the alert
 *
 *  @param style  style
 *  @param title  title
 *  @param messag message
 */
- (void)showWithStyle:(UIAlertViewStyle)style title:(NSString*)title message:(NSString*)message;

/**
 *  show the alert for iOS8
 *
 *  @param title   title
 *  @param message message
 */
- (void)showForiOS8WithTitle:(NSString*)title message:(NSString*)message;

@end
