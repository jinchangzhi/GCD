//
//  ProgressView.h
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : UIView
{
    UIView *_active;
}
@property(nonatomic,assign)CGFloat maxValue;

@property(nonatomic,assign)CGFloat currentValue;

@end

NS_ASSUME_NONNULL_END
