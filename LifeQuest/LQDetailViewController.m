//
//  LQDetailViewController.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQDetailViewController.h"

@interface LQDetailViewController ()

@end

@implementation LQDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Try to find an existing QuestItem
    self.questItem = [self getMatchingQuestItem];
    
    // Jazz up the UI a little with some options:
    [self loadInterface];
    [self updateQuestItemDetails];
    
    // Setup CoreLocation for this Quest:
    [self setupLocation];
}

- (void)setupLocation
{
    // Can we actually use location on this device?:
    if ([CLLocationManager locationServicesEnabled]) {
        
        // Boot up the Location Manager to see where the user is:
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // QuestRegion: where they can be to check in:
        questRegion = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(self.detailQuest.latitude, self.detailQuest.longitude)
                                                                     radius:50 identifier:@"QuestRegion"];
        
        [locationManager startMonitoringForRegion:questRegion];
        [locationManager startUpdatingLocation];
        
        // Ask if they'll let LQ track them:
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
            [LQUtility showAlert:@"Location Denied" andMessage:@"Please allow LifeQuest to use Location Services in Settings" andCancelTitle:@"Dismiss"];
        }
    } else {
        // Encourage the user to go switch LocService on:
        [LQUtility showAlert:@"Location Disabled" andMessage:@"Location Services are disabled. Please enter Settings and turn on Location Services" andCancelTitle:@"Dismiss"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    BOOL canCheckIn = [questRegion containsCoordinate:[location coordinate]];
    
    self.checkInButton.enabled = canCheckIn && !self.questItem.completed;
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"INFO: In region for quest to check in");
    self.checkInButton.enabled = YES;
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"INFO: Left region for quest to check in");
    self.checkInButton.enabled = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [LQUtility showAlert:@"Can't find you!" andMessage:@"Location tracking failed to get your location." andCancelTitle:@"OK"];
}

// Loads some UI stuff that can't really be done via IB (via keypaths etc).
- (void)loadInterface
{
    // Increase the Progress View size 5x, and set the header background:
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0, 5.0)];
    [self setPurpleBackground:1];
    
    // Setup the border on the infoBox:
    self.infoView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.infoView.layer.borderWidth = 2;
    
    [[self navigationController] setNavigationBarHidden:NO];
}

- (void)updateQuestItemDetails
{
    //Setup the label data with the Quest Details:
    self.titleLabel.text = self.detailQuest.title;
    self.descriptionLabel.text = self.detailQuest.desc;
    self.progressLabel.text = [NSString stringWithFormat:@"%d / %d", [self.questItem.visits intValue], [self.detailQuest.visitsRequired intValue]];
    self.experienceLabel.text = [NSString stringWithFormat:@"%@", self.detailQuest.experiencePoints];
    
    float progress = [self.questItem.visits floatValue] / [self.detailQuest.visitsRequired floatValue];
    [self.progressView setProgress:progress animated:YES];
}

- (QuestItem *)getMatchingQuestItem
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"QuestItem" inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(linked_user == %@) AND (linked_quest == %@)", self.currentUser, self.detailQuest];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *matchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([matchedObjects count] == 0) {
        return nil;
    } else {
        return [matchedObjects objectAtIndex:0];
    }
}

- (IBAction)checkInButtonPressed:(id)sender
{
    NSError *error;
    if (self.questItem == nil) {
        // make a new item for this quest:
        self.questItem = (QuestItem*)[NSEntityDescription
                                insertNewObjectForEntityForName:@"QuestItem" inManagedObjectContext:[self managedObjectContext]];
        self.questItem.visits = [NSNumber numberWithInteger:1];
        self.questItem.linked_quest = self.detailQuest;
        self.questItem.linked_user = self.currentUser;
        
    } else {
        if ([NSNumber numberWithInteger:[self.questItem.visits intValue] + 1] <= self.detailQuest.visitsRequired) {
            self.questItem.visits = [NSNumber numberWithInteger:[self.questItem.visits intValue] + 1];
        }
        
        // Handle completionist logic:
        if (self.questItem.visits == self.detailQuest.visitsRequired) {
            self.currentUser.experience_points = @([self.currentUser.experience_points intValue] + [self.detailQuest.experiencePoints intValue]);
            self.questItem.completed = true;
            self.questItem.dateCompleted = [NSDate date];
            
            // upload to server:
            LQAPIManager *apiManager = [[LQAPIManager alloc] init];
            [apiManager updateExistingUser:self.currentUser];
            
            // Set the UI button to disabled:
            self.checkInButton.enabled = false;
        }
    }
    
    [managedObjectContext save:&error];
    
    // Redraw the UI to account for the update:
    [self updateQuestItemDetails];
    
    if (error != nil) {
        [LQUtility showAlert:@"Check In Failed" andMessage:@"Failed to check you in for this Quest. Please try again later." andCancelTitle:@"OK"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
