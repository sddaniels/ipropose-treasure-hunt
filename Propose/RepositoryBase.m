//
//  RepositoryBase.m
//  Propose
//
//  Created by Shea Daniels on 3/20/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "RepositoryBase.h"
#import "AppDelegate.h"

@implementation RepositoryBase

@synthesize managedObjectModel = _managedObjectModel;
@synthesize context = _context;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)init
{
    if (self = [super init])
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.managedObjectModel = appDelegate.managedObjectModel;
        self.context = appDelegate.managedObjectContext;
        self.persistentStoreCoordinator = appDelegate.persistentStoreCoordinator;
    }
    return self;
}

- (void)saveChanges
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

@end
