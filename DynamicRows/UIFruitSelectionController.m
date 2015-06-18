//
//  UIFruitSelectionController.m
//  DynamicRows
//
//  Created by William Miller on 6/16/15.
//  Copyright (c) 2015 Miller Computer Services. All rights reserved.
//

#import "UIFruitSelectionController.h"
#import "UIFruitCell.h"

enum {
    
    kFruitFormSectionCount = 1,
    kFruitFormSectionFruits = 0,
};

enum {
    
    kFruitFormFruitSectionExpandedCount = 4,
    kFruitFormFruitSectionCollapsedCount = 2,
    kFruitFormFruitSectionRowCitrus = 0,
    kFruitFormFruitSectionRowCitrusPicker = 1,
    kFruitFormFruitSectionRowMelon = 2,
    kFruitFormFruitSectionRowMelonPicker = 3,
};

@interface UIFruitSelectionController ()

{
@private
    
    NSInteger rowMap[kFruitFormFruitSectionExpandedCount]; // mapping of row type to position in the table
    NSInteger rowsPerSection[kFruitFormSectionCount];  // the total number of rows in each section of the table
    Boolean   isMelonPickerDisplayed;  // Yes if the melon picker is displayed
    Boolean   isCitrusPickerDisplayed; // No if the Citrus picker is displayed.
}

@end

@implementation UIFruitSelectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isMelonPickerDisplayed = isCitrusPickerDisplayed = false;
    
    rowMap[kFruitFormFruitSectionRowCitrus] = kFruitFormFruitSectionRowCitrus;
    rowMap[kFruitFormFruitSectionRowCitrusPicker] = kFruitFormFruitSectionRowCitrus;
    rowMap[kFruitFormFruitSectionRowMelon] = kFruitFormFruitSectionRowCitrus+1;
    rowMap[kFruitFormFruitSectionRowMelonPicker] = kFruitFormFruitSectionRowCitrus+1;
    
    rowsPerSection[kFruitFormSectionFruits] = kFruitFormFruitSectionCollapsedCount;
    
    self.tableView.estimatedRowHeight = 2;
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return kFruitFormSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return rowsPerSection[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier;
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    switch (section) {
        case kFruitFormSectionFruits:
            if (rowMap[kFruitFormFruitSectionRowCitrus] == row) {
                cellIdentifier = @"CitrusCellId";
            } else if (rowMap[kFruitFormFruitSectionRowCitrusPicker] == row) {
                cellIdentifier = @"CitrusPickerCellId";
            } else if (rowMap[kFruitFormFruitSectionRowMelon] == row) {
                cellIdentifier = @"MelonCellId";
            } else if (rowMap[kFruitFormFruitSectionRowMelonPicker] == row) {
                cellIdentifier = @"MelonPickerCellId";
            }
            break;
            
        default:
            break;
    }
    
    UIFruitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ((row == rowMap[kFruitFormFruitSectionRowCitrusPicker] && isCitrusPickerDisplayed)) {
        [cell.pickerCitrus init];
    } else if ((row == rowMap[kFruitFormFruitSectionRowMelonPicker] && isMelonPickerDisplayed)) {
        [cell.pickerMelon init];
    }
    return cell;
}

- (void) incrementRowMapAt: (NSInteger) index {
    
    for (NSInteger i = index; i < kFruitFormFruitSectionExpandedCount; i++) {
        ++rowMap[i];
    }
}
- (void) decrementRowMapAt: (NSInteger) index {
    
    for (NSInteger i = index; i < kFruitFormFruitSectionExpandedCount; i++) {
        --rowMap[i];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIFruitCell *cell = (UIFruitCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelected:false animated:NO];
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    switch (section) {
        case kFruitFormSectionFruits:
            if (rowMap[kFruitFormFruitSectionRowCitrus] == row) {
                
                if (isCitrusPickerDisplayed) {
                    
                    isCitrusPickerDisplayed = NO;
                    
                    NSIndexPath * removePath = [NSIndexPath indexPathForRow:rowMap[kFruitFormFruitSectionRowCitrusPicker] inSection:kFruitFormSectionFruits];
                    
                    UIFruitCell *citrusSelection = (UIFruitCell*)[tableView cellForRowAtIndexPath:removePath];
                    
                    cell.lblCitrus.text = citrusSelection.pickerCitrus.selection;
                    
                    --rowsPerSection[kFruitFormSectionFruits];

                    [self decrementRowMapAt:kFruitFormFruitSectionRowCitrusPicker];
                    
                    [tableView deleteRowsAtIndexPaths:@[removePath] withRowAnimation:UITableViewRowAnimationMiddle];
                    
                } else {
                    
                    isCitrusPickerDisplayed = YES;
                    ++rowsPerSection[kFruitFormSectionFruits];
                    [self incrementRowMapAt:kFruitFormFruitSectionRowCitrusPicker];
                    NSIndexPath * insertPath = [NSIndexPath indexPathForRow:rowMap[kFruitFormFruitSectionRowCitrusPicker] inSection:kFruitFormSectionFruits];
                    [tableView insertRowsAtIndexPaths:@[insertPath] withRowAnimation:UITableViewRowAnimationMiddle];
                    
                }
                
            } else if (rowMap[kFruitFormFruitSectionRowMelon] == row) {
                
                if (isMelonPickerDisplayed) {

                    isMelonPickerDisplayed = NO;

                    NSIndexPath * removePath = [NSIndexPath indexPathForRow:rowMap[kFruitFormFruitSectionRowMelonPicker] inSection:kFruitFormSectionFruits];

                    UIFruitCell *melonCell = [tableView cellForRowAtIndexPath:removePath];
                    
                    cell.lblMelon.text = melonCell.pickerMelon.selection;
                    
                    --rowsPerSection[kFruitFormSectionFruits];

                    [self decrementRowMapAt:kFruitFormFruitSectionRowMelonPicker];

                    [tableView deleteRowsAtIndexPaths:@[removePath] withRowAnimation:UITableViewRowAnimationMiddle];
                    
                } else {
                    
                    isMelonPickerDisplayed = YES;
                    ++rowsPerSection[kFruitFormSectionFruits];
                    [self incrementRowMapAt:kFruitFormFruitSectionRowMelonPicker];
                    NSIndexPath * insertPath = [NSIndexPath indexPathForRow:rowMap[kFruitFormFruitSectionRowMelonPicker] inSection:kFruitFormSectionFruits];
                    [tableView insertRowsAtIndexPaths:@[insertPath] withRowAnimation:UITableViewRowAnimationMiddle];
                    
                }
                
            }
            break;
            
        default:
            break;
    }
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
