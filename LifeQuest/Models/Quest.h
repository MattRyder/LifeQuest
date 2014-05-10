//
//  Quest.h
//  LifeQuest
//
//  Created by matt on 08/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Quest : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * experiencePoints;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSSet *completedUsers;
@end

@interface Quest (CoreDataGeneratedAccessors)

- (void)addCompletedUsersObject:(User *)value;
- (void)removeCompletedUsersObject:(User *)value;
- (void)addCompletedUsers:(NSSet *)values;
- (void)removeCompletedUsers:(NSSet *)values;

@end
