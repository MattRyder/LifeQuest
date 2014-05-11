//
//  QuestItem.h
//  LifeQuest
//
//  Created by matt on 11/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quest, User;

@interface QuestItem : NSManagedObject

@property (nonatomic, retain) NSNumber * visits;
@property (nonatomic, retain) NSNumber * totalRequiredVisits;
@property (nonatomic, retain) User *linked_user;
@property (nonatomic, retain) Quest *linked_quest;

@end
