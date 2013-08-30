//
//  DistanceHelper.h
//  Propose
//
//  Created by Shea Daniels on 3/24/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Clue.h"

@interface DistanceCalculator : NSObject 
{    
    CLLocationDistance _distanceInMeters;
    CLLocationDistance _geofenceRangeInMeters;
}

@property (strong, nonatomic) CLLocation *target;

- (id)initWithClue:(Clue*)clue;
- (void)calcDistance:(CLLocation*)here;

- (CLLocationDistance)distanceInMeters;
- (double)distanceInFeet;
- (double)distanceInMiles;

- (CLLocationDistance)distanceToGeofenceInMeters;
- (CLLocationDistance)geofenceRangeInMeters;

@end
