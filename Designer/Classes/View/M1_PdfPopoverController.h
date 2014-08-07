//
//  PdfPopoverController.h
//  Designer
//
//  Created by bejoy on 14-3-7.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//



@interface M1_PdfPopoverController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIViewController *viewController;
@property(nonatomic, strong) UIPopoverController *popController;


@end
