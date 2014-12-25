//
//  SCImagePickerWrap.h
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCActionSheetWrap.h"

typedef void(^PickMultiImagesBlock)(id anything);

@interface SCImagePickerWrap : NSObject <UIActionSheetDelegate>

/**
 *  the delegate of the imagePickerController
 */
@property (nonatomic, unsafe_unretained) id<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate> parent;

/**
 *  SCActionSheetWrap
 */
@property (nonatomic, strong) SCActionSheetWrap *asWrap;

/**
 *  if set to YES, will show a square crop. Default is NO.
 */
@property (nonatomic, assign) BOOL allowsEditing;

/**
 *  if you want to select multi photos, call this method to present a controller for user to multi select photos
 */
@property (nonatomic, copy) PickMultiImagesBlock pickMultiImagesBlock;

/**
 *  init
 *
 *  @param parent the delegate of the imagePickerController
 *
 *  @return self
 */
- (id)initWithParent:(id)parent;

/**
 *  if you want to select multi photos, call this method to present a controller for user to multi select photos
 *
 *  @param block present a controller for multi select photos
 */
- (void)buildPickMultiPhotosBlock:(PickMultiImagesBlock)block;

/**
 *  show system camera and album，will show three actions: camera, local album and cancel
 */
- (void)showMenuWithSystemCameraAndAlbum;

/**
 *  show imagePicker with UIImagePickerControllerSourceType
 *
 *  @param sourceTye UIImagePickerControllerSourceType
 */
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceTye;

@end
