//
//  RootViewController.m
//  Propose
//
//  Created by Shea Daniels on 12/4/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "RootViewController.h"
#import "PageViewControllerDataSource.h"
#import "ClueViewController.h"

@interface RootViewController ()
@property (readonly, strong, nonatomic) PageViewControllerDataSource *controllerDataSource;
@end

@implementation RootViewController

@synthesize pageViewController = _pageViewController;
@synthesize controllerDataSource = _controllerDataSource;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIControl class]]) {
        // user touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    self.pageViewController.delegate = self;
    
    UIViewController *startingViewController = [self.controllerDataSource viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = [NSArray arrayWithObject:startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.controllerDataSource;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // set the page view controller's bounds so that self's view is visible on the bottom edge
    CGRect pageViewRect = self.view.bounds;
    pageViewRect.size.height = pageViewRect.size.height - 15;
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];    
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    // make this object the delegate for the tap gesture recognizer so we can avoid accidentally consuming what should be button clicks
    for (UIGestureRecognizer *rec in self.view.gestureRecognizers) {
        if ([rec isKindOfClass:[UITapGestureRecognizer class]]) {
            rec.delegate = self;
        }
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // don't know if this is necessary, but it makes me feel better for the time being
    UIWindow *parent = (UIWindow *) [[UIApplication sharedApplication] delegate].window;
    parent.rootViewController = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (PageViewControllerDataSource *)controllerDataSource
{
    /*
     Return the model controller object, creating it if necessary.
     In more complex implementations, the model controller may be passed to the view controller.
     */
    if (!_controllerDataSource) {
        _controllerDataSource = [[PageViewControllerDataSource alloc] init];
    }
    return _controllerDataSource;
}

#pragma mark - UIPageViewController delegate methods

 - (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
 {
     if (completed) {
         if ([[pageViewController.viewControllers objectAtIndex:0] isKindOfClass:[ClueViewController class]]) {
         
             ClueViewController *clueController = (ClueViewController*)[pageViewController.viewControllers objectAtIndex:0];
             [clueController setPointer];
         }
     }
 }
 

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

@end
