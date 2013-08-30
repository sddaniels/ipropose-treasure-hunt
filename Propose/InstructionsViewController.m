//
//  InstructionsViewController.m
//  Propose
//
//  Created by Shea Daniels on 12/5/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "InstructionsViewController.h"

@implementation InstructionsViewController
@synthesize heading;
@synthesize hotLabel;
@synthesize coldLabel;
@synthesize textLabel;
@synthesize thermometerInstructions;
@synthesize hintInstructions;
@synthesize mapInstructions;

- (IBAction)mapClick:(id)sender {
    
    UIAlertView *mapAlert = [[UIAlertView alloc] initWithTitle:@"Ahoy!" 
                                                       message:@"On a real clue, this button will show ye a live view of yer location on the treasure map." 
                                                      delegate:self 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles:nil];
    [mapAlert show];
}

- (IBAction)hintClick:(id)sender {
   
    UIAlertView *hintAlert = [[UIAlertView alloc] initWithTitle:@"Shiver Me Timbers!" 
                                                        message:@"On a real clue, this button will show ye a hint if ye aren't gettin any wind in yer sails. Flip up this instructions page to see the first clue." 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    [hintAlert show];
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIFont *thermFont = [UIFont fontWithName:@"UglyQua" size:24];
    UIFont *instructionsFont = [UIFont fontWithName:@"UglyQua" size:12];
    
    [self.heading setFont:[UIFont fontWithName:@"UglyQua" size:36]];
    [self.hotLabel setFont:thermFont];
    [self.coldLabel setFont:thermFont];
    [self.textLabel setFont:[UIFont fontWithName:@"UglyQua-Italic" size:17]];
    [self.thermometerInstructions setFont:instructionsFont];
    [self.hintInstructions setFont:instructionsFont];
    [self.mapInstructions setFont:instructionsFont];
}

- (void)viewDidUnload
{
    [self setHeading:nil];
    [self setHotLabel:nil];
    [self setColdLabel:nil];
    [self setTextLabel:nil];
    [self setMapInstructions:nil];
    [self setHintInstructions:nil];
    [self setThermometerInstructions:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

@end