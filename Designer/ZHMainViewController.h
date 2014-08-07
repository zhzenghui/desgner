//
//  ZHMainViewController.h
//  Designer
//
//  Created by bejoy on 14/6/17.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FadeView.h"
#import "M1_CasesViewController.h"
#import "SlideImageView.h"
#import "PaintCell.h"



@interface ZHMainViewController : UIViewController<AVAudioPlayerDelegate, SlideImageViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

{
    
    
    CGPoint lastOffset;
    NSTimeInterval lastOffsetCapture;
    BOOL isScrollingFast;
    
    
    NSMutableArray *paintArray;
    UIButton *  _button;
    
    
    UIImageView *grougPhotoImageView;
    UIView *grougPhotoView;
//    main
    UIButton *shuaxinButton;
    UIImageView *main_logoImageView;
    FadeView *fv;
    
    
    UICollectionView *_collectionView;

    
    UIImageView *info_logo;
    UIImageView *jianli ;
    M1_CasesViewController *casecv;
    
    
    SlideImageView* slideImageView;

    
    int currentImage;
    UIImageView *changimage;
    UIView *vSwipe;
    
    UILabel *label;
}


@property (nonatomic, retain) AVAudioPlayer *player;

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) IBOutlet UIScrollView *sv1;
@property (nonatomic, strong) IBOutlet UIView *sv1_v;
@property (nonatomic, strong) IBOutlet UIView *sv1_v1;
@property (nonatomic, strong) IBOutlet UIView *sv1_v2;
@property (nonatomic, strong) IBOutlet UIView *sv1_v3;


@property (nonatomic, strong) IBOutlet UIScrollView *sv2;
@property (nonatomic, strong) IBOutlet UIView *sv2_v;
@property (nonatomic, strong) IBOutlet UIView *sv2_v1;
@property (nonatomic, strong) IBOutlet UIView *sv2_v2;

@property (nonatomic, strong) IBOutlet UIScrollView *sv3;
@property (nonatomic, strong) IBOutlet UIView *sv3_v;
@property (nonatomic, strong) IBOutlet UIView *sv3_v1;
@property (nonatomic, strong) IBOutlet UIView *sv3_v2;
@property (nonatomic, strong) IBOutlet UIView *sv3_v3;


@property (nonatomic, strong) UIScrollView *paintSView;



- (void)setScrollEnabled:(BOOL)b;





@end
