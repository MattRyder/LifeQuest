//
//  LQViewController.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQAppDelegate.h"

@interface LQViewController : UIViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)setPurpleBackground:(NSInteger)viewTag;

@end
