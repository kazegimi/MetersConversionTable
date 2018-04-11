//
//  ConversionTableViewCell.m
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import "ConversionTableViewCell.h"

@implementation ConversionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor *color = _separateView.backgroundColor;
    [super setSelected:selected animated:animated];
    
    if (selected){
        _separateView.backgroundColor = color;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    UIColor *color = _separateView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted){
        _separateView.backgroundColor = color;
    }
}

@end

