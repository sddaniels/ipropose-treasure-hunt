//
//  AdminHomeController.m
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "AdminHomeController.h"

@implementation AdminHomeController

@synthesize debugSwitch = _debugSwitch;
@synthesize revealDateLabel = _revealDateLabel;
@synthesize numberSolvedLabel = _numberSolvedLabel;
@synthesize numberOfCluesLabel = _numberOfCluesLabel;
@synthesize datePicker = _datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)doneClick:(id)sender {
    
    // check whether this is the click to dismiss the date picker
    // or the click to dismiss all of black bart's cave
    if (self.datePicker.superview == nil) {
        [self.navigationController dismissModalViewControllerAnimated:YES];
    } else {
        
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        CGRect endFrame = self.datePicker.frame;
        endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
        
        // slide down animation
        [UIView animateWithDuration:0.3 
                         animations:^{
                             self.datePicker.frame = endFrame;
                             
                             // grow the table back to fill the screen
                             CGRect newFrame = self.tableView.frame;
                             newFrame.size.height += self.datePicker.frame.size.height;
                             self.tableView.frame = newFrame;
                         }
                         completion:^(BOOL finished) {
                             [self.datePicker removeFromSuperview];
                         }];
        
        // deselect the current table row
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

- (IBAction)debugValueChanged:(UISwitch*)sender {
    
    _hunt.debugModeOn = [NSNumber numberWithBool:sender.on];
    [_huntRepo saveChanges];
}

- (IBAction)dateValueChanged:(id)sender {
    
    self.revealDateLabel.text = [_dateFormatter stringFromDate:self.datePicker.date];
    _hunt.revealDate = self.datePicker.date;
    [_huntRepo saveChanges];
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _huntRepo = [TreasureHuntRepository sharedRepo];
    _hunt = [_huntRepo getDefaultHunt];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
}

- (void)viewDidUnload
{
    [self setDebugSwitch:nil];
    [self setRevealDateLabel:nil];
    [self setNumberSolvedLabel:nil];
    [self setNumberOfCluesLabel:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
    
    _huntRepo = nil;
    _hunt = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.debugSwitch.on = [_hunt.debugModeOn boolValue];
    self.revealDateLabel.text = [_dateFormatter stringFromDate:_hunt.revealDate];
    self.numberSolvedLabel.text = [_hunt.cluesSolved stringValue];
    self.numberOfCluesLabel.text = [NSString stringWithFormat:@"%i", [_hunt.clues count]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // only needed for reveal date
    if (indexPath.row == 1) {
        
        self.datePicker.date = _hunt.revealDate;
        
        // check if date picker is on screen already
        if (self.datePicker.superview == nil) {
            
            [self.view.window addSubview:self.datePicker];
            
            // size the date picker to the screen and compute start/end frames for slide animation
            ////////////////////////////////////////////////////////////////////////////////////////
            
            // start frame
            CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
            CGSize pickerSize = [self.datePicker sizeThatFits:CGSizeZero];
            CGRect startRect = CGRectMake(0.0,
                                          screenRect.origin.y + screenRect.size.height,
                                          pickerSize.width, pickerSize.height);
            self.datePicker.frame = startRect;
            
            // end frame
            CGRect pickerRect = CGRectMake(0.0,
                                           screenRect.origin.y + screenRect.size.height - pickerSize.height,
                                           pickerSize.width,
                                           pickerSize.height);
            
            // animate the slide up
            [UIView animateWithDuration:0.3 
                             animations:^{
                                 self.datePicker.frame = pickerRect;
                                 
                                 // shrink the table vertical size to make room for the picker
                                 CGRect newFrame = self.tableView.frame;
                                 newFrame.size.height -= self.datePicker.frame.size.height;
                                 self.tableView.frame = newFrame;  
                             }];
            
        }
    }
}

@end
