//
//  RepositoryBase.h
//  Propose
//
//  Created by Shea Daniels on 3/20/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryBase : NSObject

@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveChanges;

@end
