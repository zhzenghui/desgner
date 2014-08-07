//
//  WebViewController.m
//  M32
//
//  Created by i-Bejoy on 13-12-8.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "M1_WebViewController.h"
#import "SVProgressHUD.h"
#import "ZHNavigationViewController.h"


@interface M1_WebViewController ()

@end

@implementation M1_WebViewController



- (void)popViewController
{
    if (self.zhNavigationController) {
        [self.zhNavigationController popViewController];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


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
    contentWebView.frame = CGRectMake(55, 20, 1024-55, screen_Height);
    contentWebView.delegate = self;
    contentWebView.scalesPageToFit = YES;
    [self.view addSubview:contentWebView];
    
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    [self setNavigationBarView];

    
    

    [self addMemu];
    [self addBackView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    

    
    [contentWebView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    
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
