//
//  AdminClueDetailController.m
//  Propose
//
//  Created by Shea Daniels on 3/26/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "AdminClueDetailController.h"


@implementation AdminClueDetailController

@synthesize geofenceTextField = _geofenceTextField;
@synthesize latitudeTextField = _latitudeTextField;
@synthesize longitudeTextField = _longitudeTextField;
@synthesize initialDistanceTextField = _initialDistanceTextField;
@synthesize gpsAccuracyLabel = _gpsAccuracyLabel;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
    _latestLocation = newLocation;
    _gpsAccuracyLabel.text = [NSString stringWithFormat:@"%f", newLocation.horizontalAccuracy];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    // todo: put something here
}

- (IBAction)setWithGpsClick:(id)sender {
    
    if (_latestLocation) {
        
        _clueData.latitude = [NSNumber numberWithDouble:_latestLocation.coordinate.latitude];
        _clueData.longitude = [NSNumber numberWithDouble:_latestLocation.coordinate.longitude];
        
        [_clueRepo saveChanges];
        
        // update the text fields as well
        self.latitudeTextField.text = [_clueData.latitude stringValue];
        self.longitudeTextField.text = [_clueData.longitude stringValue];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // save changes to all text fields to save time
    _clueData.geoFenceRangeInFeet = [NSNumber numberWithDouble:[self.geofenceTextField.text doubleValue]];
    _clueData.latitude = [NSNumber numberWithDouble:[self.latitudeTextField.text doubleValue]];
    _clueData.longitude = [NSNumber numberWithDouble:[self.longitudeTextField.text doubleValue]];
    _clueData.initialDistance = [NSNumber numberWithDouble:[self.initialDistanceTextField.text doubleValue]];
    
    [_clueRepo saveChanges];
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

    self.title = [NSString stringWithFormat:@"Clue %i", [_clueData.clueNumber intValue]];
    
    self.geofenceTextField.text = [_clueData.geoFenceRangeInFeet stringValue];
    self.geofenceTextField.delegate = self;
    
    self.latitudeTextField.text = [_clueData.latitude stringValue];
    self.latitudeTextField.delegate = self;
    
    self.longitudeTextField.text = [_clueData.longitude stringValue];
    self.longitudeTextField.delegate = self;
    
    self.initialDistanceTextField.text = [_clueData.initialDistance stringValue];
    self.initialDistanceTextField.delegate = self;
    
    _clueRepo = [ClueRepository sharedRepo];
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setGeofenceTextField:nil];
    [self setLatitudeTextField:nil];
    [self setLongitudeTextField:nil];
    [self setInitialDistanceTextField:nil];
    [self setGpsAccuracyLabel:nil];
    
    self.locationManager = nil;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // start editing the text field in the row and cancel the selection
    if (indexPath.row == 0) {
        [self.geofenceTextField becomeFirstResponder];
    } else if (indexPath.row == 1) {
        [self.latitudeTextField becomeFirstResponder];
    } else if (indexPath.row == 2) {
        [self.longitudeTextField becomeFirstResponder];
    } else {
        [self.initialDistanceTextField becomeFirstResponder];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
