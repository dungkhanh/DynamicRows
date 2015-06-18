//
//  UIMelonPickerView.h
//  DynamicRows
//
//  Created by William Miller on 6/16/15.
//  Copyright (c) 2015 Miller Computer Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMelonPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak) NSString *selection;

@end
