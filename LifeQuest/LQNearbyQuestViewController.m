//
//  LQNearbyQuestViewController.m
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQNearbyQuestViewController.h"

@interface LQNearbyQuestViewController ()

@end

@implementation LQNearbyQuestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self setupLocation];
    _mapView.showsUserLocation = YES;
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
        [locationManager startUpdatingLocation];
        
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
    CLLocation *location = (CLLocation *)[locations objectAtIndex:0];
    NSLog(@"Location: %f, %f", location.coordinate.latitude, location.coordinate.longitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    [_mapView setRegion:region animated:YES];
    
    LQAPIManager *apiManager = [[LQAPIManager alloc] init];
    NSArray *quests = [apiManager queryLocalQuestsWithLatitude:location.coordinate.latitude andLongitude:location.coordinate.longitude];
    
    // Parse that data into usable Quest objects:
    nearbyQuests = [self parseDataIntoQuests:quests];
    [self.questTable reloadData];
    
    // Turn off location now, we've got the locale:
    [locationManager stopUpdatingLocation];
}

// Parse the JSON response into Quests
- (NSMutableArray *)parseDataIntoQuests:(NSArray *)questDictionaries
{   
    NSMutableArray *parsedQuests = [[NSMutableArray alloc] init];
    
    for (NSDictionary *qd in questDictionaries) {
        Quest *quest = (Quest*)[NSEntityDescription
                                insertNewObjectForEntityForName:@"Quest"
                                inManagedObjectContext:[self managedObjectContext]];
        
        quest.title = [qd objectForKey:@"title"];
        quest.desc = [qd objectForKey:@"desc"];
        quest.experiencePoints = [qd objectForKey:@"points"];
        quest.latitude = [[qd objectForKey:@"latitude"] doubleValue];
        quest.longitude = [[qd objectForKey:@"longitude"] doubleValue];
        quest.dateCreated = [qd objectForKey:@"dateCreated"];
        
        [parsedQuests addObject:quest];
    }
    
    return parsedQuests;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NearbyToDetailViewSegue"]) {
        NSIndexPath *indexPath = [self.questTable indexPathForSelectedRow];
        Quest *selectedQuest = nearbyQuests[indexPath.row];
        [[segue destinationViewController] setDetailQuest:selectedQuest];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Quest *cellQuest = [nearbyQuests objectAtIndex:indexPath.row];
    cell.textLabel.text = cellQuest.title;
    cell.detailTextLabel.text = cellQuest.desc;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nearbyQuests count];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        return; // already handled in setupLocation above
    }
    
    [LQUtility showAlert:@"Error" andMessage:@"Failed to get your location." andCancelTitle:@"OK"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
