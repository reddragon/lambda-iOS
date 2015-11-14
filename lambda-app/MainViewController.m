//
//  MainViewController.m
//  eclisp-app
//
//  Created by Gaurav Menghani on 8/30/15.
//  Copyright (c) 2015 Gaurav Menghani. All rights reserved.
//

#import "MainViewController.h"

#import "lang/Lang.h"

#import "HamburgerViewController.h"
#import "HelperViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UITextView *contentScreen;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomPaddingConstraint;
@property CGFloat initialPaddingConstant;
@property NSOperationQueue* evalQueue;
@property GoLangLangEnv* env;
@property (strong, nonatomic) HelperViewController *helperVC;
@property (strong, nonatomic) IBOutlet UIView *helperView;
@property (strong, nonatomic) NSString *prevString;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *helperViewBottomConstraint;
@property (strong, nonatomic) NSMutableArray *commands;
@property int goBackCounter;

- (IBAction)hamburgerButton:(id)sender;
@end

@implementation MainViewController

- (IBAction)hamburgerButton:(id)sender {
    NSLog(@"Button pressed");
    if (self.delegate != nil) {
        [self dismissKeyboard];
        [self.delegate toggleMenu:YES];
    }
}

- (id)initWithDelegate:(id<HamburgerMenuDelegate>)delegate {
    self = [super init];
    self.env = GoLangNewEnv();
    self.helperVC = [[HelperViewController alloc] initWithDelegate:self];
    //[self.view addSubview:self.hamburgerVC.view];
    self.delegate = delegate;
    self.commands = [[NSMutableArray alloc] init];
    self.goBackCounter = 0;
    return self;
}

- (void)handleButton:(ButtonType)buttonType {
    NSLog(@"Button hit with: %d", buttonType);
    switch (buttonType) {
        case kOpenBracket:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "("];
            break;
        
        case kClosedBracket:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, ")"];
            break;
        
        case kAdd:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "+ "];
            break;
        
        case kSubtract:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "- "];
            break;
        
        case kMultiply:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "* "];
            break;
            
        case kDivide:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "/ "];
            break;
        
        case kDefvar:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "defvar "];
            break;
        
        case kDefun:
            self.inputField.text = [NSString stringWithFormat:@"%@%s", self.inputField.text, "defun "];
            break;
        
        case kRepeat:
            if (self.commands.count > 0) {
                self.goBackCounter %= self.commands.count;
                self.inputField.text = self.commands[self.commands.count - self.goBackCounter - 1];
                self.goBackCounter += 1;
            }
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.helperView addSubview:self.helperVC.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dismissKeyboard {
    [self.inputField endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification*) notification {
    [self.delegate toggleMenuWithState:NO animate:NO];
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
    
    NSLog(@"Constant before: %f %f %f", self.helperViewBottomConstraint.constant, CGRectGetMinY(rect), CGRectGetMaxY(self.view.bounds));
    double delta = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(rect);
    if (delta > 0) {
        self.helperViewBottomConstraint.constant = delta;
    } else {
        self.helperViewBottomConstraint.constant = self.initialPaddingConstant;
    }
    NSLog(@"Constant after: %f", self.helperViewBottomConstraint.constant);
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.contentScreen.layer.cornerRadius = 5;
    self.contentScreen.layer.masksToBounds = YES;
    self.inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // self.initialPaddingConstant = self.bottomPaddingConstraint.constant;
    self.initialPaddingConstant = self.helperViewBottomConstraint.constant;
    
    self.inputField.delegate = self;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    //[self.inputField becomeFirstResponder];
    
    self.contentScreen.text = @"> ";
    self.contentScreen.userInteractionEnabled = YES;
    self.contentScreen.scrollEnabled = YES;
    self.contentScreen.editable = NO;
    self.contentScreen.layoutManager.allowsNonContiguousLayout = NO;
    
    self.evalQueue = [[NSOperationQueue alloc] init];
    
    NSLog(@"HelperView: %f %f", self.helperView.frame.origin.x, self.helperView.frame.origin.y);
    //self.helperView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGRect frame = self.view.bounds;
    frame.origin.x = 0;
    frame.size.width = frame.size.width - 100;
}

- (NSString*)evaluate:(NSString*)expr {
    NSString* result;
    
    GoLangEvalResult *evalResult = GoLangEval(expr, self.env);
    if (evalResult.ErrStr.length > 0) {
        result = evalResult.ErrStr;
    } else {
        result = evalResult.ValStr;
    }
    return result;
}


-(void)scrollTextViewToBottom:(UITextView *)textView {
    if(textView.text.length > 0 ) {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"Began editing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"Ended editing");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Input: %@", self.inputField.text);
    
    NSString *result = [self evaluate:self.inputField.text];
    self.contentScreen.text = [self.contentScreen.text stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n\n> ", self.inputField.text, result]];
    self.prevString = self.inputField.text;
    if (self.commands.count == 0 || !([self.commands[self.commands.count - 1] isEqualToString:self.inputField.text])) {
        [self.commands addObject:self.inputField.text];
        self.goBackCounter = 0;
    }
    self.inputField.text = @"";
    [self scrollTextViewToBottom:self.contentScreen];

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    NSLog(@"Did layout subviews");
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
