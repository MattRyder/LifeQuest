//
//  LQRegisterViewController.m
//  LifeQuest
//
//  Created by matt on 06/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQRegisterViewController.h"
#import "User.h"
#import <CommonCrypto/CommonDigest.h>

@interface LQRegisterViewController ()

@end

@implementation LQRegisterViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set all registration elements on the view:
    registrationElements = [[NSMutableArray alloc] initWithObjects:
                            self.textUsername, self.textPassword, self.textPasswordConfirm, self.textEmailAddress,
                            nil];
    
    // Register the view to grab keyboard notifications:
    [self registerForKeyboardNotification];
    
    // Load the purple tiled background image:
    UIImage* purpleTile = [UIImage imageNamed:@"purple-tile.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:purpleTile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlert:(NSString *)title andMessage:(NSString *)message andCancelTitle:(NSString *)cancelTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
                                              delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)registerButtonPressed:(id)sender
{
    User *newUser = (User*)[NSEntityDescription
                            insertNewObjectForEntityForName:@"User"
                            inManagedObjectContext:[self managedObjectContext]];
    
    newUser.username = self.textUsername.text;
    newUser.email = self.textEmailAddress.text;
    
    // Ensure that no fields are left blank:
    for (UITextField *textField in registrationElements) {
        if ([textField.text isEqualToString:@""]) {
            [self showAlert:@"Empty Field" andMessage:[NSString stringWithFormat:@"%@ is required to be entered.", textField.placeholder] andCancelTitle:@"OK"];
            return;
        }
    }
    
    // If the passwords are okay, SHA-1 it and store it in the CD object:
    if ([self.textPassword.text isEqualToString:self.textPasswordConfirm.text]) {
        NSData *passwordData = [self.textPassword.text dataUsingEncoding:NSUTF8StringEncoding];
        uint8_t hashDigest[CC_SHA1_DIGEST_LENGTH];
        
        CC_SHA1(passwordData.bytes, passwordData.length, hashDigest);
        NSMutableString *hashedPass = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
        
        // Write out the digest to a string that we can shove into Core Data / remote database:
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [hashedPass appendFormat:@"%02x", hashDigest[i]];
        }
        
        newUser.password = hashedPass;
        
        NSError *error;
        if ([self.managedObjectContext save:&error]) {
            userRegistered = true;
        }
        
        
    } else {
        [self showAlert:@"Password Mismatch" andMessage:@"Please confirm that both passwords are entered correctly." andCancelTitle:@"OK"];
    }
}

- (IBAction)openPrivacyPolicy:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://lifequest.herokuapp.com/privacy"]];
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"UserRegisteredSegue"] && userRegistered) {
        return YES;
    }
    
    return NO;
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
        [self.registrationScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the "Hide Keyboard" notification is sent
- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    [self.registrationScrollView setContentOffset:CGPointZero animated:YES];
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
