//
//  LQFriendsViewController.m
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQFriendsViewController.h"

@interface LQFriendsViewController ()

@end

@implementation LQFriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupFriendTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Friend *selectedFriend = [friends objectAtIndex:[self.friendTable indexPathForSelectedRow].row];
    User *selectedUser = selectedFriend.friendAdded;
    
    [[segue destinationViewController] setCurrentUser:selectedUser];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Friend *cellFriend = [friends objectAtIndex:indexPath.row];
    User *friendUser = [self getUserForUsername:[[cellFriend friendAdded] username]];
    ((UILabel *)[cell viewWithTag:1]).text = friendUser.username;
    ((UILabel *)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"%@", friendUser.experience_points];
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friends count];
}

- (IBAction)addFriendClicked:(id)sender
{
    UIAlertView *friendPopup = [[UIAlertView alloc] initWithTitle:@"Add Friend" message:@"Enter friend's username:"
                                                         delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    friendPopup.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [friendPopup show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *friendUsername = [[alertView textFieldAtIndex:0] text];
        [self addFriend:friendUsername];
        [self.friendTable reloadData];
    }
}

-(User *)getUserForUsername:(NSString *)username
{
    NSError *error;
    NSArray *friendRequestData;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    // First, we'll need the Friend object for this user:
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:[self managedObjectContext]]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(username = %@)", username]];
    friendRequestData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([friendRequestData count] == 0) {
        // Try the API for a response:
        LQAPIManager *apiManager = [[LQAPIManager alloc] init];
        User *apiUser = [apiManager getUserFromRemoteDatabaseWithUsername:username andManagedObjectContext:[self managedObjectContext]];
        
        return apiUser;
    }
    
    // Otherwise, return the local user:
    return [friendRequestData objectAtIndex:0];
}

- (void)addFriend:(NSString *)username
{
    User *friendUser;
    NSArray *friendRequestData;
    Friend *friendship;
    
    // First, they're not adding themselves, are they?
    if ([username isEqualToString:self.currentUser.username]) {
        [LQUtility showAlert:@"Add Friend" andMessage:@"You cannot add yourself as a Friend" andCancelTitle:@"OK"];
        return;
    }
    
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    friendUser = [self getUserForUsername:username];
    
    if (friendUser == nil) {
        [LQUtility showAlert:@"Add Friend" andMessage:@"Cannot find that user" andCancelTitle:@"OK"];
        return;
    }
    
    // so they exist, does the friendship already exist?
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(friendOrigin = %@) AND (friendAdded == %@)", self.currentUser, friendUser]];
    friendRequestData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([friendRequestData count] != 0) {
        [LQUtility showAlert:@"Add Friend" andMessage:@"Friend already added" andCancelTitle:@"OK"];
        return;
    };
    
    // They exist and aren't friend right now, so add them!
    friendship = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:[self managedObjectContext]];
    friendship.friendOrigin = self.currentUser;
    friendship.friendAdded = friendUser;
    
    [managedObjectContext save:&error];
    
    if (!error) {
        [self setupFriendTable];
        [self.friendTable reloadData];
    }
    
}

- (void)setupFriendTable
{
    NSError *error;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:[self managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(friendOrigin = %@)", self.currentUser]];
    
    
    friends = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


@end
