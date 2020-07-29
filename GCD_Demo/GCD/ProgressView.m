//
//  ProgressView.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "ProgressView.h"
#import "Macro.h"

@implementation ProgressView

-(instancetype)init{
    self = [super init];
    if (self) {
        _active = UIView.new;
        [self addSubview:_active];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        _active.backgroundColor = UIColor.systemBlueColor;
        _maxValue = 100;
    }
    return self;
}

-(void)setCurrentValue:(CGFloat)currentValue{
    CGFloat max = self->_maxValue;
    if (currentValue >= max) {
        currentValue = max;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_currentValue = currentValue;
        CGSize size = self.frame.size;
        CGFloat wid = currentValue / max * size.width;
        CGFloat hei = size.height;
        UIView *view = self->_active;
        [UIView animateWithDuration:0.1 animations:^{
            view.frame = CGRectMake(0, 0, wid, hei);
        } completion:^(BOOL finished) {
            if (currentValue == max) {
                [UIView animateWithDuration:0.3 animations:^{
                    view.backgroundColor = UIColor.systemGreenColor;
                }];
            }
        }];
    });
}

@end
