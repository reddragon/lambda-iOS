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
@property (strong, nonatomic) IBOutlet UIView *closedBracketButton;
@property (strong, nonatomic) IBOutlet UIView *plusButton;
@property (strong, nonatomic) IBOutlet UIView *minusButton;
@property (strong, nonatomic) IBOutlet UIView *multiplyButton;
@property (strong, nonatomic) IBOutlet UIView *divideButton;
@property (strong, nonatomic) IBOutlet UIView *defvarButton;
@property (strong, nonatomic) IBOutlet UIView *defunButton;
@property (strong, nonatomic) IBOutlet UIView *repeatButton;

@property (strong, nonatomic) id<HelperButtonDelegate> delegate;
@end

@implementation HelperViewController

- (void)onButtonTap:(UIGestureRecognizer*)target {
    NSLog(@"Button was tapped.");
    
    if (target == nil) {
        NSLog(@"Target was nil");
    }
    
    [UIView animateWithDuration:0.05 animations:^{
        target.view.transform = CGAffineTransformMakeScale(2.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            target.view.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
        if (self.delegate != nil) {
            [self.delegate handleButton:target.view.tag];
        }
    }];
}

- (void)setupButtonDefaults:(UIView*)button buttonType:(ButtonType)buttonType {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onButtonTap:)];
    [button addGestureRecognizer:gesture];
    [button setUserInteractionEnabled:YES];
    [button.layer setCornerRadius:3];
    button.clipsToBounds = YES;
    button.layer.borderWidth = 0.1;
    button.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    button.tag = buttonType;
}

- (id)initWithDelegate:(id<HelperButtonDelegate>)delegate {
    self.delegate = delegate;
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
    [self setupButtonDefaults:self.openBracketButton buttonType:kOpenBracket];
    [self setupButtonDefaults:self.closedBracketButton buttonType:kClosedBracket];
    [self setupButtonDefaults:self.plusButton buttonType:kAdd];
    [self setupButtonDefaults:self.minusButton buttonType:kSubtract];
    [self setupButtonDefaults:self.multiplyButton buttonType:kMultiply];
    [self setupButtonDefaults:self.divideButton buttonType:kDivide];
    [self setupButtonDefaults:self.defvarButton buttonType:kDefvar];
    [self setupButtonDefaults:self.defunButton buttonType:kDefun];
    [self setupButtonDefaults:self.repeatButton buttonType:kRepeat];
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
