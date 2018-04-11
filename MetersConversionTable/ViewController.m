//
//  ViewController.m
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray *datasArray;
    NSMutableArray *checkedDatasArray;
    BOOL dayMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    datasArray = @[@[@"125", @"411"],
                   @[@"119", @"391"],
                   @[@"113", @"371"],
                   @[@"107", @"351"],
                   @[@"101", @"331"],
                   @[@"95", @"311"],
                   @[@"89", @"291"],
                   @[@"84", @"276"],
                   @[@"81", @"266"],
                   @[@"78", @"256"],
                   @[@"75", @"246"],
                   @[@"72", @"236"],
                   @[@"69", @"226"],
                   @[@"66", @"217"],
                   @[@"63", @"207"],
                   @[@"60", @"197"],
                   @[@"57", @"187"],
                   @[@"54", @"177"],
                   @[@"51", @"167"],
                   @[@"48", @"157"],
                   @[@"45", @"148"],
                   @[@"42", @"138"],
                   @[@"39", @"128"],
                   @[@"36", @"118"],
                   @[@"33", @"108"],
                   @[@"30", @"98"],
                   @[@"27", @"89"],
                   @[@"24", @"79"],
                   @[@"21", @"69"],
                   @[@"18", @"59"],
                   @[@"15", @"49"],
                   @[@"12", @"39"],
                   @[@"10", @"33"],
                   @[@"9", @"30"],
                   @[@"7", @"23"],
                   @[@"6", @"20"],
                   @[@"5.5", @"18"],
                   @[@"5", @"16"],
                   @[@"4", @"13"],
                   @[@"3", @"10"]
                   ];
    
    checkedDatasArray = [NSMutableArray new];
    for (int i = 0; i < datasArray.count; i++) {
        [checkedDatasArray addObject:@"NO"];
    }
    
    self.title = @"PEK EAST";
    
    dayMode = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TableView関連
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return @"";
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasArray.count;
}

- (ConversionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ConversionTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    float meter = [datasArray[indexPath.row][0] floatValue];
    int meter_int = (int)meter;
    int meter_float = (meter - meter_int) * 10;
    
    NSMutableString *intString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%d", meter_int]];
    NSInteger length = intString.length;
    if (length > 1) {
        [intString insertString:@"," atIndex:length - 1];
    }
    
    cell.meterLabel.text = intString;
    
    if (meter_float != 0) {
        cell.meterLabel_.text = [NSString stringWithFormat:@"%dm", meter_float * 10];
        cell.meterLabel_.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:15];
    } else {
        cell.meterLabel_.text = @"00m";
        cell.meterLabel_.font = [UIFont fontWithName:@"Courier New" size:15];
    }
    
    cell.feetLabel.text = datasArray[indexPath.row][1];
    
    if (dayMode) {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self.view.backgroundColor = [UIColor whiteColor];
            UIView *selectedView = [[UIView alloc] init];
            selectedView.backgroundColor = [UIColor lightGrayColor];
            [cell setSelectedBackgroundView:selectedView];
            cell.meterLabel.textColor = [UIColor blackColor];
            cell.meterLabel_.textColor = [UIColor blackColor];
            cell.feetLabel.textColor = [UIColor darkGrayColor];
            cell.feetLabel_.textColor = [UIColor darkGrayColor];
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^ {
            //アニメーションで変化させたい値を設定する（最終的に変更したい値）
            self.view.backgroundColor = [UIColor blackColor];
            UIView *selectedView = [[UIView alloc] init];
            selectedView.backgroundColor = [UIColor darkGrayColor];
            [cell setSelectedBackgroundView:selectedView];
            cell.meterLabel.textColor = [UIColor lightGrayColor];
            cell.meterLabel_.textColor = [UIColor lightGrayColor];
            cell.feetLabel.textColor = [UIColor grayColor];
            cell.feetLabel_.textColor = [UIColor grayColor];
        } completion:nil];
    }
    
    if ([checkedDatasArray[indexPath.row] isEqualToString:@"YES"]) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [checkedDatasArray replaceObjectAtIndex:indexPath.row withObject:@"YES"];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [checkedDatasArray replaceObjectAtIndex:indexPath.row withObject:@"NO"];
}

- (IBAction)dayModeButton:(id)sender {
    dayMode = !dayMode;
    [_conversionTableView reloadData];
}
@end
