//
//  DistanceHelper.m
//  Propose
//
//  Created by Shea Daniels on 3/24/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "DistanceCalculator.h"

@implementation DistanceCalculator

@synthesize target = _target;

- (id)initWithClue:(Clue*)clue
{
    if (self = [super init]) {
        _target = [[CLLocation alloc] initWithLatitude:[clue.latitude doubleValue]
                                             longitude:[clue.longitude doubleValue]];
        _geofenceRangeInMeters = [clue.geoFenceRangeInFeet doubleValue] * 0.3048;
    }
    return self;    
}

- (void)calcDistance:(CLLocation *)here
{
    _distanceInMeters = [here distanceFromLocation:_target];
}

- (CLLocationDistance)distanceInMeters
{
    return _distanceInMeters;
}

- (double)distanceInFeet
{
    return _distanceInMeters *  3.2808399;
}

- (double)distanceInMiles
{
    return _distanceInMeters * 0.000621371192;
}

- (CLLocationDistance)distanceToGeofenceInMeters
{
    return _distanceInMeters - _geofenceRangeInMeters;
}

- (CLLocationDistance)geofenceRangeInMeters
{
    return _geofenceRangeInMeters;
}

@end
