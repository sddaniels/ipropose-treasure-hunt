//
//  AdminClueDetailController.h
//  Propose
//
//  Created by Shea Daniels on 3/26/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ClueRepository.h"
#import "Clue.h"

@interface AdminClueDetailController : UITableViewController <UITextFieldDelegate,CLLocationManagerDelegate> {
    ClueRepository *_clueRepo;
    CLLocation *_latestLocation;
}

@property (weak, nonatomic) IBOutlet UITextField *geofenceTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *initialDistanceTextField;
@property (weak, nonatomic) IBOutlet UILabel *gpsAccuracyLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Clue *clueData; 

- (IBAction)setWithGpsClick:(id)sender;

@end
