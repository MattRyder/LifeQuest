//
//  LQViewController.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQViewController.h"

@interface LQViewController ()

@end

@implementation LQViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    LQAppDelegate *appDelegate = (LQAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setPurpleBackground:(NSInteger)viewTag
{
    // Load the purple tiled background image in the header view:
    UIImage* purpleTile = [UIImage imageNamed:@"purple-tile.png"];
    UIView* headerView = [self.view viewWithTag:viewTag];
    headerView.backgroundColor = [UIColor colorWithPatternImage:purpleTile];
}

@end
