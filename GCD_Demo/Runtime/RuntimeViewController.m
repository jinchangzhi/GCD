//
//  RuntimeViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/31.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "RuntimeViewController.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.fileName = @"runtime.txt";
    }
    return self;
}

@end
