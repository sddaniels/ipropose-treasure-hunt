//
//  RootViewController.h
//  Propose
//
//  Created by Shea Daniels on 12/4/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
