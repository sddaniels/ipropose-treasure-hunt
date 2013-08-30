//
//  DataViewController.m
//  Propose
//
//  Created by Shea Daniels on 12/4/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "ClueViewController.h"

#import "HintViewController.h"
#import "DistanceCalculator.h"
#import "ClueRepository.h"
#import "TreasureHunt.h"
#import "PageViewControllerDataSource.h"

@implementation ClueViewController

@synthesize heading = _heading;
@synthesize thermPointer = _thermPointer;
@synthesize clueText = _clueText;
@synthesize debugText = _debugText;
@synthesize solvedText = _solvedText;
@synthesize locationManager = _locationManager;
@synthesize clueData = _clueData;

- (CLLocationManager *) locationManager {
    
    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
    
    ClueRepository *clueRepo = [ClueRepository sharedRepo];
    
    // calculate distance to target
    DistanceCalculator *dCalc = [[DistanceCalculator alloc] initWithClue:_clueData];
    [dCalc calcDistance:newLocation];
    
    // set initial(max) distance if necessary
    if ([dCalc distanceInMeters] > [_clueData.initialDistance doubleValue]) {
        
        _clueData.initialDistance = [NSNumber numberWithDouble:[dCalc distanceInMeters]];
        [clueRepo saveChanges];
    }
    
    // animate thermometer pointer
    double meterLength;
    double offset;
    double percentComplete;
    
    if ([dCalc distanceInFeet] <= [_clueData.geoFenceRangeInFeet doubleValue]) {
        
        // meter positions in pts
        meterLength = 26;
        offset = 76;
        
        // use last 10% of hot space
        percentComplete = ([dCalc geofenceRangeInMeters] - [dCalc distanceInMeters]) / [dCalc geofenceRangeInMeters];
        
    } else {
        
        // meter positions in pts
        meterLength = 232;
        offset = 102;
        
        // use other 90% of meter
        double initialDistance = [_clueData.initialDistance doubleValue] - [dCalc geofenceRangeInMeters];
        percentComplete = (initialDistance - [dCalc distanceToGeofenceInMeters]) / initialDistance;
    }
    
    if (_pointerSetForDisplay) {
        [UIView animateWithDuration:1.0 
                         animations:^{
                            CGRect frame = self.thermPointer.frame;
                            frame.origin.y = (meterLength * (1 - percentComplete)) + offset;
                            self.thermPointer.frame = frame;
                         }];
    }
    
    // check for completion of clue    
    if (_clueData.discoveryTime == nil && [dCalc distanceInFeet] <= [_clueData.geoFenceRangeInFeet doubleValue]) {
        
        _clueData.discoveryTime = [NSDate date];
        _clueData.treasureHunt.cluesSolved = _clueData.clueNumber;
        [clueRepo saveChanges];
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.solvedText setHidden:NO];
                         }];
        
        UIAlertView *clueSolvedAlert;
        if ([_clueData.treasureHunt.cluesSolved integerValue] == [_clueData.treasureHunt.clues count]) {
            
            clueSolvedAlert = [[UIAlertView alloc] initWithTitle:@"X Marks the Spot" 
                                                         message:@"Ye solved the final clue, prepare to meet yer fate..." 
                                                        delegate:self 
                                               cancelButtonTitle:@"Shiver me timbers!" 
                                               otherButtonTitles:nil];
            
        } else {
        
            clueSolvedAlert = [[UIAlertView alloc] initWithTitle:@"X Marks the Spot" 
                                                         message:@"Ye solved the clue! Arrre ye ready for the next one?" 
                                                        delegate:self 
                                               cancelButtonTitle:@"Aye, come about!" 
                                               otherButtonTitles:nil];
        }
        [clueSolvedAlert show];
    }
    
    // debugging only stuff
    /////////////////////////
    
    if ([_clueData.treasureHunt.debugModeOn boolValue]) {
    
        // date formatter for the time stamp
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        }
        
        NSString *distance; 
        if ([dCalc distanceInFeet] <= 500) {
            distance = [NSString stringWithFormat:@"%f ft", [dCalc distanceInFeet]];
        } else {
            distance = [NSString stringWithFormat:@"%f mi", [dCalc distanceInMiles]];
        }
        
        self.debugText.text = [NSString stringWithFormat:@"Time:_%@ GeoFenceRange:_%f ft InitialDistance:_%f mi DistanceToTarget:_%@ Accuracy:_%f Percentage:_%f CompTime:_%@",  
                               [dateFormatter stringFromDate:[NSDate date]],
                               [_clueData.geoFenceRangeInFeet doubleValue],
                               ([_clueData.initialDistance doubleValue] * 0.000621371192),
                               distance,
                               newLocation.horizontalAccuracy,
                               (percentComplete * 100),
                               [dateFormatter stringFromDate:_clueData.discoveryTime]];
    }
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    // todo: put something here
}

- (void)setLabels
{
    self.heading.text = [NSString stringWithFormat:@"Clue %@ of 5", _clueData.clueNumber];
    self.clueText.text = _clueData.text;
}

- (void)setPointer
{
    // display the thermometer pointer
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect frame = self.thermPointer.frame;
                         frame.origin.x = 242;
                         self.thermPointer.frame = frame;
                     }
                     completion:^(BOOL finished){
                         _pointerSetForDisplay = YES;
                     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HintSegue"]) {
        
        HintViewController *hintController = segue.destinationViewController;
        hintController.clueData = self.clueData;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    // grab objects
    UIPageViewController *pageViewController = (UIPageViewController*)self.parentViewController;
    PageViewControllerDataSource *ds = pageViewController.dataSource;
    
    // flip the page
    UIViewController *newViewController = [ds viewControllerAtIndex:([_clueData.clueNumber integerValue] + 2) storyboard:self.storyboard];
    NSArray *viewControllers = [NSArray arrayWithObject:newViewController];
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
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
    
    [self.heading setFont:[UIFont fontWithName:@"UglyQua" size:36]];
    [self.clueText setFont:[UIFont fontWithName:@"UglyQua-Italic" size:20]];
    [self.solvedText setFont:[UIFont fontWithName:@"UglyQua" size:30]];
    [self setLabels];
    
    // hide show labels as necessary
    BOOL debugModeOn = [_clueData.treasureHunt.debugModeOn boolValue];    
    [self.clueText setHidden:debugModeOn];
    [self.debugText setHidden:!debugModeOn];
    
    if (_clueData.discoveryTime) {
        [self.solvedText setHidden:NO];
    } else {
        [self.solvedText setHidden:YES];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    self.heading = nil;
    self.thermPointer = nil;
    self.clueText = nil;
    self.debugText = nil;
    
    self.locationManager = nil;
    
    [self setSolvedText:nil];
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
