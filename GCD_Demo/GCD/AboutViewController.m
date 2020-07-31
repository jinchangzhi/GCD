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

-(instancetype)init{
    self = [super init];
    if (self) {
        self.fileName = @"about.txt";
    }
    return self;
}

@end
