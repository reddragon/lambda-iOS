//
//  HelpViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 11/9/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textBox;

@end

@implementation HelpViewController

- (IBAction)dismissHelp:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"Dismissing Help VC");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //NSAttributedString
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
