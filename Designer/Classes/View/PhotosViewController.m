//
//  PhotosViewController.m
//  Designer
//
//  Created by bejoy on 14/7/9.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PhotosViewController.h"
#import "Photo.h"


@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)back:(UIButton *)button
{
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];


    [[Button share] addToView:self.view addTarget:self rect:RectMake2x(78, 1337, 80, 80) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-00"];


    self.sv .alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated
{
    int i = 0;
    int width = 1024;
    
    for (Photo *p in self.photos) {
    
        UIImage *img = [Image imageForPath:KDocumentName(p.stroe_name)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        imageView.frame = CGRectMake(i*width, 0, 1024, 768);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.sv addSubview:imageView];
        
        i ++;
    }
    
    
    [self.sv setContentSize:CGSizeMake(1024*self.photos.count, 768)];
    
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.sv .alpha = 1;;
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
