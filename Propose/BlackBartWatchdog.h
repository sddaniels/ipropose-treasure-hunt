//
//  BlackBartWatchdog.h
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlackBartWatchdog : NSObject

@property (weak, nonatomic) UIViewController *owner;

- (id)initWithOwner:(UIViewController*)owner;
- (UIAlertView*)getLoginView;
- (UIAlertView*)getBadPasswordView;
- (signed char)checkPassword:(UIAlertView*)alertView buttonIndex:(NSInteger)buttonIndex;

@end
