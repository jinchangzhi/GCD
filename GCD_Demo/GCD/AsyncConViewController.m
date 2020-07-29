//
//  AsyncConViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "AsyncConViewController.h"

#import "ProgressView.h"
#import "SegmentedControl.h"
#import "Macro.h"

@interface AsyncConViewController (){
    ProgressView *_progress1,*_progress2,*_progress3;
}

@end

@implementation AsyncConViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *superView = self.view;
    superView.backgroundColor = UIColor.whiteColor;
    
    CGFloat y = kNavBarHei;
    CGFloat hei = 60;
    UIButton *btn = UIButton.new;
    btn.frame = CGRectMake(0, y, 60, hei);
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(onStart)
  forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];

    btn = UIButton.new;
    btn.frame = CGRectMake(100, y, 60, hei);
    [btn setTitle:@"Reset" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [btn addTarget:self
          action:@selector(onReset)
    forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    
    y += hei;
    hei = 30;
    SegmentedControl *seg = [[SegmentedControl alloc] initWithItems:@[@"sync",@"async"]];
    seg.frame = CGRectMake(20, y, 100, hei);
    seg.tintColor = UIColor.systemBlueColor;
    [superView addSubview:seg];
    
    y += hei+20;
    hei = 30;
    seg = [[SegmentedControl alloc] initWithItems:@[@"serial",@"Concurrent"]];
    seg.frame = CGRectMake(20, y, 160, hei);
    seg.tintColor = UIColor.systemBlueColor;
    [superView addSubview:seg];
    
    y += hei+20;
    hei = 20;
    CGFloat x = 20;
    CGFloat wid = kSize.width - x - x;
    ProgressView *v1 = ProgressView.new;
    v1.frame = CGRectMake(20, y, wid, hei);
    [superView addSubview:v1];
    _progress1 = v1;
    
    y += hei + hei;
    v1 = ProgressView.new;
    v1.frame = CGRectMake(20, y, wid, hei);
    [superView addSubview:v1];
    _progress2 = v1;
    
    y += hei + hei;
    v1 = ProgressView.new;
    v1.frame = CGRectMake(20, y, wid, hei);
    [superView addSubview:v1];
    _progress3 = v1;
}

-(void)onReset{
    _progress1.currentValue = 0;
    _progress2.currentValue = 0;
    _progress3.currentValue = 0;
}

-(void)onStart{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        ProgressView *view = self->_progress1;
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 5;
        }
    });
    
    dispatch_async(queue, ^{
        ProgressView *view = self->_progress2;
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 8;
        }
    });
    
    dispatch_async(queue, ^{
        ProgressView *view = self->_progress3;
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 12;
        }
    });
}

@end
