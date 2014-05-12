//
//  LQRegisterViewController.h
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "LQMainQuestViewController.h"
#import "LQFriendsViewController.h"
#import "LQAPIManager.h"
#import "Quest.h"


@interface LQRegisterViewController : LQViewController <NSFetchedResultsControllerDelegate> {
    UITextField *activeField;
    BOOL userRegistered;

    NSMutableArray *registrationElements;
}

@property (strong, nonatomic) IBOutlet UITextField *textUsername;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textPasswordConfirm;
@property (strong, nonatomic) IBOutlet UITextField *textEmailAddress;

@property (strong, nonatomic) IBOutlet UIScrollView *registrationScrollView;
@property (strong, nonatomic) User *registeredUser;

- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)openPrivacyPolicy:(id)sender;

@end
