//
//  DetailController.m
//  Propose
//
//  Created by Shea Daniels on 12/8/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "DetailController.h"
#import "BlackBartWatchdog.h"

@implementation DetailController

- (IBAction)piClick:(id)sender {
    
    BlackBartWatchdog *watchdog = [[BlackBartWatchdog alloc] initWithOwner:self];
    UIAlertView *login = [watchdog getLoginView];
    [login show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    BlackBartWatchdog *watchdog = [[BlackBartWatchdog alloc] initWithOwner:self];
    signed char passwordGood = [watchdog checkPassword:alertView buttonIndex:buttonIndex];
    
    if (passwordGood == NO) {
        
        UIAlertView *badPassword = [watchdog getBadPasswordView];
        [badPassword show];
        
    } else if (passwordGood == YES) {
        [self performSegueWithIdentifier:@"OptionsToBartSegue" sender:nil];
    }
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
    
}

- (void)viewDidUnload
{
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    //return YES;
}

@end
