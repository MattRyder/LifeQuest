//
//  LQAPIManager.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQUtility.h"
#import "User.h"

@interface LQAPIManager : NSObject

- (void)postRegisteredUser:(User *)newUser;

- (void)updateExistingUser:(User *)existingUser;

- (NSDictionary *)queryUserInfoWithUser:(NSString *)username andPassword:(NSString *)passwordHash;

- (User *)getUserFromRemoteDatabaseWithUsername:(NSString *)username andManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (User *)getUserFromRemoteDatabaseWithUsername:(NSString *)username andPassword:(NSString *)hashedPassword managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSArray *)queryLocalQuestsWithLatitude:(double)latitude andLongitude:(double)longitude;

- (NSData *)getServerResponseWithUri:(NSString *)uri;

@end
