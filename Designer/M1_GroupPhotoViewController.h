//
//  M1_GroupPhotoViewController.h
//  Designer
//
//  Created by bejoy on 14/6/18.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"
#import "ZHMainViewController.h"

@interface M1_GroupPhotoViewController : UIViewController<UIScrollViewDelegate>
{
    float logo_y;
    
//    bool isScroll;
}


@property(nonatomic) bool scroll;
@property(nonatomic) bool isScroll;

@property(nonatomic) float contentOffset;
@property(nonatomic, retain) IBOutlet UIImageView *logoIV;
@property(nonatomic, retain) IBOutlet UIScrollView *sv;

@property(nonatomic, strong) ZHMainViewController *main;


@end
