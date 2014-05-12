//
//  Friend.h
//  LifeQuest
//
//  Created by matt on 12/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Friend : NSManagedObject

@property (nonatomic, retain) User *friendOrigin; // The user who added the Friend
@property (nonatomic, retain) User *friendAdded;  // The user who was added

@end
