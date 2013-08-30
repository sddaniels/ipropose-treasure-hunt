//
//  GameViewController.m
//  Propose
//
//  Created by Shea Daniels on 12/5/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "GameViewController.h"

#import "TreasureHuntRepository.h"
#import "TreasureHunt.h"

@implementation GameViewController

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    // switch into the treasure hunt mode
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];    
    [self performSegueWithIdentifier:@"SwitchSegue" sender:nil];
    
}

- (IBAction)goBack:(id)sender {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
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
	
    TreasureHuntRepository *huntRepo = [TreasureHuntRepository sharedRepo];
    TreasureHunt *hunt = [huntRepo getDefaultHunt];
    
    // see if we've reached the reveal date
    NSTimeInterval interval = [hunt.revealDate timeIntervalSinceNow];
    
    if (interval <= 0) { // negative interval indicates reveal date in the past
        
        UIAlertView *switcher = [[UIAlertView alloc] initWithTitle:@"Yarrrrrrr!" 
                                                           message:@"This game has been taken over by pirates looking for some very special treasure! I hear they have a 'proposal' fer ye..." 
                                                          delegate:self 
                                                 cancelButtonTitle:@"Join the Treasure Hunt" 
                                                 otherButtonTitles:nil];
        [switcher show];
    }
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
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];     
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
