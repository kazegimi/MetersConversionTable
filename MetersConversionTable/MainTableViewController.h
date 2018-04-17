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

@interface MainTableViewController : UITableViewController <SettingTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (nonatomic) NSInteger selectedArea;
@property (nonatomic) float rowHeight;

- (IBAction)dayModeButton:(id)sender;

@end
