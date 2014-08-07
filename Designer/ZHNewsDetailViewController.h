//
//  ZHNewsDetailViewController.h
//  Designer
//
//  Created by bejoy on 14-3-31.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface ZHNewsDetailViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *contentWebView;
    
}


@property(nonatomic, strong) NSString *htmlStr;

@end
