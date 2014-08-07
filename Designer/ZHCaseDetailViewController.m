//
//  ZHCaseDetailViewController.m
//  Designer
//
//  Created by bejoy on 14-3-30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHCaseDetailViewController.h"

@interface ZHCaseDetailViewController ()
{
    UIScrollView *sv;
    
    UIPageControl *_pageControl;
    UIView *descView;
}
@end

@implementation ZHCaseDetailViewController

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
        descView.alpha = 1;
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    sv = [[UIScrollView alloc] initWithFrame:RectMake2x(150 , 190, 1858, 1346)];
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.delegate = self;
    
    [self.view addSubview:sv];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame: RectMake2x(184, 1408, 1790, 54)];
    _pageControl.numberOfPages = self.dataMArray.count;
    _pageControl.currentPage = 0;
    
    [self.view addSubview:_pageControl];
    
    
    
    int h = 1858;
    
    int i = 0;
    for (NSDictionary *dict in self.dataMArray) {
        
        NSString *name = [[[dict objectForKey:@"store_name"] componentsSeparatedByString:@"."] firstObject];
        
//        NSString *fileName = [NSString stringWithFormat:@"%@929x673.jpg", name];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
        NSString *path = [NSString stringWithFormat:@"%@", KCachesName(fileName)];

        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
        UIImageView *iv = [[UIImageView alloc] initWithImage:img];
        iv.frame = RectMake2x(h*i , 0, 1858, 1346);
        iv.backgroundColor = [UIColor blackColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;

        [sv addSubview:iv];
        
        [[Button share] addToView:sv addTarget:self rect: RectMake2x(h*i , 0, 1858, 1346) tag:i  action:@selector(openDesc:)];
        i ++;
    }
    [sv setContentSize:CGSizeMake(1858/2 * (self.dataMArray.count), 1346/2) ];
    
    
    descView = [[UIView alloc] init];
    descView.alpha = 0;
    descView.frame = RectMake2x(150 , 190, 1858, 1346);
    [self.view addSubview:descView];
    
    
    UIView *v = [[UIView alloc] init];
    v.frame =RectMake2x(0 , 0, 1858, 1346);
    v.backgroundColor = [UIColor blackColor];

    v.alpha = .9;
    [descView addSubview:v];
    
    
    UITextView *tv = [[UITextView alloc] initWithFrame:RectMake2x(15 , 19, 1800, 1300)];
    tv.backgroundColor = [UIColor clearColor];
    tv.textColor = [UIColor whiteColor];
    [tv setEditable:NO];
    tv.font = [UIFont systemFontOfSize:13];
    tv.text = [self.dataMDict objectForKey:@"content"];
    DLog(@"%@", [self.dataMDict objectForKey:@"content"]);
    
    if ( [[self.dataMDict objectForKey:@"content"] isEqualToString:@"<null>"]) {
        tv.text = @"";
    }
    
    
    [descView addSubview:tv];
    
    NSString *s = [self.dataMDict objectForKey:@"content"];
    CGSize size = [s sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:(CGSize){900, CGFLOAT_MAX}];
    
    tv.frame = CGRectMake(15/2, descView.frame.size.height - size.height -65, size.width, size.height+30);
    
    v.frame = CGRectMake(0, descView.frame.size.height - size.height -105, 1858, size.height+105);

    
    
    [[Button share] addToView:descView addTarget:self rect: RectMake2x(0 , 0, 1858, 1346) tag:i  action:@selector(closeDesc)];
    
    
    
    [self addMemu];
    [self addBackView];
    
    
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
