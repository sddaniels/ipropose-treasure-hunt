//
//  ModelController.h
//  Propose
//
//  Created by Shea Daniels on 12/5/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageViewControllerDataSource : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;

@end
