//
//  SegmentedControl.h
//  mall
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentedControl : UIView{
    NSArray<NSString *> *_items;
    NSArray<UIButton *> *_btns;
    
    UIView *_slider;
}

-(id)initWithItems:(NSArray<NSString *> *)items;

- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state;

@property(nonatomic,assign)NSUInteger selectedSegmentIndex;

#pragma mark -

@property(nonatomic,assign)CGFloat cornerRadius;

@property(nonatomic,assign)CGFloat borderWidth;;

@end

NS_ASSUME_NONNULL_END
