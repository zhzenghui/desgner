//
//  ProductListViewController.h
//  OrientParkson
//
//  Created by i-Bejoy on 13-12-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface ProductListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    
    UITableView *productTableView;
    UICollectionView *_collectionView;
}



@property(nonatomic, assign) id delegate;


@end
