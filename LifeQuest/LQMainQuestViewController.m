//
//  LQMainQuestViewController.m
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQMainQuestViewController.h"

@interface LQMainQuestViewController ()

@end

@implementation LQMainQuestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // hide navbar for this view:
    [[self navigationController] setNavigationBarHidden:YES];
    
    // Load up the username and total XP in the header:
    self.headerUsernameLabel.text = [NSString stringWithFormat:@"Hello, %@!", self.currentUser.username];
    self.headerExperienceLabel.text = [NSString stringWithFormat:@"You have %@ Experience Points.", self.currentUser.experience_points];
    
    // Load the purple tiled background image in the header view:
    [self setPurpleBackground:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Get a cell at a section and row of the Quest Table
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Quest *cellQuest;
    
    if(indexPath.section == 0)
    {
        cellQuest = [_questsThisWeek objectAtIndex:indexPath.row];
    }
    else
    {
        cellQuest = [_questsThisMonth objectAtIndex:indexPath.row];
    }
    
    ((UILabel *)[cell viewWithTag:2]).text = cellQuest.title;
    ((UILabel *)[cell viewWithTag:3]).text = cellQuest.description;
    ((UILabel *)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"%@", cellQuest.experiencePoints];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle;
    switch (section) {
        case 0:
            sectionTitle = @"Completed this week";
            break;
        case 1:
            sectionTitle = @"Completed this month";
            break;
        default:
            sectionTitle = @"";
    }
    
    return sectionTitle;
}

// Return the number of sections in the Quest Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// Return the number of rows in a section of the Quest Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = [_questsThisWeek count];
            break;
        case 1:
            rows = [_questsThisMonth count];
            break;
    }
    
    return rows;
}

- (void)setUser:(User *)currentUser
{
    self.currentUser = currentUser;
}


// Load all the data from the JSON/static data, whatever here
- (void) setupQuestTable
{

}

@end
