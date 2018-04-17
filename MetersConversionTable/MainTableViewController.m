//
//  MainTableViewController.m
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/12.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController {
    NSArray *meterFeetArray;
    NSMutableArray *checkedMeterFeetArray;
    BOOL dayMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES; // Turn off sleep mode
    _selectedArea = 0;
    dayMode = NO;
    
    [self setData];
}

- (void)viewWillAppear:(BOOL)animated {
    _rowHeight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"rowHeight"] floatValue];
    if (_rowHeight == 0) _rowHeight = 55.0f;
    [self.tableView reloadData];
}

- (void)setData {
    NSArray *datasArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"datasArray"];
    if (datasArray.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"datas" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        datasArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
    NSArray *selectedDatasArray = datasArray[_selectedArea];
    
    [_titleButton setTitle:selectedDatasArray[0] forState:UIControlStateNormal];
    meterFeetArray = selectedDatasArray[2];
    
    checkedMeterFeetArray = [NSMutableArray new];
    for (int i = 0; i < meterFeetArray.count; i++) {
        NSArray *array = @[@"NO", @"UNKNOWN"];
        [checkedMeterFeetArray addObject:array];
    }
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return meterFeetArray.count;
}

- (ConversionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ConversionTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Meter
    NSString *meterString = meterFeetArray[indexPath.row][0];
    NSInteger meter = [meterString integerValue];
    
    NSInteger meterBig = meter / 100;
    NSMutableString *meterBigString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld", meterBig]];
    NSInteger length = meterBigString.length;
    if (length > 1) {
        [meterBigString insertString:@"," atIndex:length - 1];
    }
    cell.meterBigLabel.text = meterBigString;
    
    NSString *meterSmallString = [meterString substringFromIndex:meterString.length - 2];
    cell.meterSmallLabel.text = [NSString stringWithFormat:@"%@m", meterSmallString];
    
    if ([meterSmallString isEqualToString:@"00"]) {
        cell.meterSmallLabel.font = [UIFont fontWithName:@"Courier New" size:15];
    } else {
        cell.meterSmallLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:15];
    }
    
    // SeparateView
    cell.horizontalSeparateView.backgroundColor = [tableView separatorColor];
    cell.verticalSeparateView.backgroundColor = [tableView separatorColor];
    
    // Feet
    NSString *feetString = meterFeetArray[indexPath.row][1];
    NSInteger feet = [feetString integerValue];
    NSInteger feetBig = feet / 100;
    cell.feetBigLabel.text = [NSString stringWithFormat:@"%ld", feetBig];
    
    NSString *feetSmallString = [feetString substringFromIndex:feetString.length - 2];
    cell.feetSmallLabel.text = [NSString stringWithFormat:@"%@ft", feetSmallString];
    
    if (dayMode) {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self.view.backgroundColor = [UIColor whiteColor];
            UIView *selectedView = [[UIView alloc] init];
            selectedView.backgroundColor = [UIColor lightGrayColor];
            [cell setSelectedBackgroundView:selectedView];
            cell.meterBigLabel.textColor = [UIColor blackColor];
            cell.meterSmallLabel.textColor = [UIColor blackColor];
            cell.feetBigLabel.textColor = [UIColor darkGrayColor];
            cell.feetSmallLabel.textColor = [UIColor darkGrayColor];
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self.view.backgroundColor = [UIColor blackColor];
            UIView *selectedView = [[UIView alloc] init];
            selectedView.backgroundColor = [UIColor darkGrayColor];
            [cell setSelectedBackgroundView:selectedView];
            cell.meterBigLabel.textColor = [UIColor lightGrayColor];
            cell.meterSmallLabel.textColor = [UIColor lightGrayColor];
            cell.feetBigLabel.textColor = [UIColor grayColor];
            cell.feetSmallLabel.textColor = [UIColor grayColor];
        } completion:nil];
    }
    
    if ([checkedMeterFeetArray[indexPath.row][0] isEqualToString:@"YES"]) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@Z", checkedMeterFeetArray[indexPath.row][1]];
        cell.timeLabel.hidden = NO;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        cell.timeLabel.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 現在UTC取得
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *dateString = [dateFormatter stringFromDate:date];
    [checkedMeterFeetArray replaceObjectAtIndex:indexPath.row withObject:@[@"YES", dateString]];
    
    ConversionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.layer.borderColor = [[UIColor yellowColor] CGColor];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@Z", [dateFormatter stringFromDate:date]];
    cell.timeLabel.hidden = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [checkedMeterFeetArray replaceObjectAtIndex:indexPath.row withObject:@[@"NO", @"UNKNOWN"]];
    ConversionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.timeLabel.hidden = YES;
}

- (IBAction)dayModeButton:(id)sender {
    dayMode = !dayMode;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"settingSegue"]) {
        SettingTableViewController *settingTableViewController = segue.destinationViewController;
        settingTableViewController.delegate = self;
        settingTableViewController.dayMode = dayMode;
    }
    if ([segue.identifier isEqualToString:@"areaSegue"]) {
        AreaTableViewController *areaTableViewController = segue.destinationViewController;
        areaTableViewController.dayMode = dayMode;
    }
}

- (IBAction)firstViewReturnActionForSegue:(UIStoryboardSegue *)segue {
    [self setData];
}

- (void)didFinishDownloadingNewDatas {
    _selectedArea = 0;
    [self setData];
}

/*
- (IBAction)refreshControl:(id)sender {
    NSArray *selectedIndexPathsArray = self.tableView.indexPathsForSelectedRows;
    for (NSIndexPath *indexPath in selectedIndexPathsArray) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    [self.tableView.refreshControl endRefreshing];
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

