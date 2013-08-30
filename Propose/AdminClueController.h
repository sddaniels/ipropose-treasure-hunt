//
//  AdminClueController.h
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureHuntRepository.h"
#import "TreasureHunt.h"

@interface AdminClueController : UITableViewController {
    TreasureHuntRepository *_huntRepo;
    TreasureHunt *_hunt;
}

@end
