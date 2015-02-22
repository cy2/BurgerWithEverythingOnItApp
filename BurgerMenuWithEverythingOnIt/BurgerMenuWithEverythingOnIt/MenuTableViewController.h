//
//  MenuTableViewController.h
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/16/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuPressedDelegate.h"



/*
thursday: create the enum

enum Style{
    cool,
    notCool,
    rad,
    stupid
};


typedef enum {
    cool,
    notCool,
    rad,
    stupid
} greeting;
*/

// declare a typedef void () nsarray for a completion handeler

//swift typedef is alias

@interface MenuTableViewController : UITableViewController

@property (weak,nonatomic) id<MenuPressedDelegate> delegate;

@end
