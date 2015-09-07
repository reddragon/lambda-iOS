//
//  MainViewController.m
//  eclisp-app
//
//  Created by Gaurav Menghani on 8/30/15.
//  Copyright (c) 2015 Gaurav Menghani. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UITextView *contentScreen;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomPaddingConstraint;
@property CGFloat initialPaddingConstant;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*) notification {
    NSLog(@"KeyboardWillShow");
    [self adjustViewForKeyboard:notification];
}

- (void)keyboardWillHide:(NSNotification*) notification {
    NSLog(@"KeyboardWillHide");
    [self adjustViewForKeyboard:notification];
}

- (void)adjustViewForKeyboard:(NSNotification*) notification {
    NSDictionary* userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomPaddingConstraint.constant = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(rect) + self.initialPaddingConstant;

    // double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.contentScreen.layer.cornerRadius = 5;
    self.contentScreen.layer.masksToBounds = YES;
    self.inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.initialPaddingConstant = self.bottomPaddingConstraint.constant;
    
    self.inputField.delegate = self;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    // Do any additional setup after loading the view from its nib.
    // self.contentScreen.editable = NO;
    self.contentScreen.text = @"> ";
    self.contentScreen.userInteractionEnabled = YES;
    self.contentScreen.scrollEnabled = YES;
    self.contentScreen.editable = NO;
    self.contentScreen.layoutManager.allowsNonContiguousLayout = NO;
}

/*
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"Field ended editing");
    if (textField == self.inputField) {
        NSLog(@"It was inputField");
        [self.view endEditing:YES];
    }
}
*/

-(void)scrollTextViewToBottom:(UITextView *)textView {
    if(textView.text.length > 0 ) {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Input: %@", self.inputField.text);
    // TODO Replace the result with the string evaluation result
    NSString *result = @"1";

    self.contentScreen.text = [self.contentScreen.text stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n\n> ", self.inputField.text, result]];
    self.inputField.text = @"";
    [self scrollTextViewToBottom:self.contentScreen];

    return YES;
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
