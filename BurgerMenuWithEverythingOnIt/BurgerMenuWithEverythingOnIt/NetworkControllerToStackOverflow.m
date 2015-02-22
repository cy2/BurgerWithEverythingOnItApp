//
//  StackOverflowService.m
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/18/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//
//Created account in  http://stackapps.com/apps/oauth/view/4278


#import "NetworkControllerToStackOverflow.h"
#import "Question.h"

@implementation NetworkControllerToStackOverflow


+(id)sharedService {
    NSLog(@" StackOverflowService > sharedService fired");
    
    static NetworkControllerToStackOverflow *mySharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedService = [[NetworkControllerToStackOverflow alloc] init];
    });
    return mySharedService;
}

-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error))completionHandler {
    NSLog(@" StackOverflowService > fetchQuestionsWithSearchTerm fired");
    
    
    NSString *urlString = @"https://api.stackexchange.com/2.2/";
    urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
    urlString = [urlString stringByAppendingString:searchTerm];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    NSLog(@"token = %@",token);
    if (token) {
        urlString = [urlString stringByAppendingString:@"&access_token="];
        urlString = [urlString stringByAppendingString:token];
        urlString = [urlString stringByAppendingString:@"*3sAmY3X0VF6I22Fe0QvTQ(("];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completionHandler(nil,@"Could not connect");
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = httpResponse.statusCode;
            
            switch (statusCode) {
                case 200 ... 299: {
                    NSLog(@"%ld",(long)statusCode);
                    NSArray *results = [Question questionsFromJSON:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
 
                        if (results) {
                            completionHandler(results,nil);
                        } else {
                            completionHandler(nil,@"Search could not be completed");
                        }
 
                    });
                    break;
                }
                default:
                    NSLog(@"%ld",(long)statusCode);
                    break;
            }
            
            NSLog(@"the returned status code is %ld",(long)statusCode);
            
            
        }
    }];
    [dataTask resume];
}

-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler {

    NSLog(@" StackOverflowService > fetchUserImage fired");
    
    dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_async(imageQueue, ^{
        NSURL *url = [NSURL URLWithString:avatarURL];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(image);
        });
    });
}

@end
