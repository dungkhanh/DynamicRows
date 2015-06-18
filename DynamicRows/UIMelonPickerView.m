//
//  UIMelonPickerView.m
//  DynamicRows
//
//  Created by William Miller on 6/16/15.
//  Copyright (c) 2015 Miller Computer Services. All rights reserved.
//

#import "UIMelonPickerView.h"

@interface UIMelonPickerView ()

{
@private
    
    NSString *rowTitles[4];
}

@end

@implementation UIMelonPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    
    self = [super init];
    
    self.dataSource = self;
    
    self.delegate = self;
    
    rowTitles[0] = @"Watermelon";
    rowTitles[1] = @"Honeydew";
    rowTitles[2] = @"cantaloupe";
    rowTitles[3] = @"Crenshaw";
    
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
