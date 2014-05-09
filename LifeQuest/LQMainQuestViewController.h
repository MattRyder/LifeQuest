//
//  LQMainQuestViewController.h
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQMainQuestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* _questsThisWeek;
    NSMutableArray* _questsThisMonth;
}

@property (strong, nonatomic) IBOutlet UITableView *mainQuestTableView;

@end
