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
- (NSDictionary *)queryUserInfoWithUser:(NSString *)username andPassword:(NSString *)passwordHash;

@end
