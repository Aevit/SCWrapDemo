//
//  SCAlertWrap.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "SCAlertWrap.h"
#import "SCCommon.h"

@interface SCAlertWrap () 

@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertConForiOS8;

@property (nonatomic, strong) NSMutableDictionary *eventBlocksDict;



@end

@implementation SCAlertWrap

- (void)dealloc {
    self.alertView = nil;
    self.alertConForiOS8 = nil;
    self.eventBlocksDict = nil;
}

#pragma mark - add button index
- (void)addButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    
    if (WRAP_SYSTEM_VERSION < 8.0) {
        if (!_alertView) {
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.delegate = self;
            self.alertView = alert;
        }
        
        [_alertView addButtonWithTitle:title];
        
        if (!_eventBlocksDict) {
            _eventBlocksDict = [NSMutableDictionary dictionary];
        }
        if (eventBlock) {
            [_eventBlocksDict setObject:eventBlock forKey:@(_alertView.numberOfButtons - 1)];
        } else {
            [_eventBlocksDict setObject:@(-1) forKey:@(_alertView.numberOfButtons - 1)];
        }
        return;
    }
    
    if (!_alertConForiOS8) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        self.alertConForiOS8 = alertCon;
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        eventBlock(_alertConForiOS8);
    }];
    [_alertConForiOS8 addAction:action];
}

- (void)addCancelButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    if (WRAP_SYSTEM_VERSION < 8.0) {
        [self addButtonTitle:title eventBlock:eventBlock];
        _alertView.cancelButtonIndex  = _alertView.numberOfButtons - 1;
        return;
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        eventBlock(_alertConForiOS8);
    }];
    [_alertConForiOS8 addAction:action];
}

- (void)addTextFieldWithEventBlock:(TextFieldEventBlock)textFieldEventBlock {
    NSAssert(WRAP_SYSTEM_VERSION >= 8.0, @"current system version should be greater or equal to 8.0");
    if (WRAP_SYSTEM_VERSION < 8.0) {
        return;
    }
    if (!_alertConForiOS8) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        self.alertConForiOS8 = alertCon;
    }
    [_alertConForiOS8 addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textFieldEventBlock(textField);
    }];
}

- (void)addDestructiveButtonTitle:(NSString*)title eventBlock:(EventBlock)eventBlock {
    NSAssert(WRAP_SYSTEM_VERSION >= 8.0, @"current system version should be greater or equal to 8.0");
    if (WRAP_SYSTEM_VERSION < 8.0) {
        return;
    }
    if (!_alertConForiOS8) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        self.alertConForiOS8 = alertCon;
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        eventBlock(_alertConForiOS8);
    }];
    [_alertConForiOS8 addAction:action];
}

#pragma mark - show alert
- (void)showWithStyle:(UIAlertViewStyle)style title:(NSString*)title message:(NSString*)message {
    
    if (WRAP_SYSTEM_VERSION < 8.0) {
        if (_alertView) {
            _alertView.alertViewStyle = style;
            if (_alertView.cancelButtonIndex < 0) {
                [self addCancelButtonTitle:WrapLocalization(@"Cancel") eventBlock:^(id anything) {}];
            }
            if (title) {
                _alertView.title = title;
            }
            if (message) {
                _alertView.message = message;
            }
            [_alertView show];
        }
        return;
    }
    
    if (_alertConForiOS8) {
        if (title) {
            _alertView.title = title;
        }
        if (message) {
            _alertView.message = message;
        }
        [[SCCommon getTopPresentedViewController] presentViewController:_alertConForiOS8 animated:YES completion:^{
            ;
        }];
    }
}

- (void)showForiOS8WithTitle:(NSString*)title message:(NSString*)message {
    [self showWithStyle:-1 title:title message:message];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (_eventBlocksDict && _alertView) {
        if ([[_eventBlocksDict objectForKey:@(buttonIndex)] isKindOfClass:[NSNumber class]] && [[_eventBlocksDict objectForKey:@(buttonIndex)] intValue] == -1) {
            return;
        }
        EventBlock block = [_eventBlocksDict objectForKey:@(buttonIndex)];
        if (block) {
            block(_alertView);
        }
    }
}

@end
