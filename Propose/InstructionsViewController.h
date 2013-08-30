//
//  InstructionsViewController.h
//  Propose
//
//  Created by Shea Daniels on 12/5/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *coldLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *thermometerInstructions;
@property (weak, nonatomic) IBOutlet UILabel *hintInstructions;
@property (weak, nonatomic) IBOutlet UILabel *mapInstructions;

- (IBAction)mapClick:(id)sender;
- (IBAction)hintClick:(id)sender;

@end
