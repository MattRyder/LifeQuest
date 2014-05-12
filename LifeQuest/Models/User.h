//
//  User.h
//  LifeQuest
//
//  Created by matt on 12/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend, QuestItem;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * experience_points;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *completedQuests;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) Friend *addedBy;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCompletedQuestsObject:(QuestItem *)value;
- (void)removeCompletedQuestsObject:(QuestItem *)value;
- (void)addCompletedQuests:(NSSet *)values;
- (void)removeCompletedQuests:(NSSet *)values;

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end
