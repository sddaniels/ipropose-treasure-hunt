//
//  HintViewController.m
//  Propose
//
//  Created by Shea Daniels on 3/21/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "HintViewController.h"

@implementation HintViewController

@synthesize heading = _heading;
@synthesize hintText = _hintText;
@synthesize photo = _photo;
@synthesize clueData = _clueData;

- (void)setLabels
{
    self.heading.text = [NSString stringWithFormat:@"Hint for Clue %@", _clueData.clueNumber];
    
    if ([_clueData.hint isEqualToString:@"campanile-photo"]) {
        
        [self.hintText setHidden:YES];
        
    } else {
    
        [self.photo setHidden:YES];
        self.hintText.text = _clueData.hint;
    }
}

- (IBAction)backClick:(id)sender {
    
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.heading setFont:[UIFont fontWithName:@"UglyQua" size:36]];
    [self.hintText setFont:[UIFont fontWithName:@"UglyQua-Italic" size:20]];
    [self setLabels];
}

- (void)viewDidUnload
{
    [self setHintText:nil];
    [self setHeading:nil];
    [self setPhoto:nil];
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
