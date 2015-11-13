//
//  HelpViewController.m
//  lambda
//
//  Created by Gaurav Menghani on 11/9/15.
//  Copyright © 2015 Gaurav Menghani. All rights reserved.
//

#import "HelpViewController.h"
#import "XNGMarkdownParser.h"

@interface HelpViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textBox;

@end

@implementation HelpViewController

- (IBAction)dismissHelp:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"Dismissing Help VC");
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    XNGMarkdownParser *parser = [[XNGMarkdownParser alloc] init];
    // [parser setFont:<#(UIFont *)#> forHeader:(XNGMarkdownParserHeader)]
    //[parser setFont:<#(UIFont *)#> forHeader:<#(XNGMarkdownParserHeader)#>]
    [parser setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19.0] forHeader:XNGMarkdownParserHeader2];
    [parser setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0] forHeader:XNGMarkdownParserHeader3];
    [parser setCodeFontName:@"Menlo"];
    [parser setParagraphFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [parser setBoldFontName:@"Helvetica"];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Syntax" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"%@, %@", path, content);
    
    if (content != nil) {
        NSAttributedString *string = [parser attributedStringFromMarkdownString:content];
        [self.textBox setScrollEnabled:NO];
        [self.textBox setAttributedText:string];
        
        [self.textBox scrollRectToVisible:CGRectMake(0,0,0,0) animated:NO];
        [self.textBox setScrollEnabled:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //[self.textBox scrollRangeToVisible:];
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
