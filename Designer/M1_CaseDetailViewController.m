//
//  ZHCaseDetailViewController.m
//  Designer
//
//  Created by bejoy on 14-3-30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M1_CaseDetailViewController.h"

@interface M1_CaseDetailViewController ()
{
    UIScrollView *sv;
    
    UIPageControl *_pageControl;
    UIView *descView;
}
@end

@implementation M1_CaseDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)closeDesc
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        descView.alpha = 0;
    }];

}

- (void)openDesc:(UIButton *)button
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        if (descView.alpha == 0) {
            descView.alpha = 1;
        }
        else {
            descView.alpha = 0;
        }
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.frame];
    v.backgroundColor = [UIColor blackColor];
    v.alpha = .8;
    [self.view addSubview:v];
    

    
    sv = [[UIScrollView alloc] initWithFrame:RectMake2x(40 , 80, 1968, 1416)];
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.delegate = self;
    
    [self.view addSubview:sv];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame: RectMake2x(40, 1408, 1968, 54)];
    _pageControl.numberOfPages = self.dataMArray.count;
    _pageControl.currentPage = 0;
    
    [self.view addSubview:_pageControl];
    
    
    
    int h = 1968;
    
    int i = 0;
    for (NSDictionary *dict in self.dataMArray) {
        
        NSString *name = [[[dict objectForKey:@"store_name"] componentsSeparatedByString:@"."] firstObject];
        
//        NSString *fileName = [NSString stringWithFormat:@"%@929x673.jpg", name];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
        NSString *path = [NSString stringWithFormat:@"%@", KCachesName(fileName)];

        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
        UIImageView *iv = [[UIImageView alloc] initWithImage:img];
        iv.frame = RectMake2x(h*i , 0,  1968, 1416);
        iv.backgroundColor = [UIColor whiteColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;

        [sv addSubview:iv];
        
        [[Button share] addToView:sv addTarget:self rect: RectMake2x(h*i , 0, 1968, 1416) tag:i  action:@selector(openDesc:)];
        i ++;
    }
    [sv setContentSize:CGSizeMake(1968/2 * (self.dataMArray.count), 1416/2) ];
    
    
    

    
    descView = [[UIView alloc] init];
    descView.alpha = 0;
    descView.frame = RectMake2x(40 , 1058, 1968, 438);
    descView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"平面作品-logo-1"]];
    [self.view addSubview:descView];

    
//    [[Button share] addToView:descView addTarget:self rect: RectMake2x(0 , 0, 2048, 1536) tag:i  action:@selector(closeDesc)];

    
    UILabel *label = [[UILabel alloc] initWithFrame:RectMake2x(349 , 40,1500, 50)];
    label.text = [self.dataMDict objectForKey:@"a_name"];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:25];

    [descView addSubview:label];
    
    
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:RectMake2x(349 , 126,1500, 250)];
    [descView addSubview:scrollview];
    
    
    UILabel *tv = [[UILabel alloc] initWithFrame:RectMake2x(0 , 0,1500, 186)];
    tv.backgroundColor = [UIColor clearColor];
    tv.textColor = [UIColor whiteColor];
    tv.numberOfLines = 0;
    tv.font = [UIFont systemFontOfSize:13];
    tv.text = [self.dataMDict objectForKey:@"content"];
    
    if ( [[self.dataMDict objectForKey:@"content"] isEqualToString:@"<null>"]) {
        tv.text = @"";
    }
    [scrollview addSubview:tv];

    
    
    
    NSString *s = [self.dataMDict objectForKey:@"content"];
    CGSize size = [s sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:(CGSize){750, CGFLOAT_MAX}];
    tv.frame = CGRectMake(0, 0, size.width, size.height);
    
    
   
    [scrollview setContentSize:size];
    
    scrollview.pagingEnabled = NO;
    
    
    
    
    

    [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1895 , 80, 110, 130) tag:Action_Back action:@selector(back:) imagePath:@"按钮-关闭"];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    
}

@end
