//
//  ViewController.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/11.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConversionTableViewCell.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *conversionTableView;

- (IBAction)dayModeButton:(id)sender;

@end

