//
//  AreaTableViewController.m
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "AreaTableViewController.h"

@interface AreaTableViewController ()

@end

@implementation AreaTableViewController {
    NSArray *datasArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_dayMode) {
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    self.title = @"Select Area";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"datas" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    datasArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (_dayMode) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor lightGrayColor];
        [cell setSelectedBackgroundView:selectedView];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor darkGrayColor];
        [cell setSelectedBackgroundView:selectedView];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = datasArray[indexPath.row][0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    ViewController *viewController = (ViewController *)segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
    viewController.selectedArea = selectedPath.row;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
