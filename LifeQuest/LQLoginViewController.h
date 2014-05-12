//
//  LQLoginViewController.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "LQMainQuestViewController.h"
#import "LQFriendsViewController.h"
#import "LQAPIManager.h"

@interface LQLoginViewController : LQViewController {
    UITextField *activeField;
    User *matchedUser;
    BOOL userLoggedIn;
}

@property (strong, nonatomic) IBOutlet UIScrollView *loginScrollView;
@property (strong, nonatomic) IBOutlet UITextField *textUsernameField;
@property (strong, nonatomic) IBOutlet UITextField *textPasswordField;

- (IBAction) loginButtonPressed;

@end
