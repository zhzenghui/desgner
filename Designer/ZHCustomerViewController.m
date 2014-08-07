//
//  ZHCustomerViewController.m
//  Designer
//
//  Created by bejoy on 14/6/26.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHCustomerViewController.h"
#import "Customer.h"
#import "ZHNoteViewController.h"
#import "CustomerCell.h"
#import "UIView+Utilities.h"
#import "ZHNoteViewController.h"
#import "ZHEditCustomerViewController.h"

#define KRECTcustomerTrashButton RectMake2x(1848, 256, 109, 86)
#define KRECTcustomerButton RectMake2x(1848, 138, 109, 86)
#define KRECTnewCustomerButton RectMake2x(1858, 916, 150, 150)
#define KRECTseachCustomerButton RectMake2x(1858, 1106, 150, 150)
#define KRECTtrashButton RectMake2x(1858, 1296, 150, 150)


#define KRECTHhiddencustomerTrashButton RectMake2x(1648, 256, 109, 86)
#define KRECThiddencustomerButton RectMake2x(1648, 138, 109, 86)
#define KRECThiddennewCustomerButton RectMake2x(2048, 916, 150, 150)
#define KRECThiddenseachCustomerButton RectMake2x(2048, 1106, 150, 150)
#define KRECThiddentrashButton RectMake2x(2048, 1296, 150, 150)



#define KRECTFaDaJingInitImageView RectMake2x(120, -799, 1800, 799)
#define KRECTFaDaJingPositionImageView RectMake2x(120, 167, 1800, 799)

@interface ZHCustomerViewController ()
{
    
}

@end

@implementation ZHCustomerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}


#pragma mark - data

- (void)dataForPageNum
{

    if (self.dataMArray) {
        self.dataMArray = nil;
    }
    
    
    self.dataMArray = [[NSMutableArray alloc] init];

    
    int index = currentPage* KPageSize;
    int countNum = index +KPageSize;
    
    if (allDataMArray.count < countNum  ) {
        countNum = (countNum-KPageSize) + allDataMArray.count%KPageSize;
    }
    
    if (allDataMArray.count%KPageSize != 0) {
        currentPageCount = allDataMArray.count/KPageSize + 1;
    }
    else
        currentPageCount = allDataMArray.count/KPageSize;

    
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    [allDataMArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if ( idx >= index && idx <index+countNum ) {
            [arry addObject:obj];
        }
    }];
    
    
    self.dataMArray = [arry copy];
    [_collectionView reloadData];

}

- (void)space {
    
    if (self.dataMArray.count == 0) {
        
        space.alpha = 1;

        
    }
    else {
        
        space.alpha = 0;
    }
    
}

- (void)seachAllCustomer {
    
    
    if (seachTF.text.length == 0) {
        
        [self fetchAllCustomer];
        
        return;
        
    }
    
    
    if (allDataMArray) {
        allDataMArray = nil;
    }
    
    allDataMArray  = [[NSMutableArray alloc] init];
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"name CONTAINS[cd] %@  AND status = 1",   seachTF.text ];
    [allDataMArray addObjectsFromArray: [Customer findAllWithPredicate:predicate]];

    
    NSPredicate* predicate1 = [NSPredicate predicateWithFormat: @"mobile CONTAINS[cd] %@  AND status = 1",   seachTF.text ];
    [allDataMArray addObjectsFromArray: [Customer findAllWithPredicate:predicate1]];

    
    NSPredicate* predicate2 = [NSPredicate predicateWithFormat: @"adress CONTAINS[cd] %@  AND status = 1",   seachTF.text ];
    [allDataMArray addObjectsFromArray: [Customer findAllWithPredicate:predicate2]];
    
    
    NSPredicate* predicate3 = [NSPredicate predicateWithFormat: @"telephone CONTAINS[cd] %@  AND status = 1",   seachTF.text ];
    [allDataMArray addObjectsFromArray: [Customer findAllWithPredicate:predicate3]];
    
    [self removeDuplicate];
    
    
    
    [self pageNums];
    [self dataForPageNum];
    
    [self space];
}


- (void)removeDuplicate {
    
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:allDataMArray];
    allDataMArray = [NSMutableArray arrayWithArray:orderedSet.array];
    
//    NSArray *copy = [mutableArray copy];
//    NSInteger index = [copy count] - 1;
//    for (id object in [copy reverseObjectEnumerator]) {
//        if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
//            [mutableArray removeObjectAtIndex:index];
//        }
//        index--;
//    }

}


- (void)fetchAllCustomer {
 
    

    NSNumber *currentStatusValue = @(0);
    
    if ( currentCollectionType == CollectionTypeNormal ) {
        currentStatusValue = @(1);
    }
    else if ( currentCollectionType == CollectionTypeDelate  ) {
        currentStatusValue = @(0);
    }

    if (allDataMArray) {
        allDataMArray = nil;
    }
    
    
    
    allDataMArray = [[NSMutableArray alloc] initWithArray: [Customer findByAttribute:@"status"
                                                                           withValue:currentStatusValue
                                                                          andOrderBy:@"update_time" ascending:NO]];
    
    [self pageNums];

    [self dataForPageNum];

    [self space];

}


- (void)newCustomer
{
    Customer *customer = [Customer createEntity];
    customer.name = @"name";
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
}


#pragma mark - action

- (void)pageNums
{
    
    if (allDataMArray.count < 6) {
        pageAllSize =  1;
    }
    else {
        int i = 0;
        if (allDataMArray.count%KPageSize != 0) {
            i =  1;
        }
        pageAllSize = (allDataMArray.count/KPageSize)+i;
    }
    self.pageNumLabel.text = [NSString stringWithFormat:@"%ld/%d", (long)currentPage+1, pageAllSize];

}


-(IBAction)curlDown:(id)sender
{

    
    if (  isopen &&  currentPage != 0) {
        currentPage --;
        NSLog(@"%d", currentPage);
        
        
        [self dataForPageNum];
        
        self.pageNumLabel.text = [NSString stringWithFormat:@"%ld/%d", (long)currentPage+1, pageAllSize];

        
#ifdef AppStore
        
        
        
        [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlDown animations:^{
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:KLongDuration animations:^{
            }];
            
        }];
#else
        
        
        [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlRight];
        
        
#endif


        
    }

}


-(IBAction)curlUp:(id)sender
{
    
    @try {
        

        if (isopen  ) {
            
            
            if (pageAllSize != currentPage+1) {
                
                NSLog(@"%d", currentPage);

                currentPage ++;
                self.pageNumLabel.text = [NSString stringWithFormat:@"%ld/%d", (long)currentPage+1, pageAllSize];

                [self dataForPageNum];
                

                
#ifdef AppStore
                
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{

    } completion:^(BOOL finished) {
        
    }];
#else
                
                
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlLeft];

                
#endif
                
                

            }
            
        }
        else {

            isopen = YES;

            [self pageCurlAnimation: self.converImageView.layer ];
     
            


            
    //        [UIView transitionWithView:self.converImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
    //            self.contentView.frame = CGRectMake(-30, 0, 1024, 768);
    //
    //            self.converImageView.image = nil;
    //            
    //        } completion:^(BOOL finished) {
    //
    //            
    //            if (finished) {
    //                self.contentMenuView.alpha = 1;
    //                self.pageAnimotionImageView.alpha = 1;
    //                self.contentView.frame = CGRectMake(0, 0, 1024, 768);
    //                self.bgImageView.frame = RectMake2x(0, 39, 1929, 1459);
    //                self.pageNumLabel.alpha = 1;
    //                _collectionView.alpha = 1;
    //                [self noteOpenAnimation];
    //            }
    //        }];
        }
    
    }
    @catch (NSException *exception) {
        NSLog(@"%@----%@", exception.name, exception.reason)    ;
    }
    @finally {
        
    }

}


- (void)pageCurlAnimation:(CALayer *)splashLayer
{

    splashLayer.anchorPoint = CGPointMake(-0.0, 0.5);
    splashLayer.position = CGPointMake(30+splashLayer.bounds.size.width*splashLayer.anchorPoint.x, splashLayer.bounds.size.height*splashLayer.anchorPoint.y+16);
    
    CATransform3D transform = CATransform3DIdentity;
    float zDistanse = 1200.0;
    transform.m34 = 1.0 / -zDistanse;
    
    CATransform3D transform1 = CATransform3DRotate(transform, -M_PI_2/10, 0, 1, 0);
    CATransform3D transform2 = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    
    CAKeyframeAnimation* keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyframeAnimation.duration = 2;
    keyframeAnimation.delegate = self;
    keyframeAnimation.values = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:transform],
                                [NSValue valueWithCATransform3D:transform2],
                                nil];
    keyframeAnimation.keyTimes = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0],
                                  [NSNumber numberWithFloat:1.0],
                                  nil];
    keyframeAnimation.timingFunctions = [NSArray arrayWithObjects:
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                         nil];
    [UIView animateWithDuration:2 animations:^{
        self.converImageView.layer.frame = CGRectMake(0, 16, 974, 735);

        self.contentView.layer.frame = CGRectMake(-30, 0, 1024, 768);
    }];


    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    [splashLayer addAnimation:keyframeAnimation forKey:nil];

}

- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag
{

    [UIView animateWithDuration:KLongDuration animations:^{
            self.contentView.frame = CGRectMake(-30, 0, 1024, 768);

    } completion:^(BOOL finished) {
        if (finished) {
            self.converImageView.alpha = 0;
            self.contentMenuView.alpha = 1;
            self.pageAnimotionImageView.alpha = 1;
            self.contentView.frame = CGRectMake(0, 0, 1024, 768);
            self.bgImageView.frame = RectMake2x(0, 39, 1929, 1459);
            self.pageNumLabel.alpha = 1;
            _collectionView.alpha = 1;
            [self noteOpenAnimation];
        }
    }];
}

int  perspectiveDepth = 200;






- (void)customerTableType:(UIButton *)button
{
    
    
    UIButton *button1 = (UIButton *)[self.view viewWithTag:1000];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:1001];

    button1.selected = NO;
    button2.selected = NO;
    
    
    
    button.selected = YES;

    if (button.tag == 1000) {
        currentCollectionType = CollectionTypeNormal;
        
        self.dataMArray = [[NSMutableArray alloc] initWithArray: [Customer findByAttribute:@"status"
                                                                                 withValue:[NSNumber numberWithInteger:1]
                                                                                andOrderBy:@"update_time" ascending:NO]];
    }
    else if (button.tag == 1001)
    {
        currentCollectionType = CollectionTypeDelate;
        
        self.dataMArray = [[NSMutableArray alloc] initWithArray: [Customer findByAttribute:@"status"
                                                                                 withValue:[NSNumber numberWithInteger:0]
                                                                                andOrderBy:@"update_time" ascending:NO]];
    }

    [self fetchAllCustomer];
}

- (void)openCustomerForType:(UIButton *)button
{
    
    currentPage = 0;
 
    switch (button.tag) {
        case 1000:
        {
            [self customerTableType:button];
            break;
        }
        case 1001:
        {
            [self customerTableType:button];
            break;
        }
        default:
            break;
    }
}

- (void)openSeachViewAnimation {
    
    [UIView animateWithDuration:KLongDuration animations:^{
        fangdajingIV.frame = KRECTFaDaJingPositionImageView;
        seachView.alpha = 1;
        seachTF.alpha = 1;
        
    } completion:^(BOOL finished) {
        [seachTF becomeFirstResponder];
    }];
}

- (void)closeSeachViewAnimation {
    
    [UIView animateWithDuration:KLongDuration animations:^{
        fangdajingIV.frame = KRECTFaDaJingInitImageView;
        seachView.alpha = 0;
        seachTF.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}



- (void)customerControl:(UIButton *)button
{
    switch (button.tag) {
        case 2000:
        {
            [self noteCloseAnimation];
            [self openCustomer:nil];
            break;
        }
        case 2001:
        {

            [self openSeachViewAnimation];
            break;
        }
        case 2002:
        {
            
            if (currentCollectionTableType == CollectionTableTypeNormal) {
                currentCollectionTableType = CollectionTableTypeDelete;
                trashButton.selected = YES;
            }
            else
            {
                currentCollectionTableType = CollectionTableTypeNormal;
                trashButton.selected = NO;
            }
            
            
            
            [self fetchAllCustomer];

            break;
        }
        default:
            break;
    }
}

#pragma mark animation

- (void)noteOpenAnimation
{
    customerTrashButton.alpha = 1;
    customerButton.alpha = 1;
    newCustomerButton.alpha = 1;
    seachCustomerButton.alpha = 1;
    trashButton.alpha = 1;

    
    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.4  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{

        customerButton.frame = KRECTcustomerButton;
        customerTrashButton.frame = KRECTcustomerTrashButton;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.5  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        newCustomerButton.frame = KRECTnewCustomerButton;
        seachCustomerButton.frame = KRECTseachCustomerButton;
        trashButton.frame = KRECTtrashButton;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    

    [self fetchAllCustomer];
    
}

- (void)noteCloseAnimation
{
    

    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.8  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        customerButton.frame = KRECThiddencustomerButton;
        customerTrashButton.frame = KRECTHhiddencustomerTrashButton;
        
        newCustomerButton.frame = KRECThiddennewCustomerButton;
        seachCustomerButton.frame = KRECThiddenseachCustomerButton;
        trashButton.frame = KRECThiddentrashButton;
        
    } completion:^(BOOL finished) {
        
    }]; 
}

#pragma mark - view

- (void)loadView
{
    [super loadView];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:RectMake2x(80, 100, 1708, 1116) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alpha = 0;
    _collectionView.scrollEnabled = NO;
    
    UINib *nib = [UINib nibWithNibName:@"CustomerCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"CustomerCell"];

    
    [self.pageAnimotionImageView addSubview:_collectionView];
    
    [[Button share] addToView:self.pageAnimotionImageView addTarget:self rect:RectMake2x(78, 1337-47*2, 80, 80) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-00"];
    
    

    space = [[ImageView share] addToView:self.pageAnimotionImageView imagePathName:@"笔记-bg-logo"
                            rect:CGRectMake(0, 0,
                                            self.pageAnimotionImageView.frame.size.width,
                                            self.pageAnimotionImageView.frame.size.height)];

    space.alpha = 0;
    self.pageAnimotionImageView.userInteractionEnabled= YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allDataMArray = [[NSMutableArray alloc] init];
    self.converImageView.alpha = 1;
    currentPage = 0;
    currentCollectionTableType = CollectionTableTypeNormal;
    currentCollectionType = CollectionTypeNormal;
    
    isopen = NO;
    
    self.pageAnimotionImageView.alpha = 0;
    self.contentMenuView.alpha = 0;



    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteOpenAnimation) name:@"noteOpenAnimation" object:nil];
    
    
    
    customerButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1848, 138, 109, 86) tag:1000
                                        action:@selector(openCustomerForType:)
                                     imagePath:@"标签-客户列表-00"
                      highlightedImagePath:@"标签-客户列表-01"
                      SelectedImagePath:@"标签-客户列表-01"
                      ];
    customerButton.selected = YES;
    
    customerTrashButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1848, 256, 109, 86) tag:1001
                                        action:@selector(openCustomerForType:)
                                          imagePath:@"标签-删除列表-00"
                               highlightedImagePath:@"标签-删除列表-01"
                                  SelectedImagePath:@"标签-删除列表-01"
                           ];

    
    
    newCustomerButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 916, 150, 150) tag:2000
                                             action:@selector(customerControl:)
                                        imagePath:@"按钮-新建-00"
                             highlightedImagePath:@"按钮-新建-01"
                                SelectedImagePath:@"按钮-新建-01"
                         ];
    
    seachCustomerButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 1106, 150, 150) tag:2001
                                             action:@selector(customerControl:)
                                          imagePath:@"笔记-按钮-搜索-00"
                               highlightedImagePath:@"笔记-按钮-搜索-01"
                                  SelectedImagePath:@"笔记-按钮-搜索-01"
                           ];
    
    trashButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 1296, 150, 150) tag:2002
                                             action:@selector(customerControl:)
                                  imagePath:@"按钮-删除-00"
                       highlightedImagePath:@"按钮-删除-01"
                          SelectedImagePath:@"按钮-删除-01"
                   ];
    
    customerTrashButton.alpha = 0;
    customerButton.alpha = 0;
    newCustomerButton.alpha = 0;
    seachCustomerButton.alpha = 0;
    trashButton.alpha = 0;
    
    customerButton.frame = KRECThiddencustomerButton;
    customerTrashButton.frame = KRECTHhiddencustomerTrashButton;
    newCustomerButton.frame = KRECThiddennewCustomerButton;
    seachCustomerButton.frame = KRECThiddenseachCustomerButton;
    trashButton.frame = KRECThiddentrashButton;
    
    
    

    
    [self.view bringSubviewToFront:self.pageAnimotionImageView];
    [self.view bringSubviewToFront:self.pageNumLabel];
    [self.view bringSubviewToFront:_collectionView];
    
    self.pageNumLabel.alpha = 0;
    _collectionView.alpha = 0;
    
    [self fetchAllCustomer];
    [self pageNums];
    
    seachView = [[UIView alloc] initWithFrame:self.view.frame];
    seachView.alpha = 0;
    [seachView alphablackView];
    
    fangdajingIV = [[ImageView share] addToView:seachView imagePathName:@"搜索-放大镜" rect:KRECTFaDaJingInitImageView];
    seachTF = [[UITextField alloc] initWithFrame:RectMake2x(1039+120, 368+167, 395, 51)];
    seachTF.backgroundColor = [UIColor clearColor];
    seachTF.returnKeyType = UIReturnKeySearch;
    seachTF.delegate = self;
    [seachView addSubview:seachTF];
    
    [self.view addSubview:seachView];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                      selector:@selector(keyboardDidHide)
                          name:UIKeyboardDidHideNotification
                        object:nil];

    
    
    
 

    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"noteOpenAnimation" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)openNoteViewController :(UIButton *)button
{

    
    ZHNoteViewController *pdfVC = [[ZHNoteViewController alloc] initWithNibName:@"ZHNoteViewController" bundle:nil];
    pdfVC.view.alpha  = 0 ;

    [self.view addSubview:pdfVC.view];
    [self addChildViewController:pdfVC];
    

    
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlDown animations:^{
       pdfVC.view.alpha  = 1 ;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:KLongDuration animations:^{
        }];
        
    }];


}




#pragma mark - action


- (void)back:(UIButton *)button
{
    
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
    
    
    
}

-(IBAction)deleteCustomer:(id)sender
{

    UICollectionViewCell *cell = (UICollectionViewCell *)[[sender superview] superview];
    
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    
    
    
    Customer *c =   self.dataMArray[indexPath.row];
    if ([c.status isEqualToNumber:@(0)]) {
        [c deleteEntity];
    }
    
    c.status = @(0);
    



    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
    
    [self fetchAllCustomer];
    
    

}

- (IBAction)openCustomer:(id)sender
{
    
    
    ZHEditCustomerViewController *bv;
    
    bv = [[ZHEditCustomerViewController alloc] initWithNibName:@"ZHEditCustomerViewController" bundle:nil];
    bv.view.alpha  = 0 ;

    [self.view addSubview:bv.view];
    [self addChildViewController:bv];
    

    
    
#ifdef AppStore
    
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
        bv.view.alpha  = 1 ;
    } completion:^(BOOL finished) {


    }];
#else

    
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlLeft];
    
    
    [UIView animateWithDuration:KLongDuration animations:^{
        bv.view.alpha  = 1 ;
    }];
#endif
    

}

- (void)openProductDetail:(NSIndexPath *)indexPath
{
    
    
    
    int index = indexPath.row;
    
    
    ZHNoteViewController *bv;
    
    bv = [[ZHNoteViewController alloc] initWithNibName:@"ZHNoteViewController" bundle:nil];
    bv.dataMDict = [self.dataMArray objectAtIndex:index];
    bv.view.alpha = 0;
    bv.customer = self.dataMArray[index];
    
    [self.view addSubview:bv.view];
    [self addChildViewController:bv];
    
    

    
#ifdef AppStore
    
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
        bv.view.alpha  = 1 ;
    } completion:^(BOOL finished) {

    }];
#else
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlLeft];
    
    [UIView animateWithDuration:KLongDuration animations:^{
        bv.view.alpha  = 1 ;
    }];
#endif
    

    
    
    
    
    
}
#pragma mark - UICollectionViewDelegate


-(BOOL) collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (currentPageCount == currentPage+2 && currentPage != 0) {
        return NO;
    }
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CustomerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomerCell" forIndexPath:indexPath];
    
    
    Customer *c = [self.dataMArray objectAtIndex:indexPath.row];
    cell.customer = c;
    [cell setType:currentCollectionTableType];

    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(550/2, 600/2);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Customer *c =   self.dataMArray[indexPath.row];
    
    if ( [c.status isEqualToNumber:@(0)] ) {

//        c.status = @(1);
        currentCustomerIndexPath = indexPath;
        [[Message share] messageAlert:@"您是否要恢复该客户信息。" delegate:self];
    }
    else {
        [self openProductDetail:indexPath];
    }

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    else {
        Customer *c =   self.dataMArray[currentCustomerIndexPath.row];
        c.status = @(1);
        
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:nil];
        
        [self fetchAllCustomer];
    }
}


#pragma mark - textField

-(void) keyboardDidHide {

    [self closeSeachViewAnimation];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self closeSeachViewAnimation];
    
    [self seachAllCustomer];
    
    
    return YES;
}

@end
