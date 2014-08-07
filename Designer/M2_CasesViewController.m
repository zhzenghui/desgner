//
//  CasesViewController.m
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//


#import "M2_CasesViewController.h"
#import "M1_CaseDetailViewController.h"
#import "UIImage+ImageEffects.h"

#import "M2_CasesCell.h"

@interface M2_CasesViewController ()
{
    UIView *seachView;
    UIScrollView *typeSV;
    
    UITextField *tf;
}
@end

@implementation M2_CasesViewController


- (void)back:(UIButton *)button
{

    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.alpha  = 0;
    }];

}

- (void)seachViewHidden:(BOOL)isHidden
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        if ( isHidden) {
            seachView.frame = RectMake2x(-2048, 0, 2048, 1536);
        }
        else {
            seachView.frame = RectMake2x(0, 0, 2048, 1536);
        }
    }];

}

- (void)openSeachViewController:(UIButton *)button
{
    if (seachView.frame.origin.x  >=  0) {
        [self seachViewHidden:YES];
    }
    else {
        
//        UIImage *img =  [UIImage imageWithView:self.view];
        
//        seachView.backgroundColor = [UIColor colorWithPatternImage: [img applyExtraLightEffect]];
        [self seachViewHidden:NO];
    }

}

- (void)seachText:(UIButton *)button
{

    [tf resignFirstResponder];
    self.dataMArray = [[ZHDBData share] getCaseForWords:tf.text];
    
    
    [_collectionView reloadData];
    
    
    [self seachViewHidden:YES];
    

    


}

- (void)seachType:(UIButton *)button
{

    
    if (tagsArray.count == 0) {

        self.dataMArray = [[ZHDBData share] getCasesForD_Id:kD_Id];
    }
    else {
        self.dataMArray = [[ZHDBData share] getCaseForTags:tagsArray];
    }

    
    [_collectionView reloadData];
    
    
    [self seachViewHidden:YES];
    
    
//    [tagsArray removeAllObjects];
    
}


- (void)openTag:(UIButton *)button{
    
}


- (void)closeSeachView:(UIButton *)button {
    [self seachViewHidden:YES];
}

- (void)openTagsR:(UIButton *)button
{
    NSString *s = [NSString stringWithFormat:@"%d", button.tag ];
    
//    已经选择
    if (button.selected) {
        button.selected = NO;
        button.backgroundColor = [UIColor clearColor];

        [tagsArray removeObject:s];



        
        return;
    }
    else {
        button.backgroundColor = [UIColor grayColor];
        button.selected = YES;
        
        [tagsArray addObject:s];

    }

    
    if (tagsArray .count == 0) {
        self.dataMArray = [[ZHDBData share] getCasesForD_Id:kD_Id];
        [_collectionView reloadData];
    }
    else {
        self.dataMArray = [[ZHDBData share] getCaseForTags:tagsArray];
        [_collectionView reloadData];
    }
    
    
    return;
//   未选择

    

    bool isInsert = true;
    for (NSString *sTag in tagsArray) {
        
        if (sTag == s) {
            isInsert = false;
        }

    }
    
    
    if (isInsert) {
        [tagsArray addObject:s];
    }

    
    self.dataMArray = [[ZHDBData share] getCaseForTags:tagsArray];

    [_collectionView reloadData];

    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//  8 列  110 宽
//  行    65

- (void)loadTags
{
    NSMutableArray *tags = [[ZHDBData share] getTagsForD_Id:kD_Id];
    
    
    int x = 0;
    int y = 15;
    
    
    int i = 0;
    int j = 0;
    
    int width = 110;
    int hight = 65;
    

    int svHight = 0;
    for (NSDictionary *d  in tags) {
        
        NSString *sort = d[@"sort"];
        NSMutableArray *tag = [[ZHDBData share] getTagsForSort:sort];
        
        j = 0;
        
        int tagX = 0;
        int tagY = 0;
        
        for (NSDictionary *tagD  in tag) {
            
            tagX = 0;
            tagY = 0;

            tagY = j/8;
            tagX = j % 8;
            NSString *tagName = tagD[@"name"];
            
            
            UIButton *tagButton = [[Button share] addToView:typeSV addTarget:self rect:CGRectMake( tagX*width, y+tagY*50+  + svHight , 100, 44) tag:1 action:@selector(openTag:)];
            [tagButton setTitle:tagName forState:UIControlStateNormal];
            tagButton.backgroundColor = [UIColor clearColor];
            tagButton.tag = [tagD[@"id"] intValue];
            
            [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            [tagButton addTarget:self action:@selector(openTagsR:) forControlEvents:UIControlEventTouchUpInside];
            
            
            j++;
        }
        
        int lineCount = 0;
        lineCount = tag.count/8;

        if (tag.count%8 !=0 || tag.count < 8) {
            
            lineCount ++;
        }
        int lineY = lineCount *65;
        svHight = svHight + lineY;

        [[ImageView share] addToView:typeSV imagePathName:@"搜索-虚线@2x" rect:CGRectMake(x, svHight, 1235, 2)];
        i++;
        
    }
    
    [typeSV setContentSize:CGSizeMake(typeSV.frame.size.width, svHight)];
}



//- (void)loadTags
//{
//    NSMutableArray *tags = [[ZHDBData share] getTagsForD_Id:kD_Id];
//    
//    
//    int x = 0;
//    int y = 0;
//    
//    
//    int i = 0;
//    int j = 0;
//    
//    int  width = 1880;
//    int countWidth =0;
//    for (NSDictionary *d  in tags) {
//        
//        NSString *sort = d[@"sort"];
//        //        NSString *str = d[@"name"];
//        
//        
//        NSMutableArray *tag = [[ZHDBData share] getTagsForSort:sort];
//        
//        
//        if (countWidth < tag.count) {
//            countWidth = tag.count;
//        }
//        
//        
//        j = 0;
//        for (NSDictionary *tagD  in tag) {
//            
//            
//            NSString *tagName = tagD[@"name"];
//            
//            
//            UIButton *tagButton = [[Button share] addToView:typeSV addTarget:self rect:CGRectMake(x+j*110, i*65+10, 100, 44) tag:1 action:@selector(openTag:)];
//            [tagButton setTitle:tagName forState:UIControlStateNormal];
//            tagButton.backgroundColor = [UIColor clearColor];
//            tagButton.tag = [tagD[@"id"] intValue];
//            
//            [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//            
//            [tagButton addTarget:self action:@selector(openTagsR:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            j++;
//        }
//        
//        [[ImageView share] addToView:typeSV imagePathName:@"搜索-虚线@2x" rect:CGRectMake(x, y+i*65+65, 1235, 2)];
//        i++;
//        
//    }
//    
//    [typeSV setContentSize:CGSizeMake(110 * countWidth, 633)];
//}

- (void)loadSeachView
{
    seachView = [[UIView alloc] initWithFrame:RectMake2x(-2048, 0, 2048 , 1536)];
    seachView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"双子-郭正作品-bg1"]];
    
    [self.view addSubview:seachView];
    
    
    
    [[ImageView share] addToView:seachView imagePathName:@"搜索-bg" rect:RectMake2x(0, 0, 1937, 1496)];
    
    [[Button share] addToView:seachView addTarget:self rect:RectMake2x(1482, 1168, 160, 80) tag:1000 action:@selector(seachText:)];
    [[Button share] addToView:seachView addTarget:self rect:RectMake2x(826, 1341, 286, 80) tag:1000 action:@selector(seachType:) imagePath:@"按钮-查找作品"];

    [[Button share] addToView:seachView addTarget:self rect:RectMake2x(1888, 120 , 100, 100) tag:1001 action:@selector(closeSeachView:) imagePath:@"按钮-返回-rigth-top@2x"];

    typeSV = [[UIScrollView alloc] initWithFrame:RectMake2x(80, 353, 1880, 810)];
    typeSV.bounces = NO;
    typeSV.delegate = self;
    
    
    [seachView addSubview:typeSV];
    
    
    tf = [[UITextField alloc] initWithFrame:RectMake2x(438, 1168, 1010, 80)];
    tf.placeholder = @"关键词";
    tf.delegate = self;
    if (! iOS7) {
        tf.frame = RectMake2x(438, 1198, 1010, 80);
    }
    [seachView addSubview:tf];
    
    [self loadTags];
}

- (void)loadView{

    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"双子-郭正作品-bg"]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    
    _collectionView =[[UICollectionView alloc] initWithFrame:RectMake2x(40, 388, 1968, 1028) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[M2_CasesCell class]  forCellWithReuseIdentifier:@"M2_CasesCell"];
    
    [self.view addSubview:_collectionView];
    
    
    
    NSString *str = @"按钮-搜索";
    
    NSString *imgNormal = [NSString stringWithFormat:@"%@-00", str ];
    NSString *imgSelect = [NSString stringWithFormat:@"%@-01", str ];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = RectMake2x(1748, 120, 100, 100);
    [button addTarget:self action:@selector(openSeachViewController:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    
    
    
    NSString *name = [NSString stringWithFormat:@"按钮-刷新." ];
    
    UIButton *re_button = [UIButton buttonWithType:UIButtonTypeCustom];
    re_button.frame = RectMake2x(1608, 120, 100, 100);
    [re_button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [re_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [self.view addSubview:re_button];
    

    [self addBackButtion];
    
    
    
}

- (void)reload
{
    self.dataMArray = [[ZHDBData share] getCasesForD_Id:kD_Id];//[[NSMutableArray alloc] init];

    [_collectionView reloadData];
}

- (void)loadData{
    
    
    self.dataMArray = [[ZHDBData share] getCasesForD_Id:kD_Id];//[[NSMutableArray alloc] init];

    tagsArray = [[NSMutableArray alloc] init];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    
    
//    [[ImageView share] addToView:self.view imagePathName:@"平面作品-logo" rect:RectMake2x(50, 90, 84, 285)];
    
//    NSString *str = @"按钮-搜索";
//
//    
//    NSString *imgNormal = [NSString stringWithFormat:@"%@-00", str ];
//    NSString *imgSelect = [NSString stringWithFormat:@"%@-01", str ];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(20, 395/2, 110/2, 130/2);
//
//    [button addTarget:self action:@selector(openSeachViewController:) forControlEvents:UIControlEventTouchUpInside];
//    [button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateHighlighted];
//    
//    [self.view addSubview:button];
    
    
    
    
    

//    NSString *name = [NSString stringWithFormat:@"按钮-刷新" ];
//    
//    UIButton *re_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    re_button.frame = CGRectMake(40/2, 525/2, 110/2, 130/2);
//    [re_button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
//    [re_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//
//
//    [self.view addSubview:re_button];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self loadSeachView];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [tf resignFirstResponder];
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
    
    
    if ( !iOS7) {
        cell = (UITableViewCell *)[[button superview]  superview];
    }
    
    NSIndexPath *indexPath = [tb indexPathForCell:cell];
    
    
    int index = (indexPath.row*3)  + button.tag - 301;
    
    NSString *cate_id = [NSString stringWithFormat:@"%d", [[[self.dataMArray objectAtIndex:index] objectForKey:@"id"] intValue]];
    
    
    
    NSMutableArray *products = [[ZHDBData share] getCasesDetailForC_Id:cate_id];
    
    
    if (products.count == 0) {
        [[Message share] messageAlert:@"敬请期待！"];
        return;
    }
    
    M1_CaseDetailViewController  *lvc = [[M1_CaseDetailViewController alloc] init];
    lvc.dataMArray = products;
    lvc.dataMDict = [self.dataMArray objectAtIndex:index] ;
    
    [self.view  addSubview:lvc.view];
    [self addChildViewController:lvc];
    
    
    
    
    lvc.view.alpha = 0; 

    [UIView animateWithDuration:KLongDuration animations:^{
        lvc.view.alpha = 1;
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    if (self.dataMArray.count%3 != 0) {
        i =  1;
    }
    return (self.dataMArray.count/3)+i;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row %2 != 0) {
        
        return 265;
    }
    else {
        return 530;
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
    
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(0, 0, 466, 388) tag:301 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(478, 0, 466, 388) tag:302 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(956, 0, 466, 388) tag:303 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1434, 0, 466, 388) tag:304 action:@selector(openProductDetail:)];
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:RectMake2x(17, 988, 300, 25)];
    UILabel *l2 = [[UILabel alloc] initWithFrame:RectMake2x(646, 459, 300, 25)];
    UILabel *l3 = [[UILabel alloc] initWithFrame:RectMake2x(1275 , 459, 300, 25)];
    UILabel *l4 = [[UILabel alloc] initWithFrame:RectMake2x(1275 , 459, 300, 25)];

    l1.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l2.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l3.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l4.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    
    l1.tag = 201;
    l2.tag = 202;
    l3.tag = 203;
    l4.tag = 203;

    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    [cell.contentView addSubview:l3];
    [cell.contentView addSubview:l4];

    
    return cell;
    
    
}



- (UITableViewCell *)cell3
{
    
    static NSString *CellIdentifier = @"Cell3";
    
    UITableViewCell *cell = [tb dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [[ImageView share] addToView:cell.contentView imagePathName:@"productlist_cell_bg" rect:RectMake2x(0, 0, 1900, 388)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
//    int  cornerRadius = 6;
    UIImageView *imgView1 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(0, 0, 1229,1029)];
    imgView1.tag = 101;
//    imgView1.layer.cornerRadius = cornerRadius;
//    imgView1.layer.masksToBounds = YES;
    
    UIImageView *imgView2 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(1258, 0, 600, 500)];
//    imgView2.layer.cornerRadius = cornerRadius;
//    imgView2.layer.masksToBounds = YES;
    imgView2.tag = 102;
    
    UIImageView *imgView3 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(1258, 529, 600, 500)];
//    imgView3.layer.cornerRadius = cornerRadius;
//    imgView3.layer.masksToBounds = YES;
    imgView3.tag = 103;
    
    
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:RectMake2x(0, 979, 1229, 50)];
    UILabel *l2 = [[UILabel alloc] initWithFrame:RectMake2x(1258, 450, 600, 50)];
    UILabel *l3 = [[UILabel alloc] initWithFrame:RectMake2x(1258 , 979, 600, 50)];

    l1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-大"]];
    l2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-中"]];
    l3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-中"]];
    
    l1.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l2.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l3.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];

    
    
    l1.tag = 201;
    l2.tag = 202;
    l3.tag = 203;
    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    [cell.contentView addSubview:l3];
    
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(0, 0, 1229,1029) tag:301 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1258, 0, 600, 500) tag:302 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1258, 529, 600, 500) tag:303 action:@selector(openProductDetail:)];
    
    
    
    return cell;

    
}

- (UITableViewCell *)cell3Height
{
    
    static NSString *CellIdentifier = @"Cell3h";
    
    UITableViewCell *cell = [tb dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[ImageView share] addToView:cell.contentView imagePathName:@"productlist_cell_bg" rect:RectMake2x(0, 0, 1900, 388)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    
//    int  cornerRadius = 0;

    UIImageView *imgView1 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(0, 0, 600,500)];
    imgView1.tag = 101;

//    imgView1.layer.cornerRadius = cornerRadius;
//    imgView1.layer.masksToBounds = YES;
    
    
    UIImageView *imgView2 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(629, 0, 600, 500)];
    imgView2.tag = 102;
//    imgView2.layer.cornerRadius = cornerRadius;
//    imgView2.layer.masksToBounds = YES;
    
    UIImageView *imgView3 = [[ImageView share] addToView:cell.contentView imagePathName:nil rect:RectMake2x(1258, 0, 600, 500)];
    imgView3.tag = 103;
//    imgView3.layer.cornerRadius = cornerRadius;
//    imgView3.layer.masksToBounds = YES;
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:RectMake2x(0, 450, 600, 50)];
    UILabel *l2 = [[UILabel alloc] initWithFrame:RectMake2x(629, 450, 600, 50)];
    UILabel *l3 = [[UILabel alloc] initWithFrame:RectMake2x(1258 , 450, 600, 50)];
    
    l1.tag = 201;
    l2.tag = 202;
    l3.tag = 203;
    
    

    l1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-中"]];
    l2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-中"]];
    l3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"文字白条-中"]];

    
    
    
    l1.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l2.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];
    l3.textColor = [[Theme share] giveColorfromStringColor:@"cellLabel"];

    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    [cell.contentView addSubview:l3];
    
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(0, 0, 600, 500) tag:301 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(629, 0, 600, 500) tag:302 action:@selector(openProductDetail:)];
    [[Button share] addToView:cell.contentView addTarget:self rect:RectMake2x(1258, 0, 600, 500) tag:303 action:@selector(openProductDetail:)];
    
    
    
    return cell;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row %2 != 0) {
        
        static NSString *CellIdentifier = @"Cell3h";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [self cell3Height];
        }
        
        
        int i = indexPath.row*3;
        
        
        UIImageView *imgV1 = (UIImageView *)[cell.contentView viewWithTag:101];
        UIImageView *imgV2 = (UIImageView *)[cell.contentView viewWithTag:102];
        UIImageView *imgV3 = (UIImageView *)[cell.contentView viewWithTag:103];
        UIImageView *imgV4 = (UIImageView *)[cell.contentView viewWithTag:104];
        
        UIButton *button1 = (UIButton *)[cell.contentView viewWithTag:301];
        UIButton *button2 = (UIButton *)[cell.contentView viewWithTag:302];
        UIButton *button3 = (UIButton *)[cell.contentView viewWithTag:303];
        UIButton *button4 = (UIButton *)[cell.contentView viewWithTag:304];
        
        
        
        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:201];
        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:202];
        UILabel *l3 = (UILabel *)[cell.contentView viewWithTag:203];

        
        l1.alpha = 0;
        l2.alpha = 0;
        l3.alpha = 0;
        
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
        l1.alpha = 1;
        NSDictionary *dict1 = [self.dataMArray objectAtIndex:i];
        NSString *nameString1 = [NSString stringWithFormat:@"%@", [dict1 objectForKey:@"p_name"]];
        NSString *name = [[nameString1 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@600x500.jpg", name];

        UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
        imgV1.image = img1;
        l1.text = [NSString stringWithFormat:@"  %@",  dict1[@"a_name"]];

        [UIImage imageNamed:@""];
        if ( [self.dataMArray count] == i+1 ) {
            
            return cell;
        }
        imgV2.alpha = 1;
        button2.alpha = 1;
        l2.alpha = 1;
        NSDictionary *dict2 = [self.dataMArray objectAtIndex:i+1];

        NSString *nameString2 = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"p_name"]];
        NSString *name2 = [[nameString2 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName2 = [NSString stringWithFormat:@"%@600x500.jpg", name2];
        UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName2)];
        imgV2.image = img2;
        l2.text = [NSString stringWithFormat:@"  %@",  dict2[@"a_name"]];

        
        
        
        
        
        if ( [self.dataMArray count] == i+2 ) {
            
            return cell;
        }
        imgV3.alpha = 1;
        button3.alpha = 1;
        l3.alpha = 1;

        

        NSDictionary *dict3 = [self.dataMArray objectAtIndex:i+2];
        
        NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict3 objectForKey:@"p_name"]];
        NSString *name3 = [[nameString3 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName3 = [NSString stringWithFormat:@"%@600x500.jpg", name3];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName3)];
        imgV3.image = img3;
        l3.text = [NSString stringWithFormat:@"  %@",  dict3[@"a_name"]];

        
        
        

        
        
        return cell;
    }
    else {
        static NSString *CellIdentifier = @"Cell3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            
            cell = [self cell3];
            
            
        }
        
        int i = indexPath.row*3;

        
        UIImageView *imgV1 = (UIImageView *)[cell.contentView viewWithTag:101];
        UIImageView *imgV2 = (UIImageView *)[cell.contentView viewWithTag:102];
        UIImageView *imgV3 = (UIImageView *)[cell.contentView viewWithTag:103];
        
        UIButton *button1 = (UIButton *)[cell.contentView viewWithTag:301];
        UIButton *button2 = (UIButton *)[cell.contentView viewWithTag:302];
        UIButton *button3 = (UIButton *)[cell.contentView viewWithTag:303];
        
       
        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:201];
        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:202];
        UILabel *l3 = (UILabel *)[cell.contentView viewWithTag:203];

        imgV1.alpha = 0;
        button1.alpha = 0;
        imgV2.alpha = 0;
        button2.alpha = 0;
        
        imgV3.alpha = 0;
        button3.alpha = 0;
        
        l1.alpha = 0;
        l2.alpha = 0;
        l3.alpha = 0;
        

        
        
        if ( [self.dataMArray count] == i ) {
            
            return cell;
        }
        
        imgV1.alpha = 1;
        button1.alpha = 1;
        l1.alpha = 1;
        NSDictionary *dict1 = [self.dataMArray objectAtIndex:i];
        NSString *nameString1 = [NSString stringWithFormat:@"%@", [dict1 objectForKey:@"p_name"]];
        NSString *name = [[nameString1 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
        UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
        imgV1.image = img1;
        l1.text = [NSString stringWithFormat:@"  %@",  dict1[@"a_name"]];

        if ( [self.dataMArray count] == i+1 ) {
            
            return cell;
        }
        imgV2.alpha = 1;
        button2.alpha = 1;
        l2.alpha = 1;
        NSDictionary *dict2 = [self.dataMArray objectAtIndex:i+1];
        
        NSString *nameString2 = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"p_name"]];
        NSString *name2 = [[nameString2 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName2 = [NSString stringWithFormat:@"%@600x500.jpg", name2];
        UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName2)];
        imgV2.image = img2;
        l2.text = [NSString stringWithFormat:@"  %@",  dict2[@"a_name"]];

        
        
        
        
        
        if ( [self.dataMArray count] == i+2 ) {
            
            return cell;
        }
        imgV3.alpha = 1;
        button3.alpha = 1;
        l3.alpha = 1;
        NSDictionary *dict3 = [self.dataMArray objectAtIndex:i+2];
        
        NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict3 objectForKey:@"p_name"]];
        NSString *name3 = [[nameString3 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName3 = [NSString stringWithFormat:@"%@600x500.jpg", name3];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName3)];
        imgV3.image = img3;
        
        l3.text = [NSString stringWithFormat:@"  %@",  dict3[@"a_name"]];

        
 
        

        
        return cell;
        
        
    }

   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



- (void)setContentOffset:(float)contentOffset
{

    
    tb.frame = RectMake2x( 40 -  contentOffset/2 , 80, 1858, 1416);

    
}

#pragma mark - text field

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.frame = CGRectMake(0, -360, 1024, 768);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    M2_CasesCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"M2_CasesCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [self.dataMArray objectAtIndex:indexPath.row];
    cell.dict = dict;
    
    return cell;
    
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(661/2, 500/2);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *cate_id = [NSString stringWithFormat:@"%d", [[[self.dataMArray objectAtIndex:indexPath.row] objectForKey:@"id"] intValue]];
    
    
    
    NSMutableArray *products = [[ZHDBData share] getCasesDetailForC_Id:cate_id];
    M1_CaseDetailViewController  *lvc = [[M1_CaseDetailViewController alloc] init];
    lvc.dataMArray = products;
    lvc.dataMDict = [self.dataMArray objectAtIndex:indexPath.row] ;
    
    [self.view  addSubview:lvc.view];
    [self addChildViewController:lvc];
    
    
    
    
    lvc.view.alpha = 0;
    
    [UIView animateWithDuration:KLongDuration animations:^{
        lvc.view.alpha = 1;
    }];

    
    
}


@end
