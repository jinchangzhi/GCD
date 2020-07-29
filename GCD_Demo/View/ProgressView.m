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
        _activeColor =  UIColor.systemBlueColor;
        _fullColor = UIColor.systemGreenColor;
        _active.backgroundColor = _activeColor;
        _maxValue = 100;
    }
    return self;
}

-(void)setActiveColor:(UIColor *)activeColor{
    _activeColor = activeColor;
    _active.backgroundColor = activeColor;
}

-(void)setCurrentValue:(CGFloat)currentValue{
    CGFloat max = self->_maxValue;
    if (currentValue > max) {
        currentValue = max;
    }
    _currentValue = currentValue;
    if ([NSThread isMainThread]) {
        [self updateUI];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUI];
        });
    }
}

-(void)updateUI{
    CGFloat max = _maxValue;
    CGFloat currentValue = _currentValue;
    CGSize size = self.frame.size;
    CGFloat wid = currentValue / max * size.width;
    CGFloat hei = size.height;
    UIView *view = self->_active;
    [UIView animateWithDuration:0.1 animations:^{
        view.frame = CGRectMake(0, 0, wid, hei);
    } completion:^(BOOL finished) {
        UIColor *color = currentValue == max ? _fullColor : _activeColor;
        [UIView animateWithDuration:0.3 animations:^{
            view.backgroundColor = color;
        }];
    }];
}

@end
