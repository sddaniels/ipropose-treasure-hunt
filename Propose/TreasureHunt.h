//
//  TreasureHunt.h
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Breadcrumb, Clue;

@interface TreasureHunt : NSManagedObject

@property (nonatomic, retain) NSString * adminPassword;
@property (nonatomic, retain) NSNumber * cluesSolved;
@property (nonatomic, retain) NSString * huntName;
@property (nonatomic, retain) NSDate * revealDate;
@property (nonatomic, retain) NSNumber * debugModeOn;
@property (nonatomic, retain) NSSet *breadcrumbTrail;
@property (nonatomic, retain) NSSet *clues;
@end

@interface TreasureHunt (CoreDataGeneratedAccessors)

- (void)addBreadcrumbTrailObject:(Breadcrumb *)value;
- (void)removeBreadcrumbTrailObject:(Breadcrumb *)value;
- (void)addBreadcrumbTrail:(NSSet *)values;
- (void)removeBreadcrumbTrail:(NSSet *)values;
- (void)addCluesObject:(Clue *)value;
- (void)removeCluesObject:(Clue *)value;
- (void)addClues:(NSSet *)values;
- (void)removeClues:(NSSet *)values;
@end
