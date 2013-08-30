//
//  IntroductionViewController.h
//  Propose
//
//  Created by Shea Daniels on 12/11/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainText1;
@property (weak, nonatomic) IBOutlet UILabel *mainText2;
@property (weak, nonatomic) IBOutlet UILabel *flipText;

- (IBAction)piClick:(id)sender;

@end
