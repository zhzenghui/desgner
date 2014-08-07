//
//  M2_PaintViewController.h
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_BaseViewController.h"

@interface M2_PaintViewController : M2_BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *paintArray;

    UIImageView *grougPhotoImageView;
    UIView *grougPhotoView;

}


@end
