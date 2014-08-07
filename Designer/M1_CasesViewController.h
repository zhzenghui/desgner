//
//  CasesViewController.h
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"



@interface M1_CasesViewController : M1_BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    UITableView *tb;
    

    NSMutableArray *tagsArray;
}


@property(nonatomic) float contentOffset;

@property (nonatomic, assign) UIViewController* owner;



- (void)loadData;
- (void)loadTags;

- (void)reload;

@end
