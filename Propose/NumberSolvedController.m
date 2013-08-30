//
//  NumberSolvedController.m
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "NumberSolvedController.h"
#import "ClueRepository.h"
#import "Clue.h"

@implementation NumberSolvedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    _huntRepo = [TreasureHuntRepository sharedRepo];
    _hunt = [_huntRepo getDefaultHunt];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([_hunt.clues count] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    
    // need to use a different reusable cell to get the checkmark for selected item
    if ([_hunt.cluesSolved integerValue] == indexPath.row) {
        cellIdentifier = @"SelectedCluesCell";
    } else {
        cellIdentifier = @"UnselectedCluesCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // configure the cell
    if (indexPath.row == 0) {
        cell.textLabel.text = @"None";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"1 Clue Solved";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%i Clues Solved", indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClueRepository *clueRepo = [ClueRepository sharedRepo];
    _hunt.cluesSolved = [NSNumber numberWithInteger:indexPath.row];
    
    // loop through all clues that are now solved and set the discover date to now if nil
    for (int i = 1; i <= indexPath.row; i++) {
        
        Clue *solvedClue = [clueRepo getClue:i];
        
        if (solvedClue.discoveryTime == nil) {
            solvedClue.discoveryTime = [NSDate date];
        }
    }
    
    // loop through all clues that should be unsolved and set discover date back to nil
    for (int i = (indexPath.row + 1); i <= [_hunt.clues count]; i++) {
        
        Clue *unsolvedClue = [clueRepo getClue:i];
        unsolvedClue.discoveryTime = nil;
    }
    
    [_huntRepo saveChanges];
    [self.tableView reloadData];
    
    return nil;
}

@end
