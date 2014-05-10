//
//  LQLoginViewController.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQLoginViewController.h"

@interface LQLoginViewController ()

@end

@implementation LQLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setPurpleBackground:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) loginButtonPressed
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    NSString *hashedPassword = [LQUtility generateSHA1Hash:self.textPasswordField.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(username = %@) AND (password = %@)", self.textUsernameField.text, hashedPassword];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    NSArray *matchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([matchedObjects count] == 0) {
        [LQUtility showAlert:@"Login Failed" andMessage:@"Please check the username and password, and try again." andCancelTitle:@"OK"];
    } else {
        matchedUser = [matchedObjects objectAtIndex:0];
        [LQUtility showAlert:@"HAVE A USER!" andMessage:@"FOUND!" andCancelTitle:@"WOO!"];
        userLoggedIn = true;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"LoginToMainSegue"] && userLoggedIn) {
        return YES;
    } else if([identifier isEqualToString:@"LoginToRegisterSegue"]) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LoginToMainSegue"]) {
        LQMainQuestViewController *mainController = [[LQMainQuestViewController alloc] init];
        UITabBarController *tabController = [segue destinationViewController];
        mainController = (LQMainQuestViewController *)[[tabController customizableViewControllers] objectAtIndex:0];
        [mainController setUser: matchedUser];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)registerForKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the "Show Keyboard" notification is sent
- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keybSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint fieldOrigin = activeField.frame.origin;
    CGFloat fieldHeight = activeField.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keybSize.height;
    
    if (!CGRectContainsPoint(visibleRect, fieldOrigin)) {
        CGPoint scrollPoint = CGPointMake(0.0, fieldOrigin.y - visibleRect.size.height + (2 * fieldHeight));
        [self.loginScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the "Hide Keyboard" notification is sent
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    [self.loginScrollView setContentOffset:CGPointZero animated:YES];
}

// Used to grab the field that's being edited now:
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

// Used to reset the active field when we're finished with it:
- (void)textFieldDidFinishEditing:(UITextField *)textField
{
    activeField = nil;
}

@end
