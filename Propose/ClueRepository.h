//
//  ClueRepository.h
//  Propose
//
//  Created by Shea Daniels on 3/19/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepositoryBase.h"
#import "Clue.h"

@interface ClueRepository : RepositoryBase

+ (ClueRepository *)sharedRepo;

- (NSArray *)getAllClues;
- (Clue *)getClue:(int)clueNumber;

@end
