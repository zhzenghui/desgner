//
//  M2_MainViewController.h
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_BaseViewController.h"

@interface M2_MainViewController : M2_BaseViewController
{
    
}

//扉页

@property (strong, nonatomic) IBOutlet UIView *titlePageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhengImageView;


// main
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;


@property (strong, nonatomic) IBOutlet UIView *casesView;
@property (weak, nonatomic) IBOutlet UIScrollView *casesScrollView;


@property (weak, nonatomic) IBOutlet UIImageView *ren1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ren2ImageView;


//menu
@property (strong, nonatomic) IBOutlet UIView *menuView;

- (IBAction)openCloseMenu:(UIButton *)sender;

@end
