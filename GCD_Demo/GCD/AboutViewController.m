//
//  AboutViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/30.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "AboutViewController.h"

#import "Macro.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITextView *textV = UITextView.new;
    textV.frame = CGRectMake(10, kNavBarHei,
                             kSize.width-10, kSize.height-kNavBarHei);
    textV.font = [UIFont systemFontOfSize:16];
    textV.textColor = UIColor.grayColor;
    [self.view addSubview:textV];
    textV.editable = false;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about.txt" ofType:nil];
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    textV.text = str;
}

@end
