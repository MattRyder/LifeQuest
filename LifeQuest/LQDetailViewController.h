//
//  LQDetailViewController.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LQAPIManager.h"
#import "LQUtility.h"
#import "LQViewController.h"
#import "LQMainQuestViewController.h"
#import "QuestItem.h"

@interface LQDetailViewController : LQViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLCircularRegion *questRegion;
}

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIView *infoView;

@property (strong, nonatomic) IBOutlet UILabel *experienceLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkInButton;

@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) Quest *detailQuest;
@property (strong, nonatomic) QuestItem *questItem;

- (IBAction)checkInButtonPressed:(id)sender;

@end
