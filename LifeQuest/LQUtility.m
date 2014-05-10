//
//  LQUtility.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQUtility.h"

@implementation LQUtility

+ (NSString *)generateSHA1Hash:(NSString *)base
{
    NSData *passwordData = [base dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t hashDigest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(passwordData.bytes, passwordData.length, hashDigest);
    NSMutableString *hashedPass = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    
    // Write out the digest to a string that we can shove into Core Data / remote database:
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hashedPass appendFormat:@"%02x", hashDigest[i]];
    }
    
    return hashedPass;
}

+ (void) showAlert:(NSString *)title andMessage:(NSString *)message andCancelTitle:(NSString *)cancelTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
                                                   delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
    [alert show];
}

@end
