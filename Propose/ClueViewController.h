//
//  DataViewController.h
//  Propose
//
//  Created by Shea Daniels on 12/4/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Clue.h"

@interface ClueViewController : UIViewController <CLLocationManagerDelegate,UIAlertViewDelegate>
{
    BOOL _pointerSetForDisplay;
}

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UIImageView *thermPointer;
@property (weak, nonatomic) IBOutlet UITextView *clueText;
@property (weak, nonatomic) IBOutlet UILabel *debugText;
@property (weak, nonatomic) IBOutlet UILabel *solvedText;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Clue *clueData;

-(void) setPointer;

@end
