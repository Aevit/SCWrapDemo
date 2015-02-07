//
//  SCImagePickerWrap.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "SCImagePickerWrap.h"

@interface SCImagePickerWrap ()

@end

@implementation SCImagePickerWrap

/**
 *  init
 *
 *  @param parent the delegate of the imagePickerController
 *
 *  @return self
 */
- (id)initWithParent:(id)parent {
    self = [super init];
    if (self) {
        _parent = parent;
        _allowsEditing = NO;
        [self buildSCActionSheetWrap];
    }
    return self;
}

- (void)buildSCActionSheetWrap {
    if (!_asWrap) {
        SCActionSheetWrap *aWrap = [[SCActionSheetWrap alloc] init];
        self.asWrap = aWrap;
    }
}

- (void)dealloc {
    self.asWrap = nil;
    self.parent = nil;
    self.pickMultiImagesBlock = nil;
}

#pragma mark - block
/**
 *  if you want to select multi photos, call this method to present a controller for user to multi select photos
 *
 *  @param block present a controller for multi select photos
 */
- (void)buildPickMultiPhotosBlock:(PickMultiImagesBlock)block {
    self.pickMultiImagesBlock = block;
}

#pragma mark - show system camera and album
/**
 *  show system camera and album，will show three actions: camera, local album and cancel
 */
- (void)showMenuWithSystemCameraAndAlbum {
    [self buildSCActionSheetWrap];
    WEAKSELF_WRAP
    [_asWrap addButtonTitle:WrapLocalization(@"Camera") eventBlock:^(id anything) {
        [weakSelf showImagePicker:UIImagePickerControllerSourceTypeCamera];
    }];
    [_asWrap addButtonTitle:WrapLocalization(@"Local album") eventBlock:^(id anything) {
        [weakSelf showImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    [_asWrap addCancelButtonTitle:WrapLocalization(@"Cancel") eventBlock:^(id anything) {
        ;
    }];
    [_asWrap showWithTitle:WrapLocalization(@"Please choose")];
}

#pragma mark - show only a type
/**
 *  show imagePicker with UIImagePickerControllerSourceType
 *
 *  @param sourceTye UIImagePickerControllerSourceType
 */
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceTye {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = _parent;
    picker.allowsEditing = _allowsEditing;
    if (sourceTye == UIImagePickerControllerSourceTypeCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            UIViewController *con = [SCCommon getTopPresentedViewController];
            [con presentViewController:picker animated:YES completion:^{
            }];
            picker = nil;
        } else {
            UIViewController *con = [SCCommon getTopPresentedViewController];
            [con presentViewController:picker animated:YES completion:^{
            }];
            picker = nil;
        }
    } else {
        if (_pickMultiImagesBlock) {
            _pickMultiImagesBlock(nil);
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        UIViewController *con = [SCCommon getTopPresentedViewController];
        [con presentViewController:picker animated:YES completion:^{
        }];
        picker = nil;
    }
}

@end
