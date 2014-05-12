//
//  LQFriendDetailViewController.h
//  LifeQuest
//
//  Created by matt on 12/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQViewController.h"
#import "QuestItem.h"
#import "Quest.h"
#import "User.h"


@interface LQFriendDetailViewController : LQViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray* questsThisWeek;
    NSArray* questsThisMonth;
}

@property (strong, nonatomic) IBOutlet UILabel *headerUsernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *headerExperienceLabel;
@property (strong, nonatomic) IBOutlet UITableView *mainQuestTableView;

@property (strong, nonatomic) User *currentUser;


@end
