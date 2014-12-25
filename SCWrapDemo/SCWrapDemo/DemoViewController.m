//
//  DemoViewController.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "DemoViewController.h"
#import "SVProgressHUD.h"
#import "SCActionSheetWrap.h"
#import "SCImagePickerWrap.h"
#import "SCAlertWrap.h"

@interface DemoViewController ()

@property (nonatomic, strong) SCActionSheetWrap *asWrap;
@property (nonatomic, strong) SCImagePickerWrap *imagePickerWrap;
@property (nonatomic, strong) SCAlertWrap *alertWrap;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = (_type== 0 ? @"SCActionSheetWrap" : (_type == 1 ? @"SCImagePickerDefaultWrapType" : (_type == 2 ? @"SCImagePickerCustomWrapType" : (_type == 3 ? @"SCAlertWrap" : @"it is imposibble"))));
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:WrapLocalization(@"Done") style:UIBarButtonItemStyleDone target:self action:@selector(doneItemPressed:)];
    self.navigationItem.leftBarButtonItem = doneItem;
    
    [self addDemoText];
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBtn setTitle:@"tap me" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    showBtn.frame = CGRectMake(0, 0, 120, 40);
    showBtn.center = self.view.center;
    [showBtn addTarget:self action:@selector(showBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneItemPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)addDemoText {
    
    UITextView *aTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    aTextView.editable = NO;
    switch (_type) {
        case SCActionSheetWrapType:
        {
            aTextView.text = @"Demo Code:\n\nSCActionSheetWrap *aWrap = [[SCActionSheetWrap alloc] init];\n\
[aWrap addDestructiveButtonTitle:@\"Reset text\" eventBlock:^(id anything) {\n\
            [sender setTitle:@\"tap me\" forState:UIControlStateNormal];\n\
}];\n\
[aWrap addButtonTitle:@\"change text to \"Merry\" eventBlock:^(id anything) {\n\
            [sender setTitle:@\"Merry\" forState:UIControlStateNormal];\n\
}];\n\
[aWrap addButtonTitle:@\"change text to \"Christmas\" eventBlock:^(id anything) {\n\
            [sender setTitle:@\"Christmas\" forState:UIControlStateNormal];\n\
}];\n\
[aWrap addCancelButtonTitle:@\"Cancel\" eventBlock:^(id anything) {\n\
            [SVProgressHUD showSuccessWithStatus:@\"if you did not add the cancel action, the wrap will auto add the cancel action.\"];\n\
}];\n\
[aWrap showWithTitle:@\"Please Choose\"];\n\
self.asWrap = aWrap;";
            break;
        }
        case SCImagePickerDefaultWrapType:
        {
            aTextView.text = @"Demo Code:\n\nSCImagePickerWrap *aWrap = [[SCImagePickerWrap alloc] initWithParent:self];\n\
[aWrap showMenuWithSystemCameraAndAlbum];\n\
self.imagePickerWrap = aWrap;";
            break;
        }
        case SCImagePickerCustomWrapType:
        {
            aTextView.text = @"Demo Code:\n\nSCImagePickerWrap *aWrap = [[SCImagePickerWrap alloc] initWithParent:self];\n\
[aWrap.asWrap addButtonTitle:WrapLocalization(@\"Camera\") eventBlock:^(id anything) {\n\
            [weakSelf.imagePickerWrap showImagePicker:UIImagePickerControllerSourceTypeCamera];\n\
            }];\n\
[aWrap.asWrap addButtonTitle:WrapLocalization(@\"Local album\") eventBlock:^(id anything) {\n\
            [weakSelf.imagePickerWrap showImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];\n\
            }];\n\
[aWrap.asWrap addButtonTitle:WrapLocalization(@\"Show full image\") eventBlock:^(id anything) {\n\
                [SVProgressHUD showSuccessWithStatus:@\"show the full image\"];\n\
            }];\n\
[aWrap.asWrap addCancelButtonTitle:WrapLocalization(@\"Cancel\") eventBlock:^(id anything) {\n\
                [SVProgressHUD showSuccessWithStatus:@\"if you did not add the cancel action, the wrap will auto add the cancel action.\"];\n\
            }];\n\
[aWrap.asWrap showWithTitle:WrapLocalization(@\"Please choose\")];\n\
self.imagePickerWrap = aWrap;";
            break;
        }
        case SCAlertWrapType:
        {
            aTextView.text = @"SCAlertWrap *aWrap = [[SCAlertWrap alloc] init];\n\
if (WRAP_SYSTEM_VERSION >= 8.0) {\n\
[aWrap addTextFieldWithEventBlock:^(UITextField *textField) {\n\
    textField.placeholder = @\"username...\";\n\
}];\n\
[aWrap addTextFieldWithEventBlock:^(UITextField *textField) {\n\
    textField.secureTextEntry = YES;\n\
    textField.placeholder = @\"password...\";\n\
}];\n\
[aWrap addDestructiveButtonTitle:WrapLocalization(@\"Delete\") eventBlock:^(id anything) {\n\
    [SVProgressHUD showSuccessWithStatus:WrapLocalization(@\"Delete\")];\n\
}];\n\
            }\n\
for (int i = 0; i < arc4random() % 10; i++) {\n\
    [aWrap addButtonTitle:[NSString stringWithFormat:@\"%@_%d\", WrapLocalization(@\"Button\"), i] eventBlock:^(id anything) {\n\
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@\"tap button: %d\", i]];\n\
    }];\n\
}\n\
[aWrap addButtonTitle:WrapLocalization(@\"Sure\") eventBlock:^(id anything) {\n\
    NSMutableString *str = [NSMutableString string];\n\
    [str appendString:@\"tap the Sure button\"];\n\
    if (WRAP_SYSTEM_VERSION >= 8.0) {\n\
            [str appendFormat:@\", there are %lu textFields\", (unsigned long)((UIAlertController*)anything).textFields.count];\n\
    }\n\
    [SVProgressHUD showSuccessWithStatus:str];\n\
}];\n\
[aWrap addCancelButtonTitle:WrapLocalization(@\"Cancel\") eventBlock:^(id anything) {\n\
    [SVProgressHUD showSuccessWithStatus:@\"if you did not add the cancel action, the wrap will auto add the cancel action.\"];\n\
}];\n\
[aWrap showWithStyle:arc4random() % 4 title:WrapLocalization(@\"Please choose\") message:@\"\"];\n\
            self.alertWrap = aWrap;";
            break;
        }
        default:
            break;
    }
    [self.view addSubview:aTextView];
}

- (void)showBtnPressed:(UIButton*)sender {

    switch (_type) {
        case SCActionSheetWrapType:
        {
            SCActionSheetWrap *aWrap = [[SCActionSheetWrap alloc] init];
            [aWrap addDestructiveButtonTitle:@"Reset text" eventBlock:^(id anything) {
                [sender setTitle:@"tap me" forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"Reset text"];
            }];
            [aWrap addButtonTitle:@"change text to \"Merry\"" eventBlock:^(id anything) {
                [sender setTitle:@"Merry" forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"Merry"];
            }];
            [aWrap addButtonTitle:@"change text to \"Christmas\"" eventBlock:^(id anything) {
                [sender setTitle:@"Christmas" forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"Christmas"];
            }];
            [aWrap addCancelButtonTitle:@"Cancel" eventBlock:^(id anything) {
                [SVProgressHUD showSuccessWithStatus:@"if you did not add the cancel action, the wrap will auto add the cancel action."];
            }];
            [aWrap showWithTitle:@"Please Choose"];
            self.asWrap = aWrap;
            break;
        }
        case SCImagePickerDefaultWrapType:
        {
            SCImagePickerWrap *aWrap = [[SCImagePickerWrap alloc] initWithParent:self];
            [aWrap showMenuWithSystemCameraAndAlbum];
            self.imagePickerWrap = aWrap;
            break;
        }
        case SCImagePickerCustomWrapType:
        {
            WEAKSELF_WRAP
            SCImagePickerWrap *aWrap = [[SCImagePickerWrap alloc] initWithParent:self];
            [aWrap.asWrap addButtonTitle:WrapLocalization(@"Camera") eventBlock:^(id anything) {
                [weakSelf.imagePickerWrap showImagePicker:UIImagePickerControllerSourceTypeCamera];
            }];
            [aWrap.asWrap addButtonTitle:WrapLocalization(@"Local album") eventBlock:^(id anything) {
                [weakSelf.imagePickerWrap showImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }];
            [aWrap.asWrap addButtonTitle:WrapLocalization(@"Show full image") eventBlock:^(id anything) {
                [SVProgressHUD showSuccessWithStatus:@"show the full image"];
            }];
            [aWrap.asWrap addCancelButtonTitle:WrapLocalization(@"Cancel") eventBlock:^(id anything) {
                [SVProgressHUD showSuccessWithStatus:@"if you did not add the cancel action, the wrap will auto add the cancel action."];
            }];
            [aWrap.asWrap showWithTitle:WrapLocalization(@"Please choose")];
            self.imagePickerWrap = aWrap;
            break;
        }
        case SCAlertWrapType:
        {
            SCAlertWrap *aWrap = [[SCAlertWrap alloc] init];
            if (WRAP_SYSTEM_VERSION >= 8.0) {
                [aWrap addTextFieldWithEventBlock:^(UITextField *textField) {
                    textField.placeholder = @"username...";
                }];
                [aWrap addTextFieldWithEventBlock:^(UITextField *textField) {
                    textField.secureTextEntry = YES;
                    textField.placeholder = @"password...";
                }];
                [aWrap addDestructiveButtonTitle:WrapLocalization(@"Delete") eventBlock:^(id anything) {
                    [SVProgressHUD showSuccessWithStatus:WrapLocalization(@"Delete")];
                }];
            }
            for (int i = 0; i < arc4random() % 10; i++) {
                [aWrap addButtonTitle:[NSString stringWithFormat:@"%@_%d", WrapLocalization(@"Button"), i] eventBlock:^(id anything) {
                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"tap button: %d", i]];
                }];
            }
            [aWrap addButtonTitle:WrapLocalization(@"Sure") eventBlock:^(id anything) {
                NSMutableString *str = [NSMutableString string];
                [str appendString:@"tap the Sure button"];
                if (WRAP_SYSTEM_VERSION >= 8.0) {
                    [str appendFormat:@", there are %lu textFields", (unsigned long)((UIAlertController*)anything).textFields.count];
                }
                [SVProgressHUD showSuccessWithStatus:str];
            }];
            [aWrap addCancelButtonTitle:WrapLocalization(@"Cancel") eventBlock:^(id anything) {
                [SVProgressHUD showSuccessWithStatus:@"if you did not add the cancel action, the wrap will auto add the cancel action."];
            }];
            [aWrap showWithStyle:arc4random() % 4 title:WrapLocalization(@"Please choose") message:@""];
            self.alertWrap = aWrap;
            break;
        }
        default:
            break;
    }
}

- (void)imagePickerBtnPressed:(UIButton*)sender {
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(id)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *aImgView = (UIImageView*)[self.view viewWithTag:20141225];
    if (!aImgView) {
        aImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
        aImgView.tag = 20141225;
        aImgView.contentMode = UIViewContentModeScaleAspectFill;
        aImgView.center = self.view.center;
        [self.view addSubview:aImgView];
    }
    aImgView.image = image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
