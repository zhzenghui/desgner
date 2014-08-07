//
//  ZHMainViewController.m
//  Designer
//
//  Created by bejoy on 14/6/17.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHMainViewController.h"
#import "UIImage+ImageEffects.h"
#import "M1_CasesViewController.h"
#import "ZHViewController.h"
#import "BejoyViewController.h"
#import "M1_GroupPhotoViewController.h"
#import "PdfPopoverController.h"
#import "M1_PdfPopoverController.h"
#import "FadeView.h"
#import "ZHCustomerViewController.h"

#import "POP.h"
#import "PaintCell.h"

@interface ZHMainViewController ()
{
    UIImageView *logo;
    UIImageView *start;
    
    UIView *addressView ;
    M1_GroupPhotoViewController *cvPV;
}
@end

@implementation ZHMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadFeiyeAnimation
{
    
//    [_sv2 setScrollEnabled:NO];
//    1 背景
    [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-背景" rect:RectMake2x(40, 80, 1968, 1416)];
    [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-背景" rect:RectMake2x(40, 80, 1968, 1416)];
    
    UIImageView *bgXuhuaIV1 = [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-背景" rect:
                               CGRectMake(0, 0, 1024, 768)];

    
    UIImageView *yunIV = [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-图案" rect:RectMake2x(40, 80, 1968, 1416)];
    UIImageView *wenziIV = [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-文字" rect:RectMake2x(40, 80, 1968, 1416)];
    logo = [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-logo-00" rect:RectMake2x(40, 80, 1968, 1416)];;
    start  = [[ImageView share] addToView:_sv2_v1 imagePathName:@"扉页-logo-01" rect:RectMake2x(40, 80, 1968, 1416)];


    bgXuhuaIV1.alpha = 0;
    yunIV.alpha  = 0;
    wenziIV.alpha  = 0;
    logo.alpha  = 0;
    start.alpha  = 0;

    UIImage *image = [UIImage imageNamed:@"扉页-背景"];
    
    
    image = [image applyDarkEffect];
    bgXuhuaIV1.image = image;
    
    
    
    [UIView animateWithDuration:kLongLongDuration animations:^{
     
        yunIV.alpha = 1;
        wenziIV.alpha = 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:kLongLongDuration animations:^{
                yunIV.alpha = 0;
                wenziIV.alpha = 0;
                bgXuhuaIV1.alpha  = 1;
                logo.alpha = 1;
                        start.alpha = 1;
            } completion:^(BOOL finished) {
                [_sv2 setScrollEnabled:YES];

            }];
            
            
        }
    }];
}

- (void)loadMain
{
    _sv3_v1.backgroundColor = [UIColor whiteColor];
    
    [[ImageView share] addToView:_sv3_v1 imagePathName:@"首页-背景" rect:RectMake2x(40, 80, 1968, 1416)];
    main_logoImageView = [[ImageView share] addToView:_sv3_v1 imagePathName:@"首页-logo" rect:RectMake2x(587, 350+768, 205, 366)];

    
    addressView = [[UIView alloc] initWithFrame:RectMake2x(0, 0, 2048, 1536)];

    shuaxinButton =  [[Button share] addToView:_sv3_v1 addTarget:self rect:RectMake2x(40, 976, 110, 130) tag:1000 action:@selector(update:)
                    imagePath:@"按钮-刷新"];
    [[Button share] addToView:_sv3_v1 addTarget:self rect:RectMake2x(40, 1106, 110, 130) tag:1001 action:@selector(openAdress:)
                    imagePath:@"按钮-地址"];
    [[Button share] addToView:_sv3_v1 addTarget:self rect:RectMake2x(40, 1236, 110, 130) tag:1002 action:@selector(controlMusic:)
                    imagePath:@"按钮-音乐-开" highlightedImagePath:@""
                    SelectedImagePath:@"按钮-音乐-关"];
    [[Button share] addToView:_sv3_v1 addTarget:self rect:RectMake2x(40, 1366, 110, 130) tag:1003 action:@selector(openBejoy)
                    imagePath:@"按钮-bejoy"];
    
    
 
    fv = [[FadeView alloc] initWithFrame:RectMake2x(314, 861 +768, 750, 250)];
    fv.fileNamesArray = @[@"首页-文案-01", @"首页-文案-02", @"首页-文案-03", @"首页-文案-04", @"首页-文案-05", @"首页-文案-06"];
    [fv startFade];
    [_sv3_v1 addSubview:fv];   
    
    
    
    addressView.alpha = 0;
    UIImageView *iv = [[ImageView share] addToView:addressView imagePathName:@"首页-背景" rect:RectMake2x(0, 0, 2048, 1536)];
    iv.image = [[UIImage imageNamed:@"首页-背景"] applyDarkEffect];
    
//    addressView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"首页-背景"] applyDarkEffect ]];
    
    [[ImageView share] addToView:addressView imagePathName:@"首页-联系信息" rect:RectMake2x(40, 40, 1968, 1416)];
    [[Button share] addToView:addressView addTarget:self rect:RectMake2x(40, 40, 1968, 1416) tag:1004 action:@selector(openAdress:)
     ];
    [_sv3_v1 addSubview:addressView];
    
    
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"music"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    
    self.player = newPlayer;
    [newPlayer setVolume: 1.0];
    newPlayer.numberOfLoops = 1000;
    [newPlayer prepareToPlay];
    [newPlayer setDelegate: self];
    [newPlayer play];
    
}


- (void)loadCase
{
    casecv = [[M1_CasesViewController alloc] init];
    casecv.owner = self;
    [_sv1_v1 addSubview:casecv.view];
    [self addChildViewController:casecv];
}

- (void)loadGroupPhoto
{
    
    cvPV = [[M1_GroupPhotoViewController alloc]   initWithNibName:@"M1_GroupPhotoViewController" bundle:nil];
    cvPV.main =  self;
    [_sv3_v2 addSubview:cvPV.view];
    [self addChildViewController:cvPV];
    
    
}

/*
-(void)left
{
    if (paintArray.count == 0) {
        return;
    }
    
    if (currentImage< paintArray.count-1) {
        currentImage+=1;
        
        
        label.text = [NSString stringWithFormat:@"%d/%d", currentImage+1,paintArray.count];

        
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.6f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        //        animation.type = kCATransitionMoveIn;
        animation.type = @"pageUnCurl";
        animation.subtype = kCATransitionFromLeft;
        [[changimage layer] addAnimation:animation forKey:@"animation"];
        
        NSString *imgStr =[NSString stringWithFormat:@"%@", paintArray[currentImage][@"store_name"]];
        NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KDocumentName(fileName)];
        
        changimage.image =  img3;
    }
}
-(void)right
{
    
    if (paintArray.count == 0) {
        return;
    }
    
    
    if (currentImage>0) {
        currentImage-=1;
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.6f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"pageUnCurl";
        animation.subtype = kCATransitionFromRight;
        [[changimage layer] addAnimation:animation forKey:@"animation"];
        
        
        
        label.text = [NSString stringWithFormat:@"%d/%d", currentImage+1,paintArray.count];
        
        NSString *imgStr =[NSString stringWithFormat:@"%@", paintArray[currentImage][@"store_name"]];
        NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KDocumentName(fileName)];

        changimage.image =  img3;
    }
    
    
}

*/
- (void)loadPaintData
{
    
    
    paintArray = [[ZHDBData share] getPhotoForD_Id:kD_Id];
    
    [_collectionView reloadData];
}




- (void)loadPaint
{
    [[ImageView share] addToView:_sv1_v3 imagePathName:@"手绘-背景" rect:RectMake2x(40, 80, 1968, 1416)];
    

    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView =[[UICollectionView alloc] initWithFrame:RectMake2x(634, 120, 1334, 1336) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.backgroundColor = [UIColor clearColor];

    [_collectionView registerClass:[PaintCell class]  forCellWithReuseIdentifier:@"ProductCCell"];

    
    [_sv1_v3 addSubview:_collectionView];
    

    
    
    [self loadPaintData];
    

}


- (void)loadInfomation
{
    
    [[ImageView share] addToView:_sv3_v3 imagePathName:@"简历页-背景" rect:RectMake2x(40, 80, 1968, 1416)];
    info_logo =    [[ImageView share] addToView:_sv3_v3 imagePathName:@"简历页-logo" rect:RectMake2x(1795, 128 + 1536, 173, 309)];
    jianli =    [[ImageView share] addToView:_sv3_v3 imagePathName:@"简历页-文字-简历" rect:RectMake2x(728, 381, 1077 + 1536, 833)];
    
    

    NSString *imgNormal = [NSString stringWithFormat:@"按钮-pdf" ];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(20, 40 , 110/2, 130/2);
    [_button addTarget:self action:@selector(openPDFListView:) forControlEvents:UIControlEventTouchUpInside];
    [_button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    
    [_sv3_v3 addSubview:_button];
    
    
    
    
}

- (void)reloadLoadData
{
    [casecv reload];
    [casecv loadTags];
    
    [self loadPaintData];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return paintArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PaintCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [paintArray objectAtIndex:indexPath.row];
    cell.dict = dict;
    
    return cell;

    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(647/2, 459/2);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = paintArray[indexPath.row];
    
    NSString *imgStr =[NSString stringWithFormat:@"%@", dict[@"store_name"]];
    NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
    NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
    
    
    

    grougPhotoImageView.image = img;


    
    [UIView animateWithDuration:KLongDuration animations:^{
        grougPhotoView.alpha = 1;
    }];
}


#pragma mark - action

- (void)closeView
{
    [UIView animateWithDuration:KLongDuration animations:^{
        grougPhotoView.alpha = 0;
    }];
}

- (void)controlMusic:(UIButton *)button
{
    
    // if already playing, then pause
    if (self.player.playing) {
        [self.player pause];
        button .selected = YES;
    } else {
        [self.player play];
        button .selected = NO;
    }
    
}




- (void)openPDFListView:(UIButton *)button
{

    
    M1_PdfPopoverController *pdfVC = [[M1_PdfPopoverController alloc] init];
    pdfVC.viewController = self;
    
    pdfVC.view.alpha  = 0 ;
    [UIView animateWithDuration:KLongDuration animations:^{
        pdfVC.view.alpha  = 1 ;
    }];
    
    [self.view addSubview:pdfVC.view];
    [self addChildViewController:pdfVC];
    
}

- (void)openAdress:(UIButton *)button
{
    [UIView animateWithDuration:KLongDuration animations:^{
       
        if (addressView.alpha == 0) {
            addressView.alpha = 1;
        }
        else
            addressView.alpha = 0;
    }];
}


- (void)openCustomerViewController :(UIButton *)button
{

    ZHCustomerViewController *pdfVC = [[ZHCustomerViewController alloc] initWithNibName:@"ZHCustomerViewController" bundle:nil];
    
    pdfVC.view.alpha  = 0 ;
    [UIView animateWithDuration:KLongDuration animations:^{
        pdfVC.view.alpha  = 1 ;
    }];
    
    [self.view addSubview:pdfVC.view];
    [self addChildViewController:pdfVC];
    
}

- (void)update:(UIButton *)button
{
    
    ZHViewController *vc = [[ZHViewController alloc] init];
    [self addChildViewController:vc];
    
    [vc update];
    
}

- (void)openBejoy
{

    BejoyViewController *    bv = [[BejoyViewController alloc] init];

    bv.view.alpha  = 0;
    [self.view addSubview:bv.view];
    [self addChildViewController:bv];

    [UIView animateWithDuration:KMiddleDuration animations:^{
        bv.view.alpha  = 1;
    }];
}


- (void)setScrollEnabled:(BOOL)b
{
    [_sv3 setScrollEnabled:b];
}

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];

    isScrollingFast = NO;

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLoadData) name:@"reloadLoadCase" object:nil];
    
    [_sv1 setPagingEnabled:YES];
    [_sv1 setScrollEnabled:NO];

    
    _sv1.showsHorizontalScrollIndicator = NO;
    _sv1.showsVerticalScrollIndicator = NO;

    _sv2.showsHorizontalScrollIndicator = NO;
    _sv2.showsVerticalScrollIndicator = NO;

    _sv3.showsHorizontalScrollIndicator = NO;
    _sv3.showsVerticalScrollIndicator = NO;

    
    
    [_sv1 addSubview:_sv1_v];
    
    [_sv1 setContentSize:CGSizeMake(3072, 768)];
    [_sv1 scrollRectToVisible:CGRectMake(1024, 0, 1024, 768) animated:NO];

    
    [_sv2 setPagingEnabled:YES];
    [_sv2 addSubview:_sv2_v];
    [_sv2 setContentSize:CGSizeMake(1024, 768*2)];

    
    
    
    [_sv3 setPagingEnabled:YES];
    [_sv3 addSubview:_sv3_v];
    [_sv3 setContentSize:CGSizeMake(1024, 768*3)];

    
    
    [self loadFeiyeAnimation];
    [self loadMain];
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    [self loadPaint];
    [self loadCase];
    [self loadGroupPhoto];
    [self loadInfomation];
    
    
    
    grougPhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    grougPhotoView.alpha = 0;
    [self.view addSubview:grougPhotoView];
    
    grougPhotoImageView = [[ImageView share] addToView:grougPhotoView imagePathName:@"" rect:RectMake2x(40, 80,  1968, 1416)];
    
    [[Button share] addToView:grougPhotoView addTarget:self rect:CGRectMake(0, 0, 1024, 768) tag:1000 action:@selector(closeView)];
    
    
    
    [self openCustomerViewController:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mainAnimation
{
//    main_logoImageView.frame = RectMake2x(587, 350, 205, 366);
    
    
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    CGPoint currentOffset = scrollView.contentOffset;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeDiff = currentTime - lastOffsetCapture;
    if(timeDiff > 0.1) {
        CGFloat distance = currentOffset.y - lastOffset.y;
        //The multiply by 10, / 1000 isn't really necessary.......
        CGFloat scrollSpeedNotAbs = (distance * 10) / 1000; //in pixels per millisecond
        
        CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
        if (scrollSpeed > 0.5) {
            isScrollingFast = YES;
            NSLog(@"Fast");
        } else {
            isScrollingFast = NO;
            NSLog(@"Slow");
        }
        
        lastOffset = currentOffset;
        lastOffsetCapture = currentTime;
    }
    
    
    
    
//   屏蔽扉页 返回
    if (_sv2.contentOffset.y > 700) {
        [_sv2 setScrollEnabled:NO];
        [_sv1 setScrollEnabled:YES];
        logo.alpha = 0;
        start.alpha = 0;
        
    }

    if (_sv2.contentOffset.y > 0) {
        
        fv.frame = RectMake2x(314,  (861+1536 ) -(2*_sv2.contentOffset.y), 750, 250);
        main_logoImageView.frame = RectMake2x(587, (350+1536 ) -( 2*_sv2.contentOffset.y) , 205, 366);

    }
    
//    手绘
    
    
    
    
    
    
    if (_sv1 == scrollView) {
        //    案例
        float fx = _sv1.contentOffset.x *2;
        
        [casecv setContentOffset:fx];
        
        
//        float f = _sv1.contentOffset.x - 2048;
        
        
        
        
        
    }

    
    if (_sv3.contentOffset.y > 0) {


        float f = _sv3.contentOffset.y - 768;
        float f2 = _sv3.contentOffset.y - 1536;
        
        
        //    主页
        fv.frame = RectMake2x(314,  861 -(2*_sv3.contentOffset.y ), 750, 250);
        main_logoImageView.frame = RectMake2x(587, 350 -( 2*_sv3.contentOffset.y )*1.5 , 205, 366);
        
        //    合影
        [cvPV setContentOffset:f];
        
        //    个人信息
        info_logo.frame = RectMake2x(1795, 128 + -(2*f2 ), 173, 309);
        
        
        jianli.frame  = RectMake2x(728, 381 + -(2*f2 )*1.5, 1077 , 833);
//        info_logo =    [[ImageView share] addToView:_sv3_v3 imagePathName:@"简历页-logo" rect:RectMake2x(1795, 128 + 1536, 173, 309)];
//        jianli =    [[ImageView share] addToView:_sv3_v3 imagePathName:@"简历页-文字-简历" rect:RectMake2x(728, 381, 1077 + 1536, 833)];
        
        

    }

    
    if (scrollView == _sv2) {
        logo .frame = CGRectMake(20, 40+ scrollView.contentOffset.y * 2, 1968/2, 1416/2);
        start.frame = CGRectMake(20, 40+ -scrollView.contentOffset.y, 1968/2, 1416/2);
    }
}


//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView* result = [super hitTest:point withEvent:event];
//    if ([result.superview isKindOfClass:[UIScrollView class]])
//    {
//        self.scrollEnabled = NO;
//    }
//    else     {
//        self.scrollEnabled = YES;
//    }
//    return result;
//}

@end
