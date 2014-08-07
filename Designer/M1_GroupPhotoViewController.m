//
//  M1_GroupPhotoViewController.m
//  Designer
//
//  Created by bejoy on 14/6/18.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M1_GroupPhotoViewController.h"

@interface M1_GroupPhotoViewController ()
{
    UIView *bigPhotoView;
    UIImageView *bigPhoto;
    
    
    CGRect *currentRect;
}


@end

@implementation M1_GroupPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)closePhoto
{
    
    [UIView animateWithDuration:KLongDuration animations:^{
        bigPhotoView.alpha = 0;

    }];
}

- (void)openPhoto:(UIButton *)button
{
    NSString *string = [NSString stringWithFormat:@"合影-大-%d", button.tag -10 ];

    UIImage *image = [UIImage imageNamed:string];
    bigPhoto.image = image;
    

    [UIView animateWithDuration:KLongDuration animations:^{
        bigPhotoView.alpha = 1;

    }];
    
}

- (void)loadPhotos
{
    
    
    int y = 120/2;
    int y_higth = 459/2;
    
    for (int i = 0; i < 10; i ++) {
        
        NSString *string = [NSString stringWithFormat:@"合影-小-%d", i];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, y +  y_higth*i, 423, 459/2)];
        [[ImageView share] addToView:v imagePathName:string rect:CGRectMake(0, 0, 847/2, 419/2)];
        [self.sv addSubview:v];
        
        [[Button share] addToView:v addTarget:self rect:CGRectMake(0, 0, 847/2, 419/2) tag:i+10 action:@selector(openPhoto:)];
        
    }
    
    self.sv. contentSize = CGSizeMake(423, y_higth * 10+100);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isScroll = YES;

    
    logo_y = _logoIV.frame.origin.y  ;
    
    self.logoIV.frame = CGRectMake(self.logoIV.frame.origin.x,
                               self.logoIV.frame.origin.y +768, self.logoIV.frame.size.width, self.logoIV.frame.size.height);

    self.sv.frame = CGRectMake(self.sv.frame.origin.x,
                               self.sv.frame.origin.y +768, self.sv.frame.size.width, self.sv.frame.size.height);
    [self loadPhotos];
    
    
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.frame];
    v.backgroundColor = [UIColor blackColor];
    v.alpha = .8;

    bigPhotoView  = [[UIView alloc] initWithFrame:self.view.frame];
    [bigPhotoView addSubview:v];
    bigPhotoView.alpha = 0;
    
    
    [self.main.view addSubview:bigPhotoView];
    
    
    
    bigPhoto = [[UIImageView alloc] initWithFrame:RectMake2x(40, 80, 1968, 1416)];
    
    [bigPhotoView addSubview:bigPhoto];
    
    [[Button share] addToView:bigPhotoView addTarget:self rect:CGRectMake(0, 0, 1024, 768) tag:1000 action:@selector(closePhoto)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setContentOffset:(float)contentOffset
{
    
    
    if ( _isScroll == YES) {

        self.sv.frame = CGRectMake(self.sv.frame.origin.x,
                                   40 - contentOffset*2, self.sv.frame.size.width, self.sv.frame.size.height);
        _logoIV.frame = CGRectMake(self.logoIV.frame.origin.x,
                                   93 - contentOffset*1.2, self.logoIV.frame.size.width, self.logoIV.frame.size.height);
    }


}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isScroll = NO;
    
    
    [_main setScrollEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _isScroll = YES;

    [_main setScrollEnabled:YES];
}


//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [_main setScrollEnabled:YES];
//}



//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    _isScroll = YES;
//    [_main setScrollEnabled:YES];
//
//}

//- (void)scro

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        _logoIV.frame = CGRectMake( _logoIV.frame.origin.x,
                                   logo_y -  scrollView.contentOffset.y*1.5 ,
                                   _logoIV.frame.size.width ,
                                   _logoIV.frame.size.height);
}




@end
