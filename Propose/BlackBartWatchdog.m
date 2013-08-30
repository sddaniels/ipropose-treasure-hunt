//
//  BlackBartWatchdog.m
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "BlackBartWatchdog.h"

#import "TreasureHuntRepository.h"
#import "TreasureHunt.h"

@implementation BlackBartWatchdog

@synthesize owner = _owner;

- (id)initWithOwner:(UIViewController*)owner
{
    if (self = [super init]) {
        self.owner = owner;
    }
    return self;
}

- (UIAlertView*)getLoginView
{
    UIAlertView *login = [[UIAlertView alloc] initWithTitle:@"Black Bart's Cave"
                                                    message:@"Enter the secret phrase if ye dare!" 
                                                   delegate:self.owner 
                                          cancelButtonTitle:@"Cancel" 
                                          otherButtonTitles:@"Enter", nil];
    login.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    return login;
}

- (UIAlertView*)getBadPasswordView
{
    UIAlertView *badPassword = [[UIAlertView alloc] initWithTitle:@"Incorrect Secret Phrase"
                                                          message:@"If ye don't know the secret phrase we're gonna have to make ye walk the plank!" 
                                                         delegate:self.owner
                                                cancelButtonTitle:@"OK" 
                                                otherButtonTitles:nil];
    return badPassword;
}

- (signed char)checkPassword:(UIAlertView*)alertView buttonIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Enter"]) {
        
        // check the password
        TreasureHuntRepository *huntRepo = [TreasureHuntRepository sharedRepo];
        TreasureHunt *hunt = [huntRepo getDefaultHunt];
        
        if ([[alertView textFieldAtIndex:0].text isEqualToString:hunt.adminPassword]){
            return YES;
        } else {
            return NO;
        }
    }
    
    return 2;
}

@end
