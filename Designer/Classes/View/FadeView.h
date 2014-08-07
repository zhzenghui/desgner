//
//  FadeView.h
//  Designer
//
//  Created by bejoy on 14/6/19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadeView : UIView
{
    NSMutableArray *filesArray;
    NSTimer *timer;
    int current;
}

@property(nonatomic, retain) NSArray *fileNamesArray;



- (void)startFade;

- (void)stopFade;

@end
