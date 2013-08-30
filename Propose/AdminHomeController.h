//
//  AdminHomeController.h
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureHuntRepository.h"
#import "TreasureHunt.h"

@interface AdminHomeController : UITableViewController {
    TreasureHuntRepository *_huntRepo;
    TreasureHunt *_hunt;
    NSDateFormatter *_dateFormatter;
}

@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch;
@property (weak, nonatomic) IBOutlet UILabel *revealDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberSolvedLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCluesLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)doneClick:(id)sender;
- (IBAction)debugValueChanged:(id)sender;
- (IBAction)dateValueChanged:(id)sender;

@end
