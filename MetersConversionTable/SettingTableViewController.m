//
//  SettingTableViewController.m
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController {
    URLDownloader *urlDownloader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Setting";
    
    if (_dayMode) {
        self.view.backgroundColor = [UIColor whiteColor];
        _urlLabel.textColor = [UIColor blackColor];
        _urlTextField.textColor = [UIColor darkGrayColor];
        _downloadLabel.textColor = [UIColor blackColor];
        _rowHeightLabel.textColor = [UIColor blackColor];
        _leftNumberFormatLabel.textColor = [UIColor blackColor];
        _rightNumberFormatLabel.textColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
        _urlLabel.textColor = [UIColor lightGrayColor];
        _urlTextField.textColor = [UIColor grayColor];
        _downloadLabel.textColor = [UIColor lightGrayColor];
        _rowHeightLabel.textColor = [UIColor lightGrayColor];
        _leftNumberFormatLabel.textColor = [UIColor lightGrayColor];
        _rightNumberFormatLabel.textColor = [UIColor lightGrayColor];
    }
    
    _leftNumberFormatSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"meterNumberFormat"];
    _rightNumberFormatSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"feetNumberFormat"];
    
    urlDownloader = [[URLDownloader alloc] init];
    urlDownloader.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    _urlTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"url"];
    
    float rowHeight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"rowHeight"] floatValue];
    if (rowHeight == 55.0f) _rowHeightSegmentedControl.selectedSegmentIndex = 0;
    if (rowHeight == 44.0f) _rowHeightSegmentedControl.selectedSegmentIndex = 1;
    if (rowHeight == 33.0f) _rowHeightSegmentedControl.selectedSegmentIndex = 2;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"url"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)rowHeightSegmentedControl:(id)sender {
    float rowHeight;
    switch (_rowHeightSegmentedControl.selectedSegmentIndex) {
        case 0:
            rowHeight = 55.0f;
            break;
        case 1:
            rowHeight = 44.0f;
            break;
        case 2:
            rowHeight = 33.0f;
            break;
        default:
            rowHeight = 55.0f;
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:rowHeight] forKey:@"rowHeight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)leftNumberFormatSwitch:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:_leftNumberFormatSwitch.on forKey:@"meterNumberFormat"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)rightNumberFormatSwitch:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:_rightNumberFormatSwitch.on forKey:@"feetNumberFormat"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Downloader関連
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        [urlDownloader startDownloading:_urlTextField.text];
        _downloadLabel.text = @"Downloading...";
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didFinishDownloadingWithData:(NSData *)data {
    NSArray *datasArray = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:datasArray forKey:@"datasArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SUCCESS" message:@"Download Completed." preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self->_downloadLabel.text = @"Download";
        [self.delegate didFinishDownloadingNewDatas];
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didFailDownloading {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ALERT" message:@"Download Failed." preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self->_downloadLabel.text = @"Download";
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
