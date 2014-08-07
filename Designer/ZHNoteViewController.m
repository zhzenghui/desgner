//
//  ZHNoteViewController.m
//  Designer
//
//  Created by bejoy on 14/6/26.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHNoteViewController.h"
#import "ZHEditNoteViewController.h"
#import "NSDate+Helper.h"
#import "Photo.h"
#import "Customer.h"
#import "ZHEditCustomerViewController.h"
#import "UIView+Utilities.h"


@interface ZHNoteViewController ()
{
    
    UIImageView *penImageView;
    UIImageView *contentImageView;
    
}
@end



#define KRECTpenImageView RectMake2x(1716, 228, 308, 1094 )
#define KRECThiddenpenImageView RectMake2x(2048, 228, 308, 1094 )

@implementation ZHNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)closeAnimation
{

    
#ifdef AppStore
    
    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.8  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        penImageView.frame = KRECThiddenpenImageView;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            //            noteOpenAnimation
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteOpenAnimation" object:nil];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];

#else
    [UIView transitionWithView:self.pageAnimotionImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlRight];
    
    [UIView animateWithDuration:.9 animations:^{
        penImageView.frame = KRECThiddenpenImageView;
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"noteOpenAnimation" object:nil];
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
#endif
    
    
}

- (void)loadAnimation
{
    [UIView animateWithDuration:.9 delay:0 usingSpringWithDamping:.8  initialSpringVelocity:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        
        penImageView.frame = KRECTpenImageView;

    } completion:^(BOOL finished) {
        
        
        
    }];
}

- (void)openMSC:(UIButton *)button
{
    

    [self closeAnimation];

}

- (void)openCustomer:(UIButton *)button
{

    
    ZHEditCustomerViewController *bv;
    
    bv = [[ZHEditCustomerViewController alloc] initWithNibName:@"ZHEditCustomerViewController" bundle:nil];
    bv.customer = self.customer;
    bv.view.alpha = 0;
    
    [self.view addSubview:bv.view];
    [self addChildViewController:bv];
    
    
#ifdef AppStore
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
        bv.view.alpha  = 1 ;
    } completion:^(BOOL finished) {
        
        
    }];
#else
    
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlLeft];
    
    
    [UIView animateWithDuration:KLongDuration animations:^{
        bv.view.alpha  = 1 ;
    }];
#endif
    
    
}

- (void)saveCustomer:(UIButton *)button
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}


- (void)customerControl:(UIButton *)button
{
    switch (button.tag) {
        case 2000:
        {
            
            [self openEdit:nil];

            break;
        }
        case 2001:
        {
            
            if (_type == 1) {
                self.type = 0;
                button.selected = YES;
            }
            else {
                _type = 1;
                button.selected = NO;
            }
            [tb reloadData];

            break;
        }

        default:
            break;
    }
    
    
    
}
- (void)fetchAll {
	// Determine if sort key is
    //	NSString *sortKey = [[NSUserDefaults standardUserDefaults] objectForKey:WB_SORT_KEY];
    //	BOOL ascending = [sortKey isEqualToString:SORT_KEY_RATING] ? NO : YES;
	// Fetch entities with MagicalRecord
    //	self.dataMArray = [[Beer findAllSortedBy:sortKey ascending:ascending] mutableCopy];
    

    self.dataMArray = [[NSMutableArray alloc] initWithArray: [Note findByAttribute:@"cstm_id"
                                                                             withValue:self.customer.customer_id
                                                                            andOrderBy:@"update_time" ascending:NO]];
    [tb reloadData];
}

- (void)refresh {
    
    
    customerLable.text = self.customer.name;
    
    
}

- (void)space {
    
    if (self.dataMArray.count == 0) {
        
        space.alpha = 1;
        tb.alpha = 0;
        
    }
    else {
        
        space.alpha = 0;
        tb.alpha =1;
    }
    
}


- (void)noteRefreshNotes
{
    [self refresh];
    [self fetchAll];
    
    [self space];
}

#pragma mark - view

-(void)loadView
{
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.type = 1;
    
    newCustomerButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 1106, 150, 150) tag:2000
                                           action:@selector(customerControl:)
                                        imagePath:@"按钮-新建-00"
                             highlightedImagePath:@"按钮-新建-01"
                                SelectedImagePath:@"按钮-新建-01"
                         ];

    
    trashButton = [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1858, 1296, 150, 150) tag:2001
                                     action:@selector(customerControl:)
                                  imagePath:@"按钮-删除-00"
                       highlightedImagePath:@"按钮-删除-01"
                          SelectedImagePath:@"按钮-删除-01"
                   ];
    

    
    
    contentImageView =  [[ImageView share] addToView:self.view imagePathName:@"笔记-新建客户-页" rect:CGRectMake(0, 47, 927, 675)];
    contentImageView.userInteractionEnabled = YES;
    
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-新建客户-蓝色" rect:RectMake2x(22, 9, 395, 80)];
    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(272, 9, 80, 80) tag:1000 action:@selector(openCustomer:) imagePath:@"按钮-基本信息-00"];
    [[ImageView share] addToView:contentImageView imagePathName:@"笔记-信息列表-线框" rect:RectMake2x(80 , 147, 1708,1116)];

//    [[Button share] addToView:contentImageView addTarget:self rect:RectMake2x(78, 1337-47*2, 80, 80) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-00"];

    
    customerLable = [[UILabel alloc] init];
//    customerLable.frame = RectMake2x(22, 9, 365, 80);
//    customerLable.textAlignment = NSTextAlignmentCenter;
    customerLable.font = [UIFont boldSystemFontOfSize:18];
    customerLable.frame = RectMake2x(72, 9, 365, 80);
    
    
    [contentImageView addSubview:customerLable];
    
    tb = [[UITableView alloc] initWithFrame:RectMake2x(82 , 149, 1708, 1116) style:UITableViewStylePlain];
    tb.backgroundColor = [UIColor clearColor];
    tb.alpha = 0;
    tb.dataSource = self;
    tb.delegate = self;
    
    [contentImageView addSubview:tb];

    
    
    space = [[ImageView share] addToView:contentImageView imagePathName:@"笔记-bg-logo"
                                    rect:CGRectMake(0, 0,
                                                    contentImageView.frame.size.width,
                                                    contentImageView.frame.size.height)];
    
    space.alpha = 0;
    
    
    
    UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAnimation)];
    [gr setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft )];
    [[self view] addGestureRecognizer:gr];
}

- (void)backAnimation
{
    

    
    
    
#ifdef AppStore
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.view.alpha  = 0 ;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
    
#else
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlRight];

    [UIView animateWithDuration:KLongDuration animations:^{

        self.view.alpha  = 0 ;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }
    }];
#endif
    

    
    
    
//    [self back:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self noteRefreshNotes];

    [self loadAnimation];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteRefreshNotes) name:@"noteRefreshNotes" object:nil];

    customerLable.text = self.customer.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - cell


- (UITableViewCell *)cellText
{
    return nil;

}

- (UITableViewCell *)cellImageText
{
    
    
    return nil;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

- (int)seachPhotoCount:(NSNumber *)note_id
{
  
    int count =[Photo findByAttribute:@"note_id" withValue:note_id andOrderBy:@"update_time" ascending:YES].count;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    Note *n = self.dataMArray[indexPath.row];
    int i = [self seachPhotoCount:n.note_id];
    
    if (i == 0) {
        
        return 120;
    }
    else {
        return 220;
    }
}





- (UITableViewCell *)cell3Height
{
    
    static NSString *CellIdentifier = @"Cell3h";
    
    UITableViewCell *cell = [tb dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    [[ImageView share] addToView:cell.contentView imagePathName:@"日历框" rect:RectMake2x(40, 50, 115, 145)];
    

    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1605, 194, 80, 80) tag:4001 action:@selector(deleteItem:) imagePath:@"按钮-进入-00"];

    
//    ri
    UILabel *l = [[UILabel alloc] init];
    l.textAlignment = NSTextAlignmentCenter;
    l.frame = RectMake2x( 50, 59,107, 86);
    l.font = [UIFont systemFontOfSize:35];
    
    l.tag = 2001;
    
    [cell.contentView addSubview:l];
//   yue
    UILabel *lri = [[UILabel alloc] init];
    lri.textAlignment = NSTextAlignmentCenter;
    lri.frame = RectMake2x( 50, 133, 109, 64);
    lri.font = [UIFont systemFontOfSize:18];
    lri.tag = 2002;
    
    [cell.contentView addSubview:lri];
    
    
//    内容
    UILabel *lcontent = [[UILabel alloc] init];
    lcontent.backgroundColor = [UIColor clearColor];
    lcontent.frame = RectMake2x( 237, 47, 1344, 93);
    lcontent.font = [UIFont systemFontOfSize:18];

    lcontent.numberOfLines = 0;
    lcontent.tag = 2003;
    
    [cell.contentView addSubview:lcontent];
    
//    [ImageView share] addToView:cell.contentView addTarget:self rect:RectMake2x(238, 183, 314, 234) tag:3000
    UIImageView *imgV1 = [[ImageView share] addToView:cell.contentView imagePathName:@"" rect:RectMake2x(238, 183, 314, 234)];
    UIImageView *imgV2 = [[ImageView share] addToView:cell.contentView imagePathName:@"" rect:RectMake2x(238+ 344, 183, 314, 234)];
    UIImageView *imgV3 = [[ImageView share] addToView:cell.contentView imagePathName:@"" rect:RectMake2x(238 + 344*2, 183, 314, 234)];
    UIImageView *imgV4 = [[ImageView share] addToView:cell.contentView imagePathName:@"" rect:RectMake2x(238 + 344*3, 183, 314, 234)];

    imgV1.tag = 3001;
    imgV2.tag = 3002;
    imgV3.tag = 3003;
    imgV4.tag = 3004;
    
    
    
    return cell;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    static NSString *CellIdentifier = @"Cell3h";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [self cell3Height];
    }
    
    UILabel *riLable = (UILabel *)[cell.contentView viewWithTag:2001];
    UILabel *yueLable = (UILabel *)[cell.contentView viewWithTag:2002];
    UILabel *contentLable = (UILabel *)[cell.contentView viewWithTag:2003];
    
    
    UIImageView *imgV1 = (UIImageView *)[cell.contentView viewWithTag:3001];
    UIImageView *imgV2 = (UIImageView *)[cell.contentView viewWithTag:3002];
    UIImageView *imgV3 = (UIImageView *)[cell.contentView viewWithTag:3003];
    UIImageView *imgV4 = (UIImageView *)[cell.contentView viewWithTag:3004];
    
    imgV1.image = nil;
    imgV2.image = nil;
    imgV3.image = nil;
    imgV4.image = nil;
    
    UIButton *button = (UIButton *)[cell.contentView viewWithTag:4001];
    
    if (_type == 1) {
        [button setImage:[UIImage imageNamed:@"按钮-进入-00"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else {
        [button setImage:[UIImage imageNamed:@"按钮-消除-00"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled = YES;
    }
    
    Note *note =  self.dataMArray[indexPath.row];


    NSString *riStr = [note.update_time  stringWithFormat:@"d"];
    NSString *yueStr = [NSString stringWithFormat:@"%@月", [note.update_time  stringWithFormat:@"M"]];
    riLable.text = riStr;
    yueLable.text = yueStr;
    
    contentLable.text = note.content;

    NSArray *photos = [Photo findByAttribute:@"note_id" withValue:note.note_id  andOrderBy:@"update_time" ascending:NO];

    if (photos.count == 0) {
        button.frame = RectMake2x(1605, 104, 80, 80);
    }
    else {
        button.frame = RectMake2x(1605, 194, 80, 80);
    }
    int i = 0;
    for (Photo *p in photos) {
        

        i ++;
        if (i == 5) {
            break;
        }
        UIImageView *imgV = (UIImageView *)[cell.contentView viewWithTag:3000+i];
        
        
        NSString *path = [NSString stringWithFormat:@"%@", KDocumentName(p.stroe_name)];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        
        imgV.image = image;
    }
    
    return cell;
    
    
}

#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Note *n = self.dataMArray [indexPath.row];
    [self openEdit:n];
}


- (void)openEdit:(Note *)note
{
    ZHEditNoteViewController *edit = [[ZHEditNoteViewController alloc] init];
    edit.note = note;
    edit.view.alpha  = 0 ;
    edit.customer = self.customer;
    [self.view addSubview:edit.view];
    [self addChildViewController:edit];
    
    
//    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        edit.view.alpha  = 1 ;
//    } completion:^(BOOL finished) {
//    }];
#ifdef AppStore
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlUp animations:^{
        edit.view.alpha  = 1 ;
    } completion:^(BOOL finished) {
        
        
    }];
#else
    
    
    [UIView transitionWithView:contentImageView duration:KLongDuration options:UIViewAnimationOptionTransitionCurlLeft];
    
    
    [UIView animateWithDuration:KLongDuration animations:^{
        edit.view.alpha  = 1 ;
    }];
#endif
    
}


- (void)deleteItem:(UIButton *)button
{
    
    if (self.type != 1) {
        UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
        NSIndexPath *indexPath = [tb indexPathForCell:cell];
        
        
        Note *n = self.dataMArray [indexPath.row];
        
        [n deleteEntity];
        
        
        [self noteRefreshNotes];
    }
    

}



@end
