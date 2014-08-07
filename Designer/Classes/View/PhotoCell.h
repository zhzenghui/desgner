//
//  PhotoCell.h
//  Designer
//
//  Created by bejoy on 14/7/8.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"


typedef enum {
  PhotoCellTypeNormal,
  PhotoCellTypeDelete
} PhotoCellType;
@interface PhotoCell : UICollectionViewCell<UITextFieldDelegate>


@property (assign, nonatomic) PhotoCellType cellType;


@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextField *nameLabel;
@property (retain, nonatomic) IBOutlet UIButton  *button;




@property (retain, nonatomic) Photo *photo;

- (IBAction)openText:(id)sender;

@end
