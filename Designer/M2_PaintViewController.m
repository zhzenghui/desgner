//
//  M2_PaintViewController.m
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_PaintViewController.h"
#import "M2_PaintCell.h"


@interface M2_PaintViewController ()
{
    UIScrollView *sv;
}
@end

@implementation M2_PaintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)closeView
{
    [UIView animateWithDuration:KLongDuration animations:^{
        grougPhotoView.alpha = 0;
    }];
}

- (void)loadPaintData
{    
    paintArray = [[ZHDBData share] getPhotoForD_Id:kD_Id];
    
    [_collectionView reloadData];
    
    int i = 0;
    for (NSDictionary *dict in paintArray) {
        
        NSString *imgStr =[NSString stringWithFormat:@"%@", dict[@"store_name"]];
        NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
        NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0+ i *1024, 0, 1024, 768)];
        imgView.image = img;
        imgView.contentMode = UIViewContentModeScaleAspectFit;

        [sv addSubview:imgView];
 
        i ++;
    }

    [sv setContentSize:CGSizeMake(1024*paintArray.count, 768)];
}


- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"双子-郭正艺绘-bg"]];


    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    
    _collectionView =[[UICollectionView alloc] initWithFrame:RectMake2x(35, 351, 1979, 1091) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[M2_PaintCell class]  forCellWithReuseIdentifier:@"M2_PaintCell"];
    
    [self.view addSubview:_collectionView];
    
    


    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButtion];


    grougPhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    grougPhotoView.alpha = 0;
    [self.view addSubview:grougPhotoView];

    
//    grougPhotoImageView = [[ImageView share] addToView:grougPhotoView imagePathName:@"" rect:RectMake2x(40, 80,  1968, 1416)];
//    grougPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
//    grougPhotoImageView.backgroundColor = [UIColor whiteColor];
    
    sv = [[UIScrollView alloc] initWithFrame:grougPhotoView.frame];
    sv.pagingEnabled = YES;
    sv.backgroundColor = [UIColor whiteColor];
    [grougPhotoView addSubview:sv];
    
    
    [[Button share] addToView:grougPhotoView addTarget:self rect:RectMake2x(1888, 120 , 100, 100) tag:1001 action:@selector(closeView) imagePath:@"按钮-返回-rigth-top"];

    
    [self loadPaintData];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return paintArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    M2_PaintCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"M2_PaintCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [paintArray objectAtIndex:indexPath.row];
    cell.dict = dict;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(661/2, 351/2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
//    NSDictionary *dict = paintArray[indexPath.row];
//    
//    NSString *imgStr =[NSString stringWithFormat:@"%@", dict[@"store_name"]];
//    NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
//    NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];
//    UIImage *img = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
//    
//    grougPhotoImageView.image = img;
    
//    [UIView animateWithDuration:KLongDuration animations:^{
//        sv .alpha = 1;
//    }];
    
    
    [self openSVAtIndexPath:indexPath];
    
    
}

#pragma mark -  action 

- (void)openSVAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [UIView animateWithDuration:KLongDuration animations:^{
        grougPhotoView.alpha = 1;
    }];
    
    
    [sv scrollRectToVisible:CGRectMake(indexPath.row * 1024, 0, 1024, 768) animated:NO];
    
}

- (void)colseSV
{
    
    [UIView animateWithDuration:KLongDuration animations:^{
        grougPhotoView.alpha = 0;
    }];
    
    
}



@end
