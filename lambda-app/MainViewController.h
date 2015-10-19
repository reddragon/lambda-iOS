//
//  MainViewController.h
//  eclisp-app
//
//  Created by Gaurav Menghani on 8/30/15.
//  Copyright (c) 2015 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HelperViewController.h"


@protocol HamburgerMenuDelegate <NSObject>
- (void)toggleMenu;
@end

@interface MainViewController : UIViewController <UITextFieldDelegate, HelperButtonDelegate>
- (id)initWithDelegate:(id<HamburgerMenuDelegate>)delegate;
- (NSString*)evaluate:(NSString*)expr;
- (void)handleButton:(ButtonType)buttonType;
@end
