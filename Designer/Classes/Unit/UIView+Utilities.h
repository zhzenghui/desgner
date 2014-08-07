//
//  UIButton+Utilities.h
//  M32
//
//  Created by i-Bejoy on 13-12-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum NSInteger{
    UIViewAnimationOptionTransitionCurlLeft,
    UIViewAnimationOptionTransitionCurlRight
} UIViewAnimation;




@interface UIView (Utilities)

- (void)alphablackView;
- (void)setRemindImage:(UIImage *)image;
- (void)setRemind:(BOOL)isShow;
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration
                   options:(UIViewAnimation)options;

@end
