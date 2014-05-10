//
//  LQUtility.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface LQUtility : NSObject

+ (NSString *)generateSHA1Hash:(NSString *)base;
+ (void) showAlert:(NSString *)title andMessage:(NSString *)message andCancelTitle:(NSString *)cancelTitle;

@end
