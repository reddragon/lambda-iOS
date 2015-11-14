//
//  HamburgerViewController.h
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

@interface HamburgerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *hamburgerContainerView;
- (id)initWithDelegate:(id<HamburgerMenuDelegate>)delegate;
@end
