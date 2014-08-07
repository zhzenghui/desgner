//
//  BaseViewController.m
//  Dyrs
//
//  Created by mbp  on 13-8-22.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "M1_BaseViewController.h"

@interface M1_BaseViewController ()
{
}
@end

@implementation M1_BaseViewController


- (void)back:(UIButton *)button
{
    
  
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
    
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight|| toInterfaceOrientation == UIDeviceOrientationLandscapeLeft);
}





- (void)addMemu
{
    //    UIImageView *backgourndImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-all"]];
    //    backgourndImageView .frame = CGRectMake(0, 0, _baseView.frame.size.width, _baseView.frame.size.height);
    //    [_baseView addSubview:backgourndImageView];
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 768)];
    _menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"左导航条-bg"]];
    [self.view addSubview:_menuView];
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    if (iOS7) {
        UIImageView *statuebar_gb_ImageView = [[UIImageView alloc] init];
        statuebar_gb_ImageView.frame = CGRectMake(0, 0, 1024, 20);
        statuebar_gb_ImageView.image = [[ImageView share] createSolidColorImageWithColor:[UIColor blackColor] andSize:statuebar_gb_ImageView.frame.size];

        [self.view addSubview:statuebar_gb_ImageView];
    }
    return UIStatusBarStyleLightContent;
}



- (void)loadView
{
    [super loadView];
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2级-all-bg"]];


    self.view.frame = CGRectMake(0, 0, 1024, 768);
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(55, 0, 1024-55, 768)];
    _baseView.clipsToBounds = YES;
//    CGRect r = self.baseView.frame;
//    
//    
//    
//
//    
//    if (isShowStatue) {
//        
//        if (iOS7) {
//            r.origin = CGPointMake(0, 20);
//        }
//        else {
//            r.origin = CGPointMake(0, 0);
//        }
//        r.size = CGSizeMake(screen_Height, screen_Width-20);
//
//        
//    }
//    else {
//        if (iOS7) {
//            r.origin = CGPointMake(0, 0);
//        }
//        else {
//            r.origin = CGPointMake(0, 0);
//        }
//        r.size = CGSizeMake(screen_Height , screen_Width);
//
//    }
//    _baseView.frame = r;
    [self.view addSubview:_baseView];
    
    

    


    
    
    
}

- (void)addLogo
{
    [[ImageView share] addToView:self.baseView imagePathName:@"logo0000" rect:RectMake2x(74, 66, 389, 102)];

}


- (void)addBackView
{
    [[Button share] addToView:self.menuView addTarget:self rect:CGRectMake(0  , 700, 110/2, 130/2) tag:Action_Back action:@selector(back:) imagePath:@"按钮-返回"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    [self addMemu];
//
//    [self addBackView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
