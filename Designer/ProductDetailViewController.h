//
//  ProductDetailViewController.h
//  OrientParkson
//
//  Created by i-Bejoy on 13-12-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface ProductDetailViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *productTableView;
    UITableView *infoTb;
    
    NSMutableArray *pDataMArray;
    
    bool isShowPrice;
}

@property(nonatomic, assign) int currentIndex;

@end
