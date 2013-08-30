//
//  HintViewController.h
//  Propose
//
//  Created by Shea Daniels on 3/21/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clue.h"

@interface HintViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UITextView *hintText;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) Clue *clueData;

- (IBAction)backClick:(id)sender;

@end
