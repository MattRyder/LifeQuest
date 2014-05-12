//
//  LQFriendsViewController.h
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "LQAPIManager.h"
#import "User.h"
#import "Friend.h"


@interface LQFriendsViewController : LQViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    NSArray *friends;
}

@property (strong, nonatomic) IBOutlet UITableView *friendTable;

@property (strong, nonatomic) User* currentUser;

- (IBAction)addFriendClicked:(id)sender;

@end
