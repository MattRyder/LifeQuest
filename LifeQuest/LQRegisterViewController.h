//
//  LQRegisterViewController.h
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQRegisterViewController : UIViewController <NSFetchedResultsControllerDelegate> {
    UITextField *activeField;
    BOOL userRegistered;
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    NSMutableArray *registrationElements;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITextField *textUsername;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textPasswordConfirm;
@property (strong, nonatomic) IBOutlet UITextField *textEmailAddress;

@property (strong, nonatomic) IBOutlet UIScrollView *registrationScrollView;

- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)openPrivacyPolicy:(id)sender;

@end
