//
//  Quest.h
//  LifeQuest
//
//  Created by matt on 11/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuestItem;

@interface Quest : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * experiencePoints;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * visitsRequired;
@property (nonatomic, retain) QuestItem *usersCompleted;

@end
