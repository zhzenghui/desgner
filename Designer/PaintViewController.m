//
//  PaintViewController.m
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PaintViewController.h"

@interface PaintViewController ()
{
    NSMutableArray *paintArray;
    
    UIScrollView *sv;
    UIPageControl *_pageControl;
    
    UILabel *label;
}
@end

@implementation PaintViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    [[ImageView share] addToView:self.view imagePathName:@"2级-手绘-画框" rect:backgroundSize];
    
    


    
    sv = [[UIScrollView alloc] initWithFrame: RectMake2x(184, 308, 1790, 1154)];
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.delegate = self;
    
    
    
//    [sv addSubview:launchView];
//    [sv addSubview:mainView];
//    
//    [sv addSubview:iv];
    
    
    [self.view addSubview:sv];

    
    
    

    
    
    
    [[ImageView share] addToView:self.view imagePathName:@"2级-手绘-铅笔" rect:backgroundSize];

}

- (void)loadData
{
    
    paintArray = [[ZHDBData share] getPhotoForD_Id:kD_Id];
    
    if (paintArray.count ==  0) {
        [[Message share] messageAlert:@"您尚未上传手绘作品， 赶紧登录上传吧！"];
        return;
    }
    for (int i = 0; i < paintArray.count; i++) {
        NSString *imgStr =[NSString stringWithFormat:@"%@", paintArray[i][@"store_name"]];
        
        CGRect rect = CGRectMake(sv.frame.size.width *i , 0, sv.frame.size.width, sv.frame.size.height);
        NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];

        UIImageView *iv = [[UIImageView alloc] initWithImage:img3];
        iv.frame = rect;
        
        [sv addSubview:iv];
    }
    
    
    [sv setContentSize:CGSizeMake(sv.frame.size.width*paintArray.count, sv.frame.size.height)];

    
    label = [[UILabel alloc] initWithFrame:RectMake2x(184, 1408, 1790, 54)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    label.text = [NSString stringWithFormat:@"%d/%d", 1, paintArray.count];

    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    
    [self addMemu];
    [self addBackView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    for (int i = 0; i < paintArray.count; i++) {
        
        if (i < 2) {
            continue;
        }
        NSString *imgStr =[NSString stringWithFormat:@"%@", paintArray[i][@"store_name"]];
        NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
        CGRect rect = CGRectMake(sv.frame.size.width *i , 0, sv.frame.size.width, sv.frame.size.height);
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:img3];
        iv.frame = rect;
        iv.contentMode = UIViewContentModeScaleAspectFit;

        [sv addSubview:iv];
    }
    
    
    [sv setContentSize:CGSizeMake(sv.frame.size.width*paintArray.count, sv.frame.size.height)];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
        label.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / scrollView.frame.size.width)+1, paintArray.count];
}

@end
