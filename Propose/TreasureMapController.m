//
//  TreasureMapController.m
//  Propose
//
//  Created by Shea Daniels on 4/1/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "TreasureMapController.h"

@interface TreasureMapController ()

@end

@implementation TreasureMapController

@synthesize map;
@synthesize locationManager = _locationManager;

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
    if (_zoomIsNeeded) {
        
        // zoom map to user location
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
        [map setRegion:region animated:YES];
        _zoomIsNeeded = NO;
    }
}

- (IBAction)dismissClick:(id)sender {
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)zoomClick:(id)sender {
    
    _zoomIsNeeded = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.locationManager startUpdatingLocation];
    [map setShowsUserLocation:YES];
    _zoomIsNeeded = YES;
}

- (void)viewDidUnload
{
    [self setMap:nil];

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
