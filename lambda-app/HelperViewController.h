//
//  HelperViewController.h
//  lambda
//
//  Created by Gaurav Menghani on 10/13/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ButtonType {
    kOpenBracket,
    kClosedBracket,
    kAdd,
    kSubtract,
    kMultiply,
    kDivide,
    kDefvar,
    kDefun,
    kRepeat
} ButtonType;

@protocol HelperButtonDelegate <NSObject>

- (void)handleButton:(ButtonType)buttonType;

@end

@interface HelperViewController : UIViewController
- (id)initWithDelegate:(id<HelperButtonDelegate>)delegate;
@end
