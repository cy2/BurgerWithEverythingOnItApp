//
//  NetworkControllerToStackOverflow
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/18/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkControllerToStackOverflow : NSObject

+(id)sharedService;



-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error))completionHandler;

-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler;

-(void)fetchMyUserProfile:(void (^)(NSArray *results, NSString *error))completionHandler;


@end
