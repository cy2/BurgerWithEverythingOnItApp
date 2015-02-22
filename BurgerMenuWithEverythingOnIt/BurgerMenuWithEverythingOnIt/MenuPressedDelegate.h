//
//  MenuPressedDelegate.h
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/18/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end
