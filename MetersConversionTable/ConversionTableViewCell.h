//
//  ConversionTableViewCell.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *meterBigLabel;
@property (weak, nonatomic) IBOutlet UILabel *meterSmallLabel;
@property (weak, nonatomic) IBOutlet UIView *horizontalSeparateView;
@property (weak, nonatomic) IBOutlet UILabel *feetBigLabel;
@property (weak, nonatomic) IBOutlet UILabel *feetSmallLabel;
@property (weak, nonatomic) IBOutlet UIView *verticalSeparateView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
