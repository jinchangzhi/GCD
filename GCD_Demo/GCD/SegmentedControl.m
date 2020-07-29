//
//  SegmentedControl.m
//  mall
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "SegmentedControl.h"

@implementation SegmentedControl

-(id)initWithItems:(NSArray<NSString *> *)items{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.systemBlueColor;
        self.layer.borderWidth = 1;
        _items = items;
        
        _cornerRadius = 7;
        _borderWidth = 0;
        
        UIView *view = UIView.new;
        view.backgroundColor = UIColor.whiteColor;
        [self addSubview:view];
        _slider = view;
        
        NSMutableArray *mArr = NSMutableArray.new;
        NSInteger tag = 0;
        for (NSString *title in items) {
            UIButton *btn = UIButton.new;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor
                      forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.systemBlueColor
                      forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [self addSubview:btn];
            [mArr addObject:btn];
            btn.tag = tag++;
            [btn addTarget:self
                    action:@selector(onClick:)
          forControlEvents:UIControlEventTouchUpInside];
        }
        _btns = mArr;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_items.count == 0) {
        return;
    }
    CGFloat bd = _borderWidth;
    CGFloat width = frame.size.width;
    CGFloat wid = (width - bd * 2) / _items.count;
    CGFloat hei = frame.size.height - bd * 2;
    CGFloat x = bd;
    CGFloat y = bd;
    for (UIButton *btn in _btns) {
        btn.frame = CGRectMake(x, y, wid, hei);
        x += wid;
    }
    _slider.frame = _btns.firstObject.frame;
    self.selectedSegmentIndex = 0;
}

-(void)onClick:(UIButton *)sender{
    self.selectedSegmentIndex = sender.tag;
}

-(void)setSelectedSegmentIndex:(NSUInteger)index{
    _selectedSegmentIndex = index;
    CGRect frame = CGRectZero;
    for (UIButton *btn in _btns) {
        btn.selected = btn.tag == index;
        if (btn.selected) {
            frame = btn.frame;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        _slider.frame = frame;
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = _cornerRadius;
    _slider.layer.cornerRadius = _cornerRadius - _borderWidth;
    for (UIButton *btn in _btns) {
        btn.layer.cornerRadius =  _cornerRadius;
    }
}

- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state{
    [self setAttribute:attributes forState:state];
}

-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    self.backgroundColor = UIColor.whiteColor;
    _slider.backgroundColor = tintColor;
    self.layer.borderColor = tintColor.CGColor;
    for (UIButton *btn in _btns) {
        [btn setTitleColor:UIColor.whiteColor
                  forState:UIControlStateSelected];
        [btn setTitleColor:tintColor
                  forState:UIControlStateNormal];
    }
}

-(void)setAttribute:(NSDictionary *)attr
           forState:(UIControlState)state
{
    NSArray<UIButton *> *array = _btns;
    for (NSString *key in attr) {
        id value = attr[key];
        if ([key isEqualToString:NSForegroundColorAttributeName]) {
            for (UIButton *btn in array) {
                [btn setTitleColor:value forState:state];
            }
        }else if([key isEqualToString:NSFontAttributeName]){
            for (UIButton *btn in array) {
                btn.titleLabel.font = value;
            }
        }
    }
}

@end
