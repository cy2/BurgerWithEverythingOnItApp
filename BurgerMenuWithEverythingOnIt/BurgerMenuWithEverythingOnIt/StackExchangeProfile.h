//
//  StackExchangeProfile.h
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/22/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackExchangeProfile : NSObject

+(NSArray *)profileDataFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *userName;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *profileURL;

@end
