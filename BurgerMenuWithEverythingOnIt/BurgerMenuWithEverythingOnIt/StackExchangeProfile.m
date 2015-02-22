//
//  StackExchangeProfile.m
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/22/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "StackExchangeProfile.h"

@implementation StackExchangeProfile
+(NSArray *)profileDataFromJSON:(NSData *)jsonData {
    
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return nil;
    }
    
    NSArray *items = [jsonDictionary objectForKey:@"items"];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in items) {
        StackExchangeProfile *stackExchangeProfile = [[StackExchangeProfile alloc] init];
        stackExchangeProfile.userId = item[@"user_id"];
        stackExchangeProfile.userName = item[@"display_name"];
        stackExchangeProfile.profileURL = item[@"profile_image"];
        
        [temp addObject:stackExchangeProfile];
    }
    NSArray *final = [[NSArray alloc] initWithArray:temp];
    return final;
}

@end
