//
//  Breadcrumb.h
//  Propose
//
//  Created by Shea Daniels on 12/9/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TreasureHunt;

@interface Breadcrumb : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) TreasureHunt *treasureHunt;

@end
