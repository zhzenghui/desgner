//
//  ZHNewsDetailViewController.m
//  Designer
//
//  Created by bejoy on 14-3-31.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHNewsDetailViewController.h"
#import "SVProgressHUD.h"


@interface ZHNewsDetailViewController ()

@end

@implementation ZHNewsDetailViewController


 


- (void)setNavigationBarView
{
    
    
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contentWebView = [[UIWebView alloc] init];
    contentWebView.frame = RectMake2x(0 , 190, 1938, 1346);
    contentWebView.layer.cornerRadius = 8;
    contentWebView.clipsToBounds = YES;
    contentWebView.delegate = self;
    contentWebView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"内容页-bg"]];
    
    contentWebView.scalesPageToFit = YES;
    [self.baseView addSubview:contentWebView];
    
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [self setNavigationBarView];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    [contentWebView  loadHTMLString:_htmlStr baseURL:nil];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
