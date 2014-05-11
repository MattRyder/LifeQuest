//
//  LQAPIManager.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQAPIManager.h"

static NSString *host = @"localhost:3000";

@implementation LQAPIManager

- (void)postRegisteredUser:(User *)newUser
{
    NSError *error;
    NSDictionary *userDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        newUser.username, @"username",
                                        newUser.password, @"password",
                                        newUser.email, @"email", nil];
    
    NSURL *postUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api/users", host]];
    NSMutableURLRequest *webRequest = [[NSMutableURLRequest alloc] initWithURL:postUrl];
    NSData *webRequestData = [NSJSONSerialization dataWithJSONObject:userDataDictionary options:0 error:&error];
    NSString *requestDataLength = [NSString stringWithFormat:@"%lu", (unsigned long)[webRequestData length]];
    
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
    NSError *error;
    NSString *uri = [NSString stringWithFormat:@"http://%@/api/user_info?username=%@&password=%@", host, username, passwordHash];
    NSData *responseData = [self getServerResponseWithUri:uri];

    // Translate the NSData into readable JSON:
    NSArray *userArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    if ([userArray count] > 0) {
        NSDictionary *userData = [userArray objectAtIndex:0];
        return userData;
    }
    
    return nil;
}

- (NSArray *)queryLocalQuestsWithLatitude:(double)latitude andLongitude:(double)longitude
{
    NSError *error;
    NSString *uri = [NSString stringWithFormat:@"http://%@/api/local_quests?latitude=%f&longitude=%f", host, latitude, longitude];
    
    NSData *responseData = [self getServerResponseWithUri:uri];
    NSArray *questArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
    return questArray;
}

// Give it a URI to query, performs the request and returns the response:
- (NSData *)getServerResponseWithUri:(NSString *)uri
{
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
    
    return responseData;
}



@end
