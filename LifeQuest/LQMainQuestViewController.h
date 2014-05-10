//
//  LQMainQuestViewController.h
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "Quest.h"
#import "User.h"

@interface LQMainQuestViewController : LQViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* _questsThisWeek;
    NSMutableArray* _questsThisMonth;   
}

@property (strong, nonatomic) IBOutlet UITableView *mainQuestTableView;
@property (strong, nonatomic) IBOutlet User *currentUser;

@property (strong, nonatomic) IBOutlet UILabel *headerUsernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *headerExperienceLabel;

- (void)setUser:(User *)currentUser;

@end
