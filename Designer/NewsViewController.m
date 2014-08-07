//
//  NewsViewController.m
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NewsViewController.h"
#import "AFNetworking.h"
#import "ZHNewsDetailViewController.h"


@interface NewsViewController ()
{
    UIView *seachView;
    UIScrollView *typeSV;
    
}
@end

@implementation NewsViewController


- (void)back:(UIButton *)button
{
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    }];
    
}

- (void)seachViewHidden:(BOOL)isHidden
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        if ( ! isHidden) {
            seachView.frame = RectMake2x(-1937, 40, 1937, 1496);
        }
        else {
            seachView.frame = RectMake2x(0, 40, 1937, 1496);
        }
    }];
    
}

- (void)openSeachViewController:(UIButton *)button
{
    if (seachView.frame.origin.x  == 0) {
        [self seachViewHidden:NO];
    }
    else {
        [self seachViewHidden:YES];
    }
    
}

- (void)seachText:(UIButton *)button
{
    
    
    
}

- (void)seachType:(UIButton *)button
{
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadSeachView
{
    seachView = [[UIView alloc] initWithFrame:RectMake2x(-1937, 40, 1937, 1496)];
    seachView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"搜索-bg"]];
    
    [self.baseView addSubview:seachView];
    
    
    
    
    
    [[Button share] addToView:seachView addTarget:self rect:RectMake2x(1489, 264, 97, 80) tag:1000 action:@selector(seachText:)];
    [[Button share] addToView:seachView addTarget:self rect:RectMake2x(826, 1341, 286, 80) tag:1000 action:@selector(seachType:) imagePath:@"按钮-查找作品"];
    
    
    typeSV = [[UIScrollView alloc] initWithFrame:RectMake2x(351, 388, 1235, 933)];
    typeSV.pagingEnabled = YES;
    typeSV.bounces = NO;
    typeSV.delegate = self;
    
    [typeSV setContentSize:screen_SIZEHeight(2)];
    
    [seachView addSubview:typeSV];
    
    
    UITextField *tf = [[UITextField alloc] initWithFrame:RectMake2x(382, 285, 224, 40)];
    tf.placeholder = @"关键词";
    [seachView addSubview:tf];
    
}

- (void)loadView{
    
    [super loadView];
    
    
    
    tb = [[UITableView alloc] initWithFrame:RectMake2x(40, 190, 1858, 1346)];
    tb.backgroundColor = [UIColor clearColor];
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    tb.dataSource = self;
    tb.delegate = self;
    
    [self.baseView addSubview:tb];
    
    
    
}


- (void)loadNetWorkData
{
    
    NSString *url = [NSString stringWithFormat:@"%@api/designerapi/queryProfile/%@", KHomeUrl, kD_Id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        [self.dataMArray setArray: responseObject];
//        
//        [tb reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [[Message share] messageAlert:[NSString stringWithFormat:@"网络发生错误， 请刷新重试"]];
 
        
    }];
    
    
    
}



- (void)loadData{
    
    
    self.dataMArray = [[NSMutableArray   alloc ] init];


    [self loadNetWorkData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];

    

    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.dataMArray = [[ZHDBData share] getNews ];

    [tb reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - action

- (void)openProductDetail:(UIButton *)button
{
    
    UITableViewCell *cell = (UITableViewCell *)[[[button superview]  superview] superview];
    NSIndexPath *indexPath = [tb indexPathForCell:cell];
    
    

    
    NSMutableString *str ;
    if (indexPath.row > 0) {
        int index = (indexPath.row*4)  + button.tag - 301;
        
        NSDictionary *dict = [self.dataMArray objectAtIndex:index];
        

        str =  [NSMutableString string];
        
        [str appendString:@"<html>"];
        [str appendString:@"<body>"];
        
        [str appendString:@"<h1>"];
        [str appendFormat:@"%@", [dict objectForKey:@"title"]];
        [str appendString:@"<h1>"];

        [str appendFormat:@"%@", [dict objectForKey:@"content"]];
    
        

        [str appendString:@"</body>"];
        [str appendString:@"</html>"];
        
        
    }
    
    else {

        int index =   button.tag - 301;
        
        
        NSDictionary *dict = [self.dataMArray objectAtIndex:index];
        
        
        str =  [NSMutableString string];
        
        [str appendString:@"<html>"];
        [str appendString:@"<body>"];
        
        [str appendString:@"<h1>"];
        [str appendFormat:@"%@", [dict objectForKey:@"title"]];
        [str appendString:@"<h1>"];
        
        [str appendFormat:@"%@", [dict objectForKey:@"content"]];
        
        
        
        [str appendString:@"</body>"];
        [str appendString:@"</html>"];
    }
    
    
    

    
    ZHNewsDetailViewController  *lvc = [[ZHNewsDetailViewController alloc] init];
    lvc.htmlStr = str;

    lvc.view.alpha = 0;

    [UIView animateWithDuration:KLongDuration animations:^{
        lvc.view.alpha = 1;
    }];


    [self.view addSubview:lvc.view];
    [self addChildViewController:lvc];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataMArray.count == 0) {
        return 0;
    }
    else {
        return (self.dataMArray.count/4)+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return 818/2;
    }
    else {
        return 408/2;
    }
    
}



- (UITableViewCell *)cell4
{
    
    static NSString *CellIdentifier = @"Cell4";
    
    UITableViewCell *cell = [tb dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[ImageView share] addToView:cell.contentView imagePathName:@"productlist_cell_bg" rect:RectMake2x(0, 0, 1900, 388)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgView1 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(0, 0, 466, 388)];
    imgView1.tag = 101;
    
    UIImageView *imgView2 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(478, 0, 466, 388)];
    imgView2.tag = 102;
    
    UIImageView *imgView3 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(956, 0, 466, 388)];
    imgView3.tag = 103;
    
    UIImageView *imgView4 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(1434, 0, 466, 388)];
    imgView4.tag = 104;
    
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(0, 0, 447, 385) tag:301 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(470, 0, 447, 385) tag:302 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(941, 0, 447, 385) tag:303 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1411, 0, 447, 385) tag:304 action:@selector(openProductDetail:)];
    
    
    
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:RectMake2x(0, 694, 917, 100)];
    UILabel *l2 = [[UILabel alloc] initWithFrame:RectMake2x(941, 335, 447, 50)];
    UILabel *l3 = [[UILabel alloc] initWithFrame:RectMake2x(1411, 335, 447, 50)];
    UILabel *l4 = [[UILabel alloc] initWithFrame:RectMake2x(941, 744, 447, 50)];
    
    
    l1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-大"]];
    l2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
    l3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
    l4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
    
    l1.alpha = 0;
    l2.alpha = 0;
    l3.alpha = 0;
    l4.alpha = 0;
    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    [cell.contentView addSubview:l3];
    [cell.contentView addSubview:l4];

    
    
    
    return cell;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row ==  0  ) {
        UITableViewCell *contentView =[[UITableViewCell alloc]  initWithFrame:RectMake2x(0, 0, 1858, 794)];
        contentView.backgroundColor = [UIColor clearColor];


        UIImageView *imgView1 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(0, 0, 917, 794)];
        imgView1.tag = 101;

        UIImageView *imgView2 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(478, 0, 466, 388)];
        imgView2.tag = 102;

        UIImageView *imgView3 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(956, 0, 466, 388)];
        imgView3.tag = 103;

        UIImageView *imgView4 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(1434, 0, 466, 388)];
        imgView4.tag = 104;

        UIImageView *imgView5 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(1434, 0, 466, 388)];
        imgView5.tag = 105;


        UIButton *b1 =[[Button share] addToView:contentView addTarget:self rect:RectMake2x(0, 0, 917, 794) tag:301 action:@selector(openProductDetail:)];
        UIButton *b2 = [[Button share] addToView:contentView addTarget:self rect:RectMake2x(941, 0, 447, 385) tag:302 action:@selector(openProductDetail:)];
        UIButton *b3 =[[Button share] addToView:contentView addTarget:self rect:RectMake2x(1411, 0, 447, 385) tag:303 action:@selector(openProductDetail:)];
        UIButton *b4 =[[Button share] addToView:contentView addTarget:self rect:RectMake2x(941, 409, 447, 385) tag:304 action:@selector(openProductDetail:)];
        UIButton *b5 =[[Button share] addToView:contentView addTarget:self rect:RectMake2x(1411, 409, 447, 385) tag:304 action:@selector(openProductDetail:)];

        b1.alpha = 0;
        b2.alpha = 0;
        b3.alpha = 0;
        b4.alpha = 0;
        b5.alpha = 0;
        
        UILabel *l1 = [[UILabel alloc] initWithFrame:RectMake2x(0, 694, 917, 100)];
        UILabel *l2 = [[UILabel alloc] initWithFrame:RectMake2x(941, 335, 447, 50)];
        UILabel *l3 = [[UILabel alloc] initWithFrame:RectMake2x(1411, 335, 447, 50)];
        UILabel *l4 = [[UILabel alloc] initWithFrame:RectMake2x(941, 744, 447, 50)];
        UILabel *l5 = [[UILabel alloc] initWithFrame:RectMake2x(1411, 744, 447, 50)];
        
        
        l1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-大白"]];
        l2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
        l3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
        l4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
        l5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"列表图-小白"]];
        
        l1.alpha = 0;
        l2.alpha = 0;
        l3.alpha = 0;
        l4.alpha = 0;
        l5.alpha = 0;
        
        [contentView addSubview:l1];
        [contentView addSubview:l2];
        [contentView addSubview:l3];
        [contentView addSubview:l4];
        [contentView addSubview:l5];
        
        
        int i = 0;
        if ( [self.dataMArray count] == i ) {
            
            return contentView;
        }
        
        NSDictionary *dict1 = [self.dataMArray objectAtIndex:0];
        
        if (dict1 != nil) {
            l1.alpha = 1;
            b1.alpha = 1;
            l1.text = dict1[@"title"];
            
        }
        
        
        
        
        //----------
        if ( [self.dataMArray count] == i+1) {
            
            return contentView;
        }
        
        
        NSDictionary *dict2 = [self.dataMArray objectAtIndex:1];
        if (dict2 != nil) {
                        l2.alpha = 1;
            b2.alpha = 1;
            l2.text = dict2[@"title"];
            
        }
        
        
        //----------

        if ( [self.dataMArray count] == i+2 ) {
            
            return contentView;
        }
        
        NSDictionary *dict3 = [self.dataMArray objectAtIndex:2];
        
        if (dict3 != nil) {
                        l3.alpha = 1;
            b3.alpha = 1;
            l3.text = dict3[@"title"];
            
        }
        //----------

        if ( [self.dataMArray count] == i+3 ) {
            
            return contentView;
        }
        NSDictionary *dict4 = [self.dataMArray objectAtIndex:3];
       
        if (dict4 != nil) {
                        l3.alpha = 1;
            b4.alpha = 1;
            l4.text = dict4[@"title"];
            
        }
        
        //----------

        if ( [self.dataMArray count] == i+4 ) {
            
            return contentView;
        }
        NSDictionary *dict5 = [self.dataMArray objectAtIndex:4];
        
        if (dict5 != nil) {

            l3.alpha = 1;
            b5.alpha = 1;
            l5.text = dict5[@"title"];

        }
        
        
        
        
        return contentView;
    }

    
    static NSString *CellIdentifier = @"Cell4";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        
        cell = [self cell4];
        
    }
    
    
    int i = indexPath.row*4;
    
    
    UIImageView *imgV1 = (UIImageView *)[cell.contentView viewWithTag:101];
    UIImageView *imgV2 = (UIImageView *)[cell.contentView viewWithTag:102];
    UIImageView *imgV3 = (UIImageView *)[cell.contentView viewWithTag:103];
    UIImageView *imgV4 = (UIImageView *)[cell.contentView viewWithTag:104];
    
    UIButton *button1 = (UIButton *)[cell.contentView viewWithTag:301];
    UIButton *button2 = (UIButton *)[cell.contentView viewWithTag:302];
    UIButton *button3 = (UIButton *)[cell.contentView viewWithTag:303];
    UIButton *button4 = (UIButton *)[cell.contentView viewWithTag:304];
    
    
    imgV1.alpha = 0;
    button1.alpha = 0;
    imgV2.alpha = 0;
    button2.alpha = 0;
    
    imgV3.alpha = 0;
    button3.alpha = 0;
    
    imgV4.alpha = 0;
    button4.alpha = 0;
    
    
    if ( [self.dataMArray count] == i ) {
        
        return cell;
    }
    
    imgV1.alpha = 1;
    button1.alpha = 1;
    NSDictionary *dict1 = [self.dataMArray objectAtIndex:i];
    NSString *nameString1 = [NSString stringWithFormat:@"%@.jpg", [dict1 objectForKey:@"name"]];
    UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:KCachesName(nameString1)];
    imgV1.image = img1;
    
    
    if ( [self.dataMArray count] == i+1 ) {
        
        return cell;
    }
    imgV2.alpha = 1;
    button2.alpha = 1;
    
    NSDictionary *dict2 = [self.dataMArray objectAtIndex:i+1];
    
    NSString *nameString2 = [NSString stringWithFormat:@"%@.jpg", [dict2 objectForKey:@"name"]];
    
    UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:KCachesName(nameString2)];
    imgV2.image = img2;
    
    
    
    
    
    
    if ( [self.dataMArray count] == i+2 ) {
        
        return cell;
    }
    imgV3.alpha = 1;
    button3.alpha = 1;
    NSDictionary *dict3 = [self.dataMArray objectAtIndex:i+2];
    
    NSString *nameString3 = [NSString stringWithFormat:@"%@.jpg", [dict3 objectForKey:@"name"]];
    
    UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(nameString3)];
    imgV3.image = img3;
    
    
    
    
    if ( [self.dataMArray count] == i+3 ) {
        
        return cell;
    }
    imgV4.alpha = 1;
    button4.alpha = 1;
    NSDictionary *dict4 = [self.dataMArray objectAtIndex:i+3];
    
    NSString *nameString4 = [NSString stringWithFormat:@"%@.jpg", [dict4 objectForKey:@"name"]];
    
    UIImage *img4 = [[UIImage alloc] initWithContentsOfFile:KCachesName(nameString4)];
    imgV4.image = img4;
    
    
    
    
    return cell;

    
    
}

//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *contentView =[[UIView alloc]  initWithFrame:RectMake2x(0, 0, 1858, 794)];
//    
//    
//    UIImageView *imgView1 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(0, 0, 466, 388)];
//    imgView1.tag = 101;
//    
//    UIImageView *imgView2 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(478, 0, 466, 388)];
//    imgView2.tag = 102;
//    
//    UIImageView *imgView3 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(956, 0, 466, 388)];
//    imgView3.tag = 103;
//    
//    UIImageView *imgView4 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(1434, 0, 466, 388)];
//    imgView4.tag = 104;
//    
//    UIImageView *imgView5 = [[ImageView share] addToView:contentView imagePathName:nil rect:RectMake2x(1434, 0, 466, 388)];
//    imgView5.tag = 105;
//    
//    
//    [[Button share] addToView:contentView addTarget:self rect:RectMake2x(0, 0, 917, 794) tag:301 action:@selector(openProductDetail:)];
//    [[Button share] addToView:contentView addTarget:self rect:RectMake2x(941, 0, 447, 385) tag:302 action:@selector(openProductDetail:)];
//    [[Button share] addToView:contentView addTarget:self rect:RectMake2x(1411, 0, 447, 385) tag:303 action:@selector(openProductDetail:)];
//    [[Button share] addToView:contentView addTarget:self rect:RectMake2x(941, 409, 447, 385) tag:304 action:@selector(openProductDetail:)];
//    [[Button share] addToView:contentView addTarget:self rect:RectMake2x(1411, 409, 447, 385) tag:304 action:@selector(openProductDetail:)];
//
//    
//    return contentView;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
