//
//  MainTableViewController.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConversionTableViewCell.h"
#import "AreaTableViewController.h"
#import "SettingTableViewController.h"

@interface MainTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
- (IBAction)refreshControl:(id)sender;

@property (nonatomic) NSInteger selectedArea;

- (IBAction)dayModeButton:(id)sender;

@end
