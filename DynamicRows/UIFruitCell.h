//
//  UIFruitCell.h
//  DynamicRows
//
//  Created by William Miller on 6/16/15.
//  Copyright (c) 2015 Miller Computer Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICitrusPickerView.h"
#import "UIMelonPickerView.h"

@interface UIFruitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCitrus;
@property (weak, nonatomic) IBOutlet UILabel *lblMelon;
@property (weak, nonatomic) IBOutlet UIMelonPickerView *pickerMelon;
@property (weak, nonatomic) IBOutlet UICitrusPickerView *pickerCitrus;

@end
