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
    
    self.clipsToBounds = true;
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    _timeLabel.clipsToBounds = true;
    _timeLabel.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor *horizontalSeparateViewColor = _horizontalSeparateView.backgroundColor;
    UIColor *verticalSeparateViewColor = _verticalSeparateView.backgroundColor;
    UIColor *timeLabelColor = _timeLabel.backgroundColor;
    [super setSelected:selected animated:animated];
    
    if (selected){
        _horizontalSeparateView.backgroundColor = horizontalSeparateViewColor;
        _verticalSeparateView.backgroundColor = verticalSeparateViewColor;
        _timeLabel.backgroundColor = timeLabelColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    UIColor *horizontalSeparateViewColor = _horizontalSeparateView.backgroundColor;
    UIColor *verticalSeparateViewColor = _verticalSeparateView.backgroundColor;
    UIColor *timeLabelColor = _timeLabel.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted){
        _horizontalSeparateView.backgroundColor = horizontalSeparateViewColor;
        _verticalSeparateView.backgroundColor = verticalSeparateViewColor;
        _timeLabel.backgroundColor = timeLabelColor;
    }
}

@end

