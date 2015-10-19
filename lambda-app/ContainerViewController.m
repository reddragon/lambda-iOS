//
//  ContainerViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 10/18/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "ContainerViewController.h"
#import "MainViewController.h"

@interface ContainerViewController ()
@property (strong, nonatomic) MainViewController* mainVC;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainVC = [[MainViewController alloc] init];
    
    CGRect frame = self.containerView.bounds;
    // CGRect frame2 = frame;
    frame.origin.x = -100;
    //frame.size.width = 100;
    frame.size.height = self.containerView.bounds.size.height;
    self.containerView.frame = frame;
    self.containerView.bounds = frame;
    
    [self.containerView addSubview:self.mainVC.view];
    
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
