//
//  AdminClueController.m
//  Propose
//
//  Created by Shea Daniels on 3/25/12.
//  Copyright (c) 2012 Fubzy. All rights reserved.
//

#import "AdminClueController.h"

#import "ClueRepository.h"
#import "Clue.h"
#import "ClueCell.h"
#import "AdminClueDetailController.h"

@implementation AdminClueController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ClueDetailSegue"]) {
        
        // find the appropriate clue
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger clueNumber = indexPath.row + 1;
        
        ClueRepository *clueRepo = [ClueRepository sharedRepo];
        Clue *clueData = [clueRepo getClue:clueNumber];
        
        // set the new view controller
        AdminClueDetailController *detailController = segue.destinationViewController;
        detailController.clueData = clueData;
    }
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

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
    return [_hunt.clues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ClueCell";
    
    ClueCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ClueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // retrieve the clue for the cell
    NSInteger clueNumber = indexPath.row + 1;
    ClueRepository *clueRepo = [ClueRepository sharedRepo];
    Clue *cellClue = [clueRepo getClue:clueNumber];
    
    // configure the cell
    cell.clueNumberLabel.text = [NSString stringWithFormat:@"Clue %i", clueNumber];
    cell.clueTextLabel.text = cellClue.text;
    
    return cell;
}

@end
