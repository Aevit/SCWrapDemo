//
//  SCActionSheetWrap.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "SCActionSheetWrap.h"

@interface SCActionSheetWrap ()

@property (nonatomic, strong) UIActionSheet *pickerMenuActioSheet;
@property (nonatomic, strong) NSMutableDictionary *eventBlocksDict;

@end

@implementation SCActionSheetWrap

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    self.pickerMenuActioSheet = nil;
    self.eventBlocksDict = nil;
}

#pragma mark - add button index
- (void)addButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    if (!_pickerMenuActioSheet) {
        UIActionSheet *as = [[UIActionSheet alloc] init];
        as.delegate = self;
        self.pickerMenuActioSheet = as;
    }
    [_pickerMenuActioSheet addButtonWithTitle:title];
    
    if (!_eventBlocksDict) {
        _eventBlocksDict = [NSMutableDictionary dictionary];
    }
    if (eventBlock) {
        [_eventBlocksDict setObject:eventBlock forKey:@(_pickerMenuActioSheet.numberOfButtons - 1)];
    } else {
        [_eventBlocksDict setObject:@(-1) forKey:@(_pickerMenuActioSheet.numberOfButtons - 1)];
    }
}

- (void)addDestructiveButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    [self addButtonTitle:title eventBlock:eventBlock];
    _pickerMenuActioSheet.destructiveButtonIndex = _pickerMenuActioSheet.numberOfButtons - 1;
}

- (void)addCancelButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    [self addButtonTitle:title eventBlock:eventBlock];
    _pickerMenuActioSheet.cancelButtonIndex = _pickerMenuActioSheet.numberOfButtons - 1;
}

- (void)showWithTitle:(NSString*)title {
    
    if (_pickerMenuActioSheet) {
        
        if (_pickerMenuActioSheet.cancelButtonIndex < 0) {
            [self addCancelButtonTitle:WrapLocalization(@"Cancel") eventBlock:^(id anything) {}];
        }
        if (title) {
            _pickerMenuActioSheet.title = title;
        }
        [_pickerMenuActioSheet show];
    }
}

#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (_eventBlocksDict && _pickerMenuActioSheet) {
        if ([[_eventBlocksDict objectForKey:@(buttonIndex)] isKindOfClass:[NSNumber class]] && [[_eventBlocksDict objectForKey:@(buttonIndex)] intValue] == -1) {
            return;
        }
        EventBlock block = [_eventBlocksDict objectForKey:@(buttonIndex)];
        if (block) {
            block(nil);
        }
    }
}

@end



