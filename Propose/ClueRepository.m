//
//  ClueRepository.m
//  Propose
//
//  Created by Shea Daniels on 3/19/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "ClueRepository.h"

static ClueRepository *sharedRepo = nil;

@implementation ClueRepository

+ (ClueRepository *)sharedRepo
{
	if (!sharedRepo) {
		sharedRepo = [[ClueRepository alloc] init];
	}
	return sharedRepo;
}

- (id)init
{
    if (self = [super init])
    {
        // intentionally blank for now
    }
    return self;
}

- (NSArray *)getAllClues
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // set entity for fetch request
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Clue" 
                                   inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    // execute the fetch
    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

- (Clue *)getClue:(int)clueNumber
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // set entity for fetch request
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Clue" 
                                   inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    // set predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"clueNumber == %@", [NSNumber numberWithInt:clueNumber]];
    [fetchRequest setPredicate:predicate];
    
    // execute the fetch
    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    
    for (Clue *clue in fetchedObjects) {
        return clue;
    }
    return nil;
}

@end
