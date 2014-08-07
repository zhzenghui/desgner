//
//  productCCell.h
//  OrientParkson
//
//  Created by i-Bejoy on 14-1-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CollectionTableTypeNormal = 1,
    CollectionTableTypeDelete = 0,
    
} CollectionTableType;




@class Customer;
@interface CustomerCell : UICollectionViewCell
{
 
}


@property(nonatomic, assign) CollectionTableType type;

@property(nonatomic, strong) Customer *customer;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adreeLable;

@property (weak, nonatomic) IBOutlet UIButton  *button;



@end
