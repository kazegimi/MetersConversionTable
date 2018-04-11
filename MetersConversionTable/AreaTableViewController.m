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

@implementation AreaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_dayMode) {
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    self.title = @"Select Area";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
