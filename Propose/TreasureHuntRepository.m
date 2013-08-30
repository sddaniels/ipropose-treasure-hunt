//
//  TreasureHuntRepository.m
//  Propose
//
//  Created by Shea Daniels on 3/19/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "TreasureHuntRepository.h"
#import "Clue.h"

static TreasureHuntRepository *sharedRepo = nil;

@implementation TreasureHuntRepository

+ (TreasureHuntRepository *)sharedRepo
{
	if (!sharedRepo) {
		sharedRepo = [[TreasureHuntRepository alloc] init];
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

- (void)addDefaultHunt 
{
    // create the top level hunt object
    TreasureHunt *defaultHunt = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"TreasureHunt"
                                 inManagedObjectContext:self.context];
    defaultHunt.huntName = @"lindsey";
    defaultHunt.cluesSolved = [NSNumber numberWithInt:0];
    defaultHunt.adminPassword = @"qwerty";
    defaultHunt.debugModeOn = [NSNumber numberWithBool:NO];
    
    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
    mmddccyy.timeStyle = NSDateFormatterNoStyle;
    mmddccyy.dateFormat = @"MM/dd/yyyy";
    defaultHunt.revealDate = [mmddccyy dateFromString:@"4/1/2012"];
      
    // create all the clues
    /////////////////////////
    
    // clue #1
    Clue *newClue = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Clue"
                     inManagedObjectContext:self.context];
    newClue.clueNumber = [NSNumber numberWithInt:1];
    newClue.geoFenceRangeInFeet = [NSNumber numberWithDouble:300.0];
    newClue.latitude = [NSNumber numberWithDouble:41.551747];
    newClue.longitude = [NSNumber numberWithDouble:-93.653650];
    newClue.text = @"Begin your treasure hunt by heading to the place where swimming dogs cause a serious stir. You might want to let some people know what you're up to.";
    newClue.hint = @"Does Thornton Ave. ring a bell? Your parents are probably just as excited as you are!";
    newClue.treasureHunt = defaultHunt;
    
    // clue #2
    newClue = [NSEntityDescription
               insertNewObjectForEntityForName:@"Clue"
               inManagedObjectContext:self.context];
    newClue.clueNumber = [NSNumber numberWithInt:2];
    newClue.geoFenceRangeInFeet = [NSNumber numberWithDouble:1000.0];
    newClue.latitude = [NSNumber numberWithDouble:41.524114];
    newClue.longitude = [NSNumber numberWithDouble:-93.603945];
    newClue.text = @"Although it's a bit of a dump, head to the place where I carried one of the black twins home through the hallway. Couldn't do that anymore!";
    newClue.hint = @"The ARL has plenty of kitties here. I know you watch the website like a hawk...";
    newClue.treasureHunt = defaultHunt;
    
    // clue #3
    newClue = [NSEntityDescription
               insertNewObjectForEntityForName:@"Clue"
               inManagedObjectContext:self.context];
    newClue.clueNumber = [NSNumber numberWithInt:3];
    newClue.geoFenceRangeInFeet = [NSNumber numberWithDouble:400.0];
    newClue.latitude = [NSNumber numberWithDouble:42.021374];
    newClue.longitude = [NSNumber numberWithDouble:-93.650550];
    newClue.text = @"Head to the establishment where we washed away the aches and pains of ninja class with piled high pies and deep fried delights.";
    newClue.hint = @"This place probably sends chickens into a pit of despair judging by how high the bones got piled up on your plate.";
    newClue.treasureHunt = defaultHunt;
    
    // clue #4
    newClue = [NSEntityDescription
               insertNewObjectForEntityForName:@"Clue"
               inManagedObjectContext:self.context];
    newClue.clueNumber = [NSNumber numberWithInt:4];
    newClue.geoFenceRangeInFeet = [NSNumber numberWithDouble:400.0];
    newClue.latitude = [NSNumber numberWithDouble:42.024690];
    newClue.longitude = [NSNumber numberWithDouble:-93.641295];
    newClue.text = @"Relive the experience of rotten dairy products by heading to the domicile where I picked up your pretty person on our first date. You'll have to bring your own milk this time.";
    newClue.hint = @"You were living here when we met, and you don't remember? I picked you up in the parking lot outside before we headed over to Hickory Park for our first date.";
    newClue.treasureHunt = defaultHunt;
    
    // clue #5
    newClue = [NSEntityDescription
               insertNewObjectForEntityForName:@"Clue"
               inManagedObjectContext:self.context];
    newClue.clueNumber = [NSNumber numberWithInt:5];
    newClue.geoFenceRangeInFeet = [NSNumber numberWithDouble:300.0];
    newClue.latitude = [NSNumber numberWithDouble:42.025425];
    newClue.longitude = [NSNumber numberWithDouble:-93.646045];
    newClue.text = @"Your sparkling treasure awaits at the place where the campus clock clangs on the hour. True Iowa Staters would understand.";
    newClue.hint = @"campanile-photo";
    newClue.treasureHunt = defaultHunt;      
    
    return;
}

- (NSArray *)getAllHunts
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // set entity for fetch request
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"TreasureHunt" 
                                   inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    // execute the fetch
    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

- (TreasureHunt *)getHuntByName:(NSString *)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // set entity for fetch request
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"TreasureHunt" 
                                   inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    // set predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"huntName ==[c] %@", name];
    [fetchRequest setPredicate:predicate];
    
    // execute the fetch
    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];

    for (TreasureHunt *hunt in fetchedObjects) {
        return hunt;
    }
    return nil;
}

- (TreasureHunt *)getDefaultHunt
{
    return [self getHuntByName:@"lindsey"];
}

@end
