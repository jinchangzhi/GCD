//
//  SemaphoreViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "SemaphoreViewController.h"

#import "SegmentedControl.h"
#import "ProgressView.h"
#import "Macro.h"

@interface SemaphoreViewController ()
{
    NSMutableArray <UILabel *>*_tips;
    NSMutableArray <ProgressView *> *_progressList;
    
    dispatch_semaphore_t semaphore;
}

@end

@implementation SemaphoreViewController

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
    label.text = @"窗口1";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    ProgressView *v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    [_progressList addObject:v1];
    
    y += hei + hei;
    label = UILabel.new;
    label.frame = CGRectMake(0, y, 70, hei);
    label.text = @"窗口2";
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
    label.text = @"窗口3";
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
    label.text = @"剩余";
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    [_tips addObject:label];
    
    v1 = ProgressView.new;
    v1.frame = CGRectMake(x, y, wid, hei);
    [superView addSubview:v1];
    v1.activeColor = UIColor.systemRedColor;
    v1.fullColor = UIColor.systemRedColor;
    [_progressList addObject:v1];
    v1.currentValue = 100;
}

-(void)onReset{
    for (ProgressView *view in _progressList) {
        view.currentValue = 0;
    }
    _progressList.lastObject.currentValue = 100;
    
    [self updateTips];
}

-(void)onStart
{
    BOOL isSerial = true;
    dispatch_queue_attr_t attr = isSerial ? DISPATCH_QUEUE_SERIAL : DISPATCH_QUEUE_CONCURRENT;
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", attr);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", attr);
    dispatch_queue_t queue3 = dispatch_queue_create("queue3", attr);
    NSLog(@"%@->main",[NSThread currentThread]);
    
    semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(queue1, ^{
        [self saleTicket:_progressList[0]];
    });
    
    dispatch_async(queue2, ^{
        [self saleTicket:_progressList[1]];
    });
    
    dispatch_async(queue3, ^{
        [self saleTicket:_progressList[2]];
    });
}

-(void)saleTicket:(ProgressView *)window{
    while (1) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [NSThread sleepForTimeInterval:0.3];
        
        NSLog(@"%@",[NSThread currentThread]);
        NSInteger total = _progressList[3].currentValue;
        if (total > 0) {
            _progressList[3].currentValue -= 1;
            window.currentValue += 1;
            dispatch_semaphore_signal(semaphore);
        }else{
            dispatch_semaphore_signal(semaphore);
            break;
        }
    }
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
                if (i == 3) {
                    self->_tips[i].textColor = full ? color3 : color;
                }else{
                    self->_tips[i].textColor = full ? color2 : color;
                }
            }];
        }
    });
}

@end
