//
//  ModelController.m
//  Propose
//
//  Created by Shea Daniels on 12/5/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "PageViewControllerDataSource.h"

#import "IntroductionViewController.h"
#import "InstructionsViewController.h"
#import "ClueViewController.h"
#import "EngageController.h"
#import "TreasureHuntRepository.h"
#import "ClueRepository.h"
#import "Clue.h"

/*
 This controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@implementation PageViewControllerDataSource

- (id)init
{
    if (self = [super init]) {
        //TreasureHuntRepository *huntRepo = [TreasureHuntRepository sharedRepo];
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    TreasureHuntRepository *huntRepo = [TreasureHuntRepository sharedRepo];
    ClueRepository *clueRepo = [ClueRepository sharedRepo];
    
    TreasureHunt  *defaultHunt = [huntRepo getDefaultHunt]; // todo: this will need to be changed to something more general later
    
    // return nil if we're out of pages
    NSUInteger offset;
    if ([defaultHunt.cluesSolved integerValue] == [defaultHunt.clues count]) {
        offset = 2;
    } else {
        offset = 1;
    }
    
    if (index > ([defaultHunt.clues count] + offset)) {
        return nil;
    }
    
    // return nil if debug mode is off and a clue shouldn't be revealed yet
    if (![defaultHunt.debugModeOn boolValue] && (index > ([defaultHunt.cluesSolved integerValue] + 2))) {
        return nil;
    }
    
    // return one of the two defined view controllers if necessary
    if (index == 0) {
        
        IntroductionViewController *introViewController = [storyboard instantiateViewControllerWithIdentifier:@"IntroductionView"];
        return introViewController;
        
    } else if (index == 1) {
        
        InstructionsViewController *instructionsViewController = [storyboard instantiateViewControllerWithIdentifier:@"InstructionsView"];
        return instructionsViewController;
    
    } else if (index == ([defaultHunt.clues count] + 2)) {
        
        EngageController *engageController = [storyboard instantiateViewControllerWithIdentifier:@"EngageView"];
        return engageController;
        
    } else {
        
        // create a new view controller and pass suitable data.
        ClueViewController *clueViewController = [storyboard instantiateViewControllerWithIdentifier:@"ClueView"];
        clueViewController.clueData = [clueRepo getClue:(index - 1)];
        return clueViewController;
    }
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    
    // the first two views are always defined
    if ([viewController isKindOfClass:[IntroductionViewController class]]) {
        
        return 0;
        
    } else if ([viewController isKindOfClass:[InstructionsViewController class]]) {
        
        return 1;
        
    } else if ([viewController isKindOfClass:[ClueViewController class]]) {
        
        ClueViewController *clueController = (ClueViewController*)viewController;
        return [clueController.clueData.clueNumber intValue] + 1;
        
    } else if ([viewController isKindOfClass:[EngageController class]]) {
        
        TreasureHuntRepository *huntRepo = [TreasureHuntRepository sharedRepo];
        TreasureHunt  *defaultHunt = [huntRepo getDefaultHunt]; // todo: this will need to be changed to something more general later
        
        return [defaultHunt.clues count] + 2;
        
    } else {
        
        return NSNotFound;
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
