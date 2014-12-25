//
//  DemoViewController.h
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCWrapType) {
    SCActionSheetWrapType           = 0,
    SCImagePickerDefaultWrapType    = 1,
    SCImagePickerCustomWrapType     = 2,
    SCAlertWrapType                 = 3
};

@interface DemoViewController : UIViewController

@property (nonatomic, assign) SCWrapType type;

@end
