//
//  LQNearbyQuestViewController.h
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LQViewController.h"
#import "LQDetailViewController.h"
#import "LQAPIManager.h"
#import "LQUtility.h"
#import "Quest.h"

@interface LQNearbyQuestViewController : LQViewController <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
    CLLocationManager *locationManager;
    NSMutableArray *nearbyQuests;
}

@property (strong, nonatomic) IBOutlet UITableView *questTable;

@end
