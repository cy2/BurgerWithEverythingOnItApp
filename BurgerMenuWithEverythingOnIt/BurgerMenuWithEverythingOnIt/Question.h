//
//  Question.h
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/18/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Question : NSObject

+(NSArray *)questionsFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *avatarURL;
@property (strong,nonatomic) UIImage *image;

@end
