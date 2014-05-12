//
//  LQFriendDetailViewController.m
//  LifeQuest
//
//  Created by matt on 12/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQFriendDetailViewController.h"

@interface LQFriendDetailViewController ()

@end

@implementation LQFriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupInterfaceLabels];
    [self setupQuestTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupInterfaceLabels
{
    // Load up the username and total XP in the header:
    self.headerUsernameLabel.text = [NSString stringWithFormat:@"%@", self.currentUser.username];
    self.headerExperienceLabel.text = [NSString stringWithFormat:@"%@", self.currentUser.experience_points];
}

- (void)setupQuestTable
{
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"QuestItem" inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *weekPredicate = [NSPredicate predicateWithFormat:@"(linked_user = %@) AND (dateCompleted > %@ AND dateCompleted < %@)",
                                  self.currentUser, [[NSDate date] dateByAddingTimeInterval:-604800], [NSDate date]];
    NSPredicate *monthPredicate = [NSPredicate predicateWithFormat:@"(linked_user = %@) AND (dateCompleted > %@ AND dateCompleted < %@)",
                                   self.currentUser, [[NSDate date] dateByAddingTimeInterval:-2.62974e6], [NSDate date]];
    
    [fetchRequest setPredicate:weekPredicate];
    questsThisWeek = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest setPredicate:monthPredicate];
    questsThisMonth = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

// Get a cell at a section and row of the Quest Table
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendQuestCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Quest *cellQuest;
    if(indexPath.section == 0)
    {
        cellQuest = [[questsThisWeek objectAtIndex:indexPath.row] linked_quest];
    }
    else
    {
        cellQuest = [[questsThisMonth objectAtIndex:indexPath.row] linked_quest];
    }
    
    ((UILabel *)[cell viewWithTag:2]).text = cellQuest.title;
    ((UILabel *)[cell viewWithTag:3]).text = cellQuest.desc;
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
            rows = [questsThisWeek count];
            break;
        case 1:
            rows = [questsThisMonth count];
            break;
    }
    
    return rows;
}



@end
