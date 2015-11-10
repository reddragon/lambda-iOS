//
//  HamburgerViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "HamburgerViewController.h"
#import "HelpViewController.h"

@interface HamburgerViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hamburgerViewWidth;
@property (strong, nonatomic) HelpViewController *hvc;
@property (strong, nonatomic) UINavigationController *nvc;
@end

@implementation HamburgerViewController

- (void)dismissHelpVC {
    NSLog(@"dismissHelpVC called");
    [self.nvc dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)pushHelpButton:(id)sender {
    NSLog(@"Help button pushed.");
    
    [self.view.window.rootViewController presentViewController:self.nvc animated:NO completion:^{
        NSLog(@"Done");
    }];
}

- (IBAction)pushAboutButton:(id)sender {
    NSLog(@"About button pushed.");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hvc = [[HelpViewController alloc] init];
    [self.hvc setTitle:@"Help"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(dismissHelpVC)];
    self.hvc.navigationItem.rightBarButtonItem = rightButton;
    self.nvc = [[UINavigationController alloc] initWithRootViewController:self.hvc];

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
