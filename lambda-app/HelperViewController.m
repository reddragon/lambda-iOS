//
//  HelperViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 10/13/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "HelperViewController.h"

@interface HelperViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstViewLeftGap;

@end

@implementation HelperViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"SWidth: %f", self.view.frame.size.width);
    NSLog(@"SSWidth: %f", self.view.superview.frame.size.width);
    
    NSUInteger numViews = self.view.subviews.count;
    if (numViews > 0) {
        NSLog(@"Width: %f", self.view.frame.size.width);
        
        float maxX = 0;
        UIView *lastView = nil;
        for (NSUInteger i = 0; i < numViews; i++) {
            UIView *curView = self.view.subviews[i];
            float dis = curView.frame.origin.x + curView.frame.size.width;
            NSLog(@"Last view %lu end: %f", (unsigned long)i, dis);
            if (maxX < dis) {
                maxX = dis;
                lastView = curView;
            }
        }
        float gap = self.view.frame.size.width - maxX;
        NSLog(@"Gap: %f", gap);
        if ((gap - self.firstViewLeftGap.constant) > 1) {
            float addToLeft = (gap - self.firstViewLeftGap.constant) / 2;
            self.firstViewLeftGap.constant += addToLeft;
            NSLog(@"Added %f", addToLeft);
            // [self.view layoutIfNeeded];
        }
        
        //[self.view layoutIfNeeded];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
