//
//  CasesViewController.h
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_BaseViewController.h"



@interface M2_CasesViewController : M2_BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>
{
    
    UITableView *tb;
    UICollectionView *_collectionView;


    NSMutableArray *tagsArray;
}


@property(nonatomic) float contentOffset;

@property (nonatomic, assign) UIViewController* owner;



- (void)loadData;
- (void)loadTags;

- (void)reload;

@end
