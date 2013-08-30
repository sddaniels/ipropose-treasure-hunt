//
//  TreasureMapController.h
//  Propose
//
//  Created by Shea Daniels on 4/1/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TreasureMapController : UIViewController <CLLocationManagerDelegate> {
    BOOL _zoomIsNeeded;
}

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)dismissClick:(id)sender;
- (IBAction)zoomClick:(id)sender;

@end
