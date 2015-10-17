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
@property (strong, nonatomic) IBOutlet UIView *openBracketButton;

@end

@implementation HelperViewController

- (void)onButtonTap:(UIView*)target {
    NSLog(@"Button was tapped.");
    [UIView animateWithDuration:1 animations:^{
        target.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupButtonDefaults:(UIView*)button {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onButtonTap:)];
    [button addGestureRecognizer:gesture];
    [button setUserInteractionEnabled:YES];
}

- (id)initWithDelegate {
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSUInteger numViews = self.view.subviews.count;
    if (numViews > 0) {
        // NSLog(@"Width: %f", self.view.frame.size.width);
        
        float maxX = 0;
        UIView *lastView = nil;
        for (NSUInteger i = 0; i < numViews; i++) {
            UIView *curView = self.view.subviews[i];
            float dis = curView.frame.origin.x + curView.frame.size.width;
            // NSLog(@"Last view %lu end: %f", (unsigned long)i, dis);
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
    NSLog(@"Setting up the buttons");
    [self setupButtonDefaults:self.openBracketButton];

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
