//
//  User.h
//  LifeQuest
//
//  Created by matt on 09/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;

@end
