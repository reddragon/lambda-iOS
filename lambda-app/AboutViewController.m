//
//  AboutViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 11/13/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
- (IBAction)dismissVC:(id)sender {[self dismissViewControllerAnimated:NO completion:^{
    NSLog(@"Dismissing About Me VC");
}];
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
