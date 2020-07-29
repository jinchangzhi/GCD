//
//  BarrierViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "BarrierViewController.h"

#import "SegmentedControl.h"
#import "ProgressView.h"
#import "Macro.h"

@interface BarrierViewController ()
{
    NSMutableArray <UILabel *>*_tips;
    NSMutableArray <ProgressView *> *_progressList;
}

@end

@implementation BarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *superView = self.view;
    superView.backgroundColor = UIColor.whiteColor;
    _tips = NSMutableArray.new;
    _progressList = NSMutableArray.new;
    
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
    hei = 20;
    CGFloat x = 70;
    CGFloat wid = kSize.width - x - 20;
    UILabel *label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"任务1";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    ProgressView *v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
//    _progress1 = v1;
    [_progressList addObject:v1];
    
    y += hei + hei;
    label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"任务2";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    [_progressList addObject:v1];
    
    y += hei + hei;
    label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"Barrier";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    v1.activeColor = UIColor.systemRedColor;
    v1.fullColor = UIColor.systemRedColor;
    [_progressList addObject:v1];
    
    y += hei + hei;
    label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"任务3";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    [_progressList addObject:v1];
    
    y += hei + hei;
    label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"任务4";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    [_progressList addObject:v1];
}

-(void)onReset{
    for (ProgressView *view in _progressList) {
        view.currentValue = 0;
    }
    
    [self updateTips];
}

-(void)onStart{
    BOOL isSerial = false;
    dispatch_queue_attr_t attr = isSerial ? DISPATCH_QUEUE_SERIAL : DISPATCH_QUEUE_CONCURRENT;
    dispatch_queue_t queue = dispatch_queue_create("queue", attr);
    NSLog(@"%@->main",[NSThread currentThread]);
    
    void(^runProgress1)(void) = ^(){
        ProgressView *view = self->_progressList[0];
        while (view.currentValue < view.maxValue) {
            NSLog(@"%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 5;
            NSLog(@"->%.0f",view.currentValue);
        }
        [self updateTips];
    };
    
    void(^runProgress2)(void) = ^(){
        ProgressView *view = self->_progressList[1];
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 8;
        }
        [self updateTips];
    };
    
    void(^runBarrier)(void) = ^(){
        ProgressView *view = self->_progressList[2];
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 7;
        }
        [self updateTips];
    };
    
    void(^runProgress3)(void) = ^(){
        ProgressView *view = self->_progressList[3];
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 6;
        }
        [self updateTips];
    };
    
    void(^runProgress4)(void) = ^(){
        ProgressView *view = self->_progressList[4];
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 10;
        }
        [self updateTips];
    };
    
    dispatch_async(queue, runProgress1);
    dispatch_async(queue, runProgress2);
    dispatch_barrier_async(queue, runBarrier);
    dispatch_async(queue, runProgress3);
    dispatch_async(queue, runProgress4);
}

-(void)updateTips{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor *color = UIColor.darkGrayColor;
        UIColor *color2 = UIColor.systemGreenColor;
        UIColor *color3 = UIColor.systemRedColor;
        for (int i = 0; i < self->_tips.count; i++) {
            ProgressView *view = self->_progressList[i];
            BOOL full = view.currentValue == view.maxValue;
            [UIView animateWithDuration:1 animations:^{
                if (i == 2) {
                    self->_tips[i].textColor = full ? color3 : color;
                }else{
                    self->_tips[i].textColor = full ? color2 : color;
                }
            }];
            
        }
    });
}

@end
