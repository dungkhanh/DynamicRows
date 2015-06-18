//
//  UICitrusPickerView.m
//  DynamicRows
//
//  Created by William Miller on 6/16/15.
//  Copyright (c) 2015 Miller Computer Services. All rights reserved.
//

#import "UICitrusPickerView.h"

@interface UICitrusPickerView ()

{
@private
    
    NSString *rowTitles[4];
}

@end
@implementation UICitrusPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)init {
    
    self = [super init];
    
    self.delegate = self;
    
    self.dataSource = self;
    
    rowTitles[0] = @"Lemon";
    rowTitles[1] = @"Lime";
    rowTitles[2] = @"Orange";
    rowTitles[3] = @"Grapefruit";
    
    return self;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 4;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selection = rowTitles[row];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    
    return rowTitles[row];
}

@end
