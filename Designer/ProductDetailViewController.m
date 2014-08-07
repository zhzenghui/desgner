//
//  ProductDetailViewController.m
//  OrientParkson
//
//  Created by i-Bejoy on 13-12-23.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ProductDetailViewController.h"



@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController


- (void)loadView
{
    [super loadView];
    
    productTableView  = [[UITableView alloc] initWithFrame:RectMakeC2x(430, -71, 1188, 1900)];
    productTableView.delegate = self;
    productTableView.dataSource = self;
    productTableView.showsHorizontalScrollIndicator = NO;
    productTableView.showsVerticalScrollIndicator   = NO;
    productTableView.transform =    CGAffineTransformMakeRotation(-M_PI/2),

    productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    productTableView.backgroundColor = [UIColor clearColor];
    productTableView.pagingEnabled = YES;
    [self.view addSubview:productTableView];

    
    [self addBackView];
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
	// Do any additional setup after loading the view.
    
    NSString *name =  [Cookie getCookie:KCurrentUser];
    NSDictionary *dict = [Cookie getCookie:name];
    
    if ([[dict objectForKey:@"area"] intValue] == 0) {
        isShowPrice = YES;
    }
    else {
        isShowPrice = NO;
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
//    currentIndex

    
    [productTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]
                            atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

- (void)backToView:(UIButton *)button
{
    UIView *v = [button superview];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        v.alpha = 0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
    
    
}

- (void)openFS:(int) index
{
    
    UIView *detailView = [[UIView alloc] initWithFrame:screen_BOUNDS_SIZE];
    
    UIView *backView = [[UIView alloc] initWithFrame:screen_BOUNDS_SIZE];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = .8;
    [detailView addSubview:backView];
    
    
    NSString *pid = [[self.dataMArray objectAtIndex:index] objectForKey:@"product_id"];
//    NSArray *pics = [[ZHDBData share] getPicsForProductId:pid];

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screen_BOUNDS_SIZE];
    scrollView.pagingEnabled = YES;
    
    
    
//    for (int i = 0; i< pics.count ; i ++) {
//        
//        NSDictionary *dict = [pics objectAtIndex:i];
//        NSString *picName = [dict objectForKey:@"name"];
//        
//        
//        UIImage *img = [[UIImage alloc] initWithContentsOfFile:KDocumentName(picName)];
//        UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
//        imgV.frame = CGRectMake(i*1024, 0, 1024, 768);
//        
//        
//        
//        [scrollView addSubview:imgV];
//        
//    }
//    
//    [scrollView setContentSize:CGSizeMake((pics.count*1024), 768) ];
//    [detailView addSubview:scrollView];
    
    
    detailView.alpha = 0;
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        detailView.alpha = 1;
    }];
    
    [self.view addSubview:detailView];
    
    [[Button share] addToView:detailView addTarget:self rect:RectMakeC2x(1869, 102, 110, 110) tag:Action_Back action:@selector(backToView:) imagePath:@"按钮-返回"];

    
}

- (void)openInfo:(int)index
{
    UIView *detailView = [[UIView alloc] initWithFrame:screen_BOUNDS_SIZE];
    UIView *backView = [[UIView alloc] initWithFrame:screen_BOUNDS_SIZE];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = .9;
    [detailView addSubview:backView];
    
    
    NSString *pid = [[self.dataMArray objectAtIndex:index] objectForKey:@"product_id"];
    
    
//    pDataMArray = [[ZHDBData share] getDetailForProductId:pid];
    
    
    
    

    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_detail_info_list_bg"]];
    imgV.frame = RectMake2x(74, 233, 1900, 1029);
    imgV.userInteractionEnabled = YES;
    [detailView addSubview:imgV];
    
    
    
    infoTb = [[UITableView alloc] initWithFrame:RectMake2x(5, 169, 1235, 754)];
    
    infoTb.delegate = self;
    infoTb.dataSource = self;
    infoTb.separatorStyle = UITableViewCellSeparatorStyleNone;

    [imgV addSubview:infoTb];
    
    [infoTb reloadData];
    
    
    
    
    UIImageView *imgV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_detail_tb_bg"]];
    imgV1.frame = RectMake2x(5, 167, 1894, 756);
    [imgV addSubview:imgV1];
    
    
    
    
    UITextView *nameLabel3 = [[UITextView alloc] initWithFrame:CGRectMake(629, 91, 309, 354)];
    nameLabel3.tag = 204;
    nameLabel3.backgroundColor = [UIColor clearColor];
    nameLabel3.font = [UIFont systemFontOfSize:15];
    nameLabel3.text = [[pDataMArray objectAtIndex:0] objectForKey:@"remark"];
    
    [imgV addSubview:nameLabel3];
    
    
    
    
    
    
    detailView.alpha = 0;
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        detailView.alpha = 1;
    }];
    [self.view addSubview:detailView];

    
    [[Button share] addToView:detailView addTarget:self rect:RectMakeC2x(1869, 252, 110, 110) tag:Action_Back action:@selector(backToView:) ];

    
}

- (void)openDetail:(UIButton *)button
{
    
    UITableViewCell *cell = (UITableViewCell *)[[[button superview]  superview] superview];
    NSIndexPath *indexPath = [productTableView indexPathForCell:cell];
    
    int index = indexPath.row  ;
    
    switch (button.tag ) {
        case 301:
        {
            [self openInfo:index];
            break;
        }
        case 302:
        {
            [self openFS:index];
            break;
        }
        default:
            break;
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == productTableView) {

        return self.dataMArray.count;
    }
    else {
        return pDataMArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == productTableView) {
        
        return 1900/2;
    }
    else {
        return 42;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier1 = @"Cell1";

    if (tableView == productTableView) {
        
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
            
            
            [[ImageView share] addToView:cell.contentView imagePathName:@"pro_detail_cell_bg" rect:RectMake2x(1584, 0, 316, 1188)];
            

            
    //        图片

            UIImageView *iv = [[UIImageView alloc] initWithFrame:RectMake2x(0, 0, 1584, 1188)];
            iv.tag = 1000;
            
            [cell.contentView addSubview:iv];
            
            
            
    //        功能按钮
            [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1632, 1046, 100, 100) tag:301 action:@selector(openDetail:) imagePath:@"pro_detail_cell_copy"];
            [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1762, 1046, 100, 100) tag:302 action:@selector(openDetail:) imagePath:@"pro_detail_cell_fullscreen"];
            
            
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:RectMake2x(1627, 922, 200, 109)];
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.font = [UIFont systemFontOfSize:40];
            
            nameLabel.tag = 201;
            
            [cell.contentView addSubview:nameLabel];
            
            
        }
        
        
        NSDictionary *dict = [self.dataMArray objectAtIndex:indexPath.row];
        NSString *pro_id = [dict objectForKey:@"product_id"];
//        NSArray *pics1 = [[ZHDBData share] getPicsForProductId:pro_id];

        
        UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:1000];
        
//        UIScrollView *sv = (UIScrollView *)[cell.contentView viewWithTag:1000];
//
//        int j = sv.frame.size.width;
//        for (int i= 0; i< pics1.count; i ++) {
//
    //        if (pics1.count != 0) {
    //            NSDictionary *dict = [pics1 objectAtIndex:0];
    //            NSString *imgName = [dict objectForKey:@"name"];
    //            
    //            UIImage *img = [[UIImage alloc] initWithContentsOfFile:KDocumentName(imgName)];
    //            iv.image = img;
    //        }
//            NSDictionary *dict = [pics1 objectAtIndex:0];
//            NSString *imgName = [dict objectForKey:@"name"];
//
//            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * j, sv.frame.origin.y, sv.frame.size.width, sv.frame.size.height)];
//        
//            UIImage *img = [[UIImage alloc] initWithContentsOfFile:KDocumentName(imgName)];
//            iv.image = img;
//        
//            [sv addSubview:iv];
//
//        }
//        sv.pagingEnabled = YES;
//        [sv setContentSize:CGSizeMake((pics1.count*j), sv.frame.size.height) ];
        
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:201];
        
        
        label.text = [dict objectForKey:@""];
        
//        [dict setValue:[rs stringForColumn:@"pb_number"] forKey:@"pb_number"];
//        [dict setValue:[rs stringForColumn:@"pb_letter"] forKey:@"pb_letter"];

        NSString *typeNum = [NSString stringWithFormat:@"%@%@", [self letterForNum:[[dict objectForKey:@"pb_letter"] intValue]], [dict objectForKey:@"pb_number"]];
        label.text = typeNum;
        
        
        
        
        return cell;
        
        
        
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ss-表格-1"]] ;

            
            
            
            
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:RectMake2x(0, 0, 406, 89)];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.tag = 201;
            
            [cell.contentView addSubview:nameLabel];
            
            UILabel *nameLabel1 = [[UILabel alloc] initWithFrame:RectMake2x(406, 0, 406, 89)];
            nameLabel1.textAlignment = NSTextAlignmentCenter;
            nameLabel1.tag = 202;
            
            [cell.contentView addSubview:nameLabel1];
            
            UILabel *nameLabel2 = [[UILabel alloc] initWithFrame:RectMake2x(406*2, 0, 406, 89)];
            nameLabel2.textAlignment = NSTextAlignmentCenter;
            nameLabel2.tag = 203;
            
            [cell.contentView addSubview:nameLabel2];

        }
        
        UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:201];
        UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:202];
        UILabel *label3 = (UILabel *)[cell.contentView viewWithTag:203];
        
        NSDictionary *dict = [pDataMArray objectAtIndex:indexPath.row];
        
        label1.text = [dict objectForKey:@"name"];
        label2.text = [dict objectForKey:@"standard"];
        
        if (isShowPrice) {
            label3.text =[NSString stringWithFormat:@"%.2f",  [[dict objectForKey:@"price"] doubleValue]];
        }
        else {
            label3.text =@"详情店内咨询";
        }

        
        
        
        
        return cell;
    }
    
    return nil;
}


- (NSString *)letterForNum :(int)letter
{
    NSString *letterString = nil;
    
    switch (letter) {
        case 0:
        {
          
            letterString = @"";
            break;
        }
        case 1:
        {

            letterString = @"H";
            break;
        }
        case 2:
        {
            
            letterString = @"B";
            break;
        }
        case 3:
        {
            letterString = @"BS";
            break;
        }
        case 4:
        {
            letterString = @"J";
            break;
        }
        case 5:
        {
            letterString = @"G";
            break;
        }
        default:
            break;
    }
    
    return letterString;
}

@end
