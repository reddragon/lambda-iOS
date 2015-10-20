//
//  ContainerViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "ContainerViewController.h"
#import "MainViewController.h"
#import "HamburgerViewController.h"

@interface ContainerViewController ()
@property (strong, nonatomic) HamburgerViewController *hamburgerVC;
@property (strong, nonatomic) MainViewController* mainVC;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ContainerViewController

- (void)toggleMenu {
    NSLog(@"Should toggle the menu now.");
    CGRect mainVCFrame = self.mainVC.view.frame;
    CGRect hamburgerVCFrame = self.hamburgerVC.view.frame;
    // NSLog(@"Frame: %f %f", se)
    if (mainVCFrame.origin.x > 0) {
        NSLog(@"It was opened up.");
        mainVCFrame.origin.x = 0;
        hamburgerVCFrame.origin.x = -hamburgerVCFrame.size.width;
    } else {
        NSLog(@"It was closed.");
        hamburgerVCFrame.origin.x = 0;
        mainVCFrame.origin.x = hamburgerVCFrame.size.width;
    }
    [self.mainVC.view endEditing:YES];
    [UIView animateWithDuration:0.1 animations:^{
        self.mainVC.view.frame = mainVCFrame;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hamburgerVC = [[HamburgerViewController alloc] init];
    self.mainVC = [[MainViewController alloc] initWithDelegate:self];
    
    CGRect frame = self.containerView.bounds;
    
    int widthSqueeze = 150;
    CGRect hamburgerVCFrame = frame;
    hamburgerVCFrame.size.width = frame.size.width - widthSqueeze;
    hamburgerVCFrame.origin.x = 0;
    self.hamburgerVC.view.frame = hamburgerVCFrame;
    self.hamburgerVC.view.bounds = hamburgerVCFrame;

    CGRect mainVCFrame = self.containerView.bounds;
    mainVCFrame.origin.x = hamburgerVCFrame.size.width + 40;
    self.mainVC.view.frame = mainVCFrame;
    self.mainVC.view.bounds = frame;
    
    [self.containerView addSubview:self.mainVC.view];
    [self.containerView addSubview:self.hamburgerVC.view];
    
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
