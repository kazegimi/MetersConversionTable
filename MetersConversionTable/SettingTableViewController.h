//
//  SettingTableViewController.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "URLDownloader.h"

@protocol SettingTableViewControllerDelegate

@optional

- (void)didFinishDownloadingNewDatas;

@end

#import "MainTableViewController.h" // DelegateのProtocolよりも前にあるとErrorになる

@interface SettingTableViewController : UITableViewController <URLDownloaderDelegate, UITextFieldDelegate>

@property (strong, nonatomic) id<SettingTableViewControllerDelegate> delegate;

@property (nonatomic) BOOL dayMode;

@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowHeightLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rowHeightSegmentedControl;
- (IBAction)rowHeightSegmentedControl:(id)sender;

@end
