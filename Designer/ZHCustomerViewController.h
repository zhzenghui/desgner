//
//  ZHCustomerViewController.h
//  Designer
//
//  Created by bejoy on 14/6/26.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NoteBaseViewController.h"
#import "CustomerCell.h"


#import "Customer.h"
#import "YISplashScreen.h"
#import "YISplashScreenAnimation.h"

#define SHOWS_MIGRATION_ALERT   0   // 0 or 1
#define ANIMATION_TYPE          2   // 0-2


#define kPage_size 6

typedef enum {
    CollectionTypeNormal = 1,
    CollectionTypeDelate = 0,
    
} CollectionType;




@interface ZHCustomerViewController : NoteBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate, UITextFieldDelegate>
{
    bool isopen;
    NSInteger currentPage;
    NSInteger currentPageCount;
    
    NSMutableArray *allDataMArray;
    
    UIButton *customerButton;
    UIButton *customerTrashButton;
    
    UIButton *newCustomerButton;
    UIButton *seachCustomerButton;
    UIButton *trashButton;
    
    UICollectionView *_collectionView;

    NSIndexPath *currentCustomerIndexPath;
    
    CollectionType currentCollectionType;
    CollectionTableType currentCollectionTableType;
    
    int  pi;

    int pageAllSize;
    
    
    UIView *seachView ;
    
    UIImageView *fangdajingIV;
    UITextField *seachTF;
    UIImageView *space;
    
    
    
    
}




@property(nonatomic, retain) IBOutlet UIImageView *bgImageView;

@property(nonatomic, retain) IBOutlet UIImageView *converImageView;
@property(nonatomic, retain) IBOutlet UIImageView *pageAnimotionImageView;
@property(nonatomic, retain) IBOutlet UIView *contentView;
@property(nonatomic, retain) IBOutlet UILabel *pageNumLabel;
@property(nonatomic, retain) IBOutlet UIView *contentMenuView;




@end
