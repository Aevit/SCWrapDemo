//
//  ViewController.m
//  SCWrapDemo
//
//  Created by Aevitx on 14/12/25.
//  Copyright (c) 2014年 Aevit. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = self.view.frame;
    frame.origin.y = 20;
    frame.size.height -= 20;
    UITableView *aTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    aTable.delegate = self;
    aTable.dataSource = self;
    [self.view addSubview:aTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = (indexPath.row == 0 ? @"SCActionSheetWrap" : (indexPath.row == 1 ? @"SCImagePickerDefaultWrapType" : (indexPath.row == 2 ? @"SCImagePickerCustomWrapType" : (indexPath.row == 3 ? @"SCAlertWrap" : @"it is imposibble"))));
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DemoViewController *con = [[DemoViewController alloc] init];
    con.type = indexPath.row;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    [self presentViewController:nav animated:YES completion:^{
        ;
    }];
}

@end
