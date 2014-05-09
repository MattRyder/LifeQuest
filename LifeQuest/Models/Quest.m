//
//  Quest.m
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "Quest.h"
#import "User.h"


@implementation Quest

@dynamic desc;
@dynamic experiencePoints;
@dynamic title;
@dynamic dateCreated;
@dynamic completedUsers;

// Initialize a Quest with a Title
- (Quest *)initWithTitle: (NSString *)title
{
    Quest *quest = (Quest *)[NSEntityDescription
                             insertNewObjectForEntityForName:@"Quest"
                             inManagedObjectContext:[self managedObjectContext]];
    quest.title = title;
    
    return quest;
}

// Initialize Quest with a Title and Description
- (Quest *)initWithTitle: (NSString *)title andDescription: (NSString *)description
{
    Quest *quest = (Quest *)[NSEntityDescription
                             insertNewObjectForEntityForName:@"Quest"
                             inManagedObjectContext:[self managedObjectContext]];
    quest.title = title;
    quest.desc = description;
    
    return quest;
}

//Initialize a Quest with a Title, Description and Experience Points.
- (Quest *)initWithTitle: (NSString *)title andDescription: (NSString *)description andExperience: (NSNumber *) xp
{
    Quest *quest = (Quest *)[NSEntityDescription
                             insertNewObjectForEntityForName:@"Quest"
                             inManagedObjectContext:[self managedObjectContext]];
    quest.title = title;
    quest.desc = description;
    quest.experiencePoints = xp;
    
    return quest;
}




@end
