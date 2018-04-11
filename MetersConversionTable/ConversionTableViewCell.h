//
//  ConversionTableViewCell.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel_;
@property (weak, nonatomic) IBOutlet UIView *separateView;
@property (weak, nonatomic) IBOutlet UILabel *feetLabel;
@property (weak, nonatomic) IBOutlet UILabel *feetLabel_;

@end
