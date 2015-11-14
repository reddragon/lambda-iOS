//
//  HamburgerViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "HamburgerViewController.h"
#import "HelpViewController.h"
#include "AboutViewController.h"

@interface HamburgerViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hamburgerViewWidth;
@property (strong, nonatomic) HelpViewController *hvc;
@property (strong, nonatomic) AboutViewController *avc;
@end

@implementation HamburgerViewController

- (IBAction)pushHelpButton:(id)sender {
    NSLog(@"Help button pushed.");
    
    [self.view.window.rootViewController presentViewController:self.avc animated:NO completion:^{
        NSLog(@"Done");
    }];
}

- (IBAction)pushAboutButton:(id)sender {
    NSLog(@"About button pushed.");
    
    [self.view.window.rootViewController presentViewController:self.avc animated:NO completion:^{
        NSLog(@"Done");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hvc = [[HelpViewController alloc] init];
    self.avc = [[AboutViewController alloc] init];
    
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
