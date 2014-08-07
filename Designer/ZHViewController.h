//
//  ZHViewController.h
//  Designer
//
//  Created by bejoy on 14-3-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPassDataJSON.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "SGFocusImageFrame.h"


@interface ZHViewController : UIViewController<UIScrollViewDelegate, ZHPassDataJSONDelegate, DownloaderDelegate, UIAlertViewDelegate, SGFocusImageFrameDelegate>
{
    UIButton *currentButton;
    
    NSMutableArray *picArray;

}



@property(nonatomic, retain) NSMutableArray *viewControllers;
@property(nonatomic, retain) NSMutableArray *dataMArray;

@property (nonatomic, strong) PendingOperations *pendingOperations;



- (void)update;

@end
