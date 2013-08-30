//
//  TreasureHuntRepository.h
//  Propose
//
//  Created by Shea Daniels on 3/19/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepositoryBase.h"
#import "TreasureHunt.h"

@interface TreasureHuntRepository : RepositoryBase

+ (TreasureHuntRepository *)sharedRepo;

- (void)addDefaultHunt;
- (NSArray *)getAllHunts;
- (TreasureHunt *)getHuntByName:(NSString *)name;
- (TreasureHunt *)getDefaultHunt;

@end
