//
//  ProductListViewController.m
//  OrientParkson
//
//  Created by i-Bejoy on 13-12-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductDetailViewController.h"
#import "ProductCCell.h"
#import "Button.h"
#import "SeachViewController.h"


@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (void)back:(UIButton *)button
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"animationFullSrceen" object:nil userInfo:nil];
//
//    [UIView animateWithDuration:KMiddleDuration animations:^{
//        self.view.alpha  = 0;
//    } completion:^(BOOL finished) {
//        
//        if (finished) {
//            [self.view removeFromSuperview];
//            [self removeFromParentViewController];
//            
//        }
//    }];


    [self.navigationController popViewControllerAnimated:NO];
}


- (void)openSeach:(UIButton *)button
{
    SeachViewController *seach = [[SeachViewController alloc]     init];
    
    
    [self.navigationController pushViewController:seach animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    

    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
    [_collectionView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{

    [super viewDidDisappear:YES];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataReload
{
    [productTableView reloadData];
}

- (void)addPicToDataArray
{
    
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    
    if ( self.dataMArray .count > 0 ) {
        
        for (NSMutableDictionary *dict in self.dataMArray) {
            NSString *p_id = [dict objectForKey:@"product_id"];
            NSArray *pic_Arr = [[ZHDBData share] getPicsForProductId:p_id];
            
            if (pic_Arr.count != 0 ) {
              
                NSString *pic = [[pic_Arr objectAtIndex:0] objectForKey:@"name"];
                [dict setObject:pic forKey:@"pic_name"];
                
                [arrayM addObject:dict];
            }

        }
    }
    
    self.dataMArray = arrayM;
    
}

- (void)loadData
{

    self.dataMArray = [[NSMutableArray alloc] init];
    self.dataMArray = [[ZHDBData share] getProductForCategory:@""];

}


- (void)loadCate:(NSNotification *) notification
{
    
    NSString *string = [NSString stringWithFormat:@"%@", notification.object];
    
    self.dataMArray = [[ZHDBData share] getProductForCategory:string];

    [_collectionView reloadData];
}




- (void)loadView
{
    [super loadView];
    

    
//    [self addBackView];
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, 1024, 748);
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tyzx-bg"]];
    
    
    [self.view addSubview:backView];
    
    
    
    
 
    
    [[ImageView share] addToView:self.view imagePathName:@"cpzx-sst" rect:CGRectMake(415, 39, 460, 46)];
    
    
    
    [[Button share] addToView:self.view addTarget:self rect:CGRectMake(763, 39, 112, 46) tag:1000 action:@selector(openSeach:) ];
    [[Button share] addToView:self.view addTarget:self rect:CGRectMake(885, 39, 46, 46) tag:1000 action:@selector(openSeach:) imagePath:@"tyzx-an-back"];
    [[Button share] addToView:self.view addTarget:self rect:CGRectMake(941, 39, 46, 46) tag:1000 action:@selector(back:) ];
    
    
    
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(37, 143, 950, 565) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];

    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[ProductCCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubview:_collectionView];


    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCate:) name:@"loadCate" object:nil];
    
}

#pragma mark - action

- (void)openProductDetail:(NSIndexPath *)indexPath
{
 
    
    
    
    int index = indexPath.row;
    
    ProductDetailViewController *lvc = [[ProductDetailViewController alloc] init];
    lvc.dataMArray = self.dataMArray;
    lvc.currentIndex = index;

    [self.navigationController pushViewController:lvc animated:NO];
    
//    lvc.view.alpha = 0;
//    
//    [UIView animateWithDuration:KLongDuration animations:^{
//        lvc.view.alpha = 1;
//    }];
//    [self.view addSubview:lvc.view];
//    [self addChildViewController:lvc];                                                                                                                                                                                                               
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    NSDictionary *dict = [self.dataMArray objectAtIndex:indexPath.row];
    cell.dict = dict;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(316, 256);
}


- (void)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self openProductDetail:indexPath];
    
}



@end
