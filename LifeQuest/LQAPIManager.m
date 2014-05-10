//
//  LQAPIManager.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQAPIManager.h"

@implementation LQAPIManager

- (void)postRegisteredUser:(User *)newUser
{
    NSError *error;
    NSDictionary *userDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        newUser.username, @"username",
                                        newUser.password, @"password",
                                        newUser.email, @"email", nil];
    
    
    NSURL *postUrl = [NSURL URLWithString:@"http://localhost:3000/api/users"];
    NSMutableURLRequest *webRequest = [[NSMutableURLRequest alloc] initWithURL:postUrl];
    NSData *webRequestData = [NSJSONSerialization dataWithJSONObject:userDataDictionary options:0 error:&error];
    NSString *requestDataLength = [NSString stringWithFormat:@"%d", [webRequestData length]];
    
    if(!error) {
        [webRequest setHTTPMethod:@"POST"];
        [webRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [webRequest setValue:requestDataLength forHTTPHeaderField:@"Content-Length"];
        [webRequest setHTTPBody: webRequestData];
        
        [NSURLConnection connectionWithRequest:webRequest delegate:self];
    }
}

- (NSDictionary *)queryUserInfoWithUser:(NSString *)username andPassword:(NSString *)passwordHash
{
    NSString *uri = [NSString stringWithFormat:@"http://localhost:3000/api/user_info?username=%@&password=%@", username, passwordHash];
    NSURL *requestUrl = [NSURL URLWithString:uri];
    
    NSMutableURLRequest *webRequest = [NSMutableURLRequest requestWithURL:requestUrl];
    [webRequest setHTTPMethod:@"GET"];
    
    NSError *error;
    NSURLResponse *webResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:webRequest returningResponse:&webResponse error:&error];
    
    if (error)
    {
        NSLog(@"Error encountered trying to talk to the LifeQuest API!");
        return nil;
    }
    
    // Translate the NSData into readable JSON:
    NSArray *userArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *userData = [userArray objectAtIndex:0];
    return userData;
}



@end
