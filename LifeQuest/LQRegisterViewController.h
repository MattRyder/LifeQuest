//
//  LQRegisterViewController.h
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "LQUtility.h"
#import "Quest.h"
#import "User.h"
#import "LQMainQuestViewController.h"

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
@property (strong, nonatomic) IBOutlet User *registeredUser;

- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)openPrivacyPolicy:(id)sender;

@end
