//
//  UIButton+Utilities.m
//  M32
//
//  Created by i-Bejoy on 13-12-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)


- (void)alphablackView
{
    
    UIView *blackView = [[UIView alloc] initWithFrame:self.frame];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = .8;
    
    [self addSubview:blackView];
    
    
}



+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration
                   options:(UIViewAnimation)options
  
{
    CATransition *tr=[CATransition  animation];
    tr.duration= duration;
    tr.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
    if (options == UIViewAnimationOptionTransitionCurlLeft) {
        NSLog(@" left ");
        tr.type = @"pageCurl";
        tr.Subtype=@"fromRight";
        tr.fillMode = kCAFillModeBackwards;
    }
    else {
        NSLog(@" right ");
        tr.type = @"pageUnCurl";
        tr.Subtype=@"fromRight";
        tr.fillMode = kCAFillModeBackwards;
    }
    
    
    [tr setFillMode:@"extended"];
    [tr setRemovedOnCompletion:NO];

    tr.delegate=self;
    [view.layer addAnimation:tr forKey:@"pageCurlAnimation"];
    
    
    
}




- (void)setRemindImage:(UIImage *)image
{
    UIImageView *imgView = [[UIImageView alloc]  init];
    imgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imgView.tag = 100;
    imgView.alpha = 0;
    
    imgView.image = image;
    
    [self addSubview:imgView];
}

- (void)setRemind:(BOOL)isShow
{
    UIImageView *imgView = (UIImageView *)[self viewWithTag:100];
    
    
    if (isShow) {
        imgView.alpha = 1;
    }
    else {
        imgView.alpha = 0;

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
