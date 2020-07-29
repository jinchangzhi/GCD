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
//    ProgressView *_progress1,*_progress2,*_progress3;
    SegmentedControl *_taskSeg,*_queueSeg;
    NSMutableArray <UILabel *>*_tips;
    NSMutableArray <ProgressView *>*_progressList;
}

@end

@implementation AsyncConViewController

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
    hei = 30;
    SegmentedControl *seg = [[SegmentedControl alloc] initWithItems:@[@"async",@"sync"]];
    seg.frame = CGRectMake(20, y, 160, hei);
    seg.tintColor = UIColor.systemBlueColor;
    [superView addSubview:seg];
    _taskSeg = seg;
    
    y += hei+20;
    hei = 30;
    seg = [[SegmentedControl alloc] initWithItems:@[@"Concurrent",@"serial"]];
    seg.frame = CGRectMake(20, y, 260, hei);
    seg.tintColor = UIColor.systemBlueColor;
    [superView addSubview:seg];
    _queueSeg = seg;
    
    y += hei+20;
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
//    _progress2 = v1;
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
//    _progress3 = v1;
    [_progressList addObject:v1];
}

-(void)onReset{
    for (ProgressView *view in _progressList) {
        view.currentValue = 0;
    }
    
    [self updateTips];
}

-(void)onStart{
    //同步任务会阻塞主线程，要放到全局队列来做
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self onNewThread];
    });
}

-(void)onNewThread{
    BOOL isSerial = _queueSeg.selectedSegmentIndex == 1;
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
    
    void(^runProgress3)(void) = ^(){
        ProgressView *view = self->_progressList[2];
        while (view.currentValue < view.maxValue) {
            [NSThread sleepForTimeInterval:0.3];
            view.currentValue += 12;
        }
        [self updateTips];
    };
    
    if (_taskSeg.selectedSegmentIndex == 1) {
        dispatch_sync(queue, runProgress1);
        dispatch_sync(queue, runProgress2);
        dispatch_sync(queue, runProgress3);
    }else{
        dispatch_async(queue, runProgress1);
        dispatch_async(queue, runProgress2);
        dispatch_async(queue, runProgress3);
    }
}

-(void)updateTips{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor *color = UIColor.darkGrayColor;
        UIColor *color2 = UIColor.systemGreenColor;
        for (int i = 0; i < self->_tips.count; i++) {
            ProgressView *view = self->_progressList[i];
            BOOL full = view.currentValue == view.maxValue;
            [UIView animateWithDuration:1 animations:^{
                self->_tips[i].textColor = full ? color2 : color;
            }];
            
        }
    });
}

@end
