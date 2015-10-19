//
//  ContainerViewController.h
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

@interface ContainerViewController : UIViewController<HamburgerMenuDelegate>
- (void)toggleMenu;
@end
