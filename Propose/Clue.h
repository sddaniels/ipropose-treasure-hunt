//
//  Clue.h
//  Propose
//
//  Created by Shea Daniels on 12/9/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TreasureHunt;

@interface Clue : NSManagedObject

@property (nonatomic, retain) NSNumber * clueNumber;
@property (nonatomic, retain) NSDate * discoveryTime;
@property (nonatomic, retain) NSNumber * initialDistance;
@property (nonatomic, retain) NSNumber * geoFenceRangeInFeet;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * hint;
@property (nonatomic, retain) TreasureHunt *treasureHunt;

@end
