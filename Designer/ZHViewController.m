//
//  ZHViewController.m
//  Designer
//
//  Created by bejoy on 14-3-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHViewController.h"
#import "AFNetworking.h"

#import "CasesViewController.h"
#import "PaintViewController.h"
#import "DesignerViewController.h"
#import "NewsViewController.h"
#import "BejoyViewController.h"
#import "NetWork.h"
#import "SVProgressHUD.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "ZHCaseDetailViewController.h"



@interface ZHViewController ()
{
    UIView *launchView;
    UIView *mainView;
    
    UIView *menuView;
    UIImageView *iv;

    UIScrollView *sv;
    
    bool alertUpdate;

    
    UILabel *mainCasesLable;
    UILabel *emailLabel;
    UILabel *phoneLabel;
    
    
    SGFocusImageFrame *imageFrame;
}


@end

@implementation ZHViewController


#pragma mark - openViewController

- (void)openViewController:(UIButton *)button
{

    if (currentButton != button) {
        currentButton = button;
        for (int i = 1; i< 7; i++) {
            
            UIButton *b =(UIButton *)[menuView viewWithTag:i];
            b.selected = NO;
        }
        button.selected = YES;
    }
    
    
    
    BaseViewController *bv;
    switch (button.tag ) {
        case 1:
        {
            bv = [[CasesViewController alloc] init];
            break;
        }
        case 2:
        {
            bv = [[PaintViewController alloc] init];

            break;
        }
        case 3:
        {
            bv = [[DesignerViewController alloc] init];

            break;
        }
        case 4:
        {
            bv = [[NewsViewController alloc] init];
            
            
            break;
        }
        case 11:
        {
            
            [self update];
            
            return;
            break;
        }
        case 12:
        {
            
            bv = [[BejoyViewController alloc] init];
            
            break;
        }

        default:
            break;
    }


    bv.view.alpha  = 0;
    [self.view addSubview:bv.view];
    [self addChildViewController:bv];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        bv.view.alpha  = 1;
    }];


    
}


- (void)dd
{
//    http://localhost:3000/users/sign_in
    
//
//
    
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.103:3000/sessions"];

    NSURL *URL = [NSURL URLWithString:@"http://example.com/foo.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    

    
//    AFHTTPRequestOperation *httpOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"820144529@qq.com" forKey:@"session[email]"];
    [dict setValue:@"zenghui" forKey:@"session[password]"];
//    [request setValue:@"application/json"
//   forHTTPHeaderField:@"content-type"];
//    
//    [request setValue:@"application/json"
//   forHTTPHeaderField:@"accept"];
//
//
//
//
    [manager POST:url
       parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {

              NSString *s = [NSString stringWithUTF8String:[responseObject bytes]];
              NSLog(@"%@", s);
    
              
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];


}


#pragma mark - 

- (void)showMenuView
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        menuView.frame = CGRectMake(0, 0, 55, 768);
    }];

}


- (void)scrollMain
{
    
    [sv scrollRectToVisible:screen_BOUNDS(1) animated:NO];
    
}

- (void)loadCase
{
    self.dataMArray = [[ZHDBData share] getCasesRecommendForD_Id:kD_Id];
    
    NSMutableArray *arrayP = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSDictionary *dict in self.dataMArray) {
        
        NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict objectForKey:@"p_name"]];
        
        NSString *name = [[nameString3 componentsSeparatedByString:@"."] firstObject];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
        
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
        SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:[dict objectForKey:@"a_name"] image:img3 tag:i+1];
        

        [arrayP addObject:item1];
        i ++;
    }
    
    
    if (imageFrame) {
        [imageFrame removeFromSuperview];
        imageFrame = nil;
        
    }

    imageFrame = [[SGFocusImageFrame alloc] initWithFrame:RectMake2x(170, 486, 897, 673)
                                                                    delegate:self array:arrayP];
    [mainView addSubview:imageFrame];
    

    NSDictionary *designerDict = [[ZHDBData share] getDesignerForD_Id:kD_Id];
    phoneLabel.text = designerDict[@"mobile"];
    emailLabel.text = designerDict[@"email"];

}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"扉页-bg"]];
    

    launchView = [[UIView alloc] initWithFrame:screen_BOUNDS(0)];
    launchView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"扉页-0"]];
    launchView.frame = screen_BOUNDS(0 );


    
    mainView = [[UIView alloc] initWithFrame:screen_BOUNDS(1)];
    mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-bg"]];
    mainView.frame = screen_BOUNDS(1);

    
    iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页-logo"]];
    iv.frame = screen_BOUNDS(2);
    
    
    
    
    mainCasesLable = [[UILabel alloc] initWithFrame:RectMake2x(195, 1114, 289, 33)];
    mainCasesLable.textColor = [UIColor clearColor];
    mainCasesLable.backgroundColor = [UIColor clearColor];
    mainCasesLable.textColor =[[Theme share] giveColorfromStringColor:@"mainCasesLable"];

    [mainView addSubview:mainCasesLable];
    
    

    
    
    

    sv = [[UIScrollView alloc] initWithFrame:screen_BOUNDS(0)];
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.delegate = self;

    [sv addSubview:launchView];
    [sv addSubview:mainView];
    [sv addSubview:iv];

    [sv setContentSize:screen_SIZEHeight(2)];
    [self.view addSubview:sv];
    
    
    
    phoneLabel = [[UILabel alloc] initWithFrame:RectMake2x(184, 1470, 321, 51)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [[Theme share] giveColorfromStringColor:@"phoneLabel"];
    [mainView addSubview:phoneLabel];
    
    
    emailLabel = [[UILabel alloc] initWithFrame:RectMake2x(506, 1470, 420, 51)];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.textColor = [[Theme share] giveColorfromStringColor:@"emailLabel"];
    [mainView addSubview:emailLabel];
    

    menuView = [[UIView alloc] initWithFrame:CGRectMake(-55, 0, 55, 768)];
    menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"左导航条-bg"]];
    [self.view addSubview:menuView];
    
    NSArray *array = @[@"按钮-1", @"按钮-2", @"按钮-3" ];
// 新闻 , @"按钮-4" 
    NSArray *array1 = @[  @"按钮-5" , @"按钮-6" ];

    
    int yHeight = 190/2;
    int y = 130/2;
    
    int ii = 1;
    for (NSString *str in array ) {
        NSString *imgNormal = [NSString stringWithFormat:@"%@-0", str ];
        NSString *imgSelect = [NSString stringWithFormat:@"%@-1", str ];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, yHeight + (ii-1)*y, 110/2, 130/2);
        button.tag = ii;
        [button addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateHighlighted];

//        [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateSelected];
        
        [menuView addSubview:button];
        
        ii ++;
    }

    
    
    int yH = 1276/2;

    int j = 1;
    for (NSString *str in array1 ) {
        NSString *imgNormal = [NSString stringWithFormat:@"%@-0", str ];
        NSString *imgSelect = [NSString stringWithFormat:@"%@-1", str ];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, yH + (j-1)*y, 110/2, 130/2);
        button.tag = j+10;
        [button addTarget:self action:@selector(openViewController:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateHighlighted];
        
        //        [button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateSelected];
        
        [menuView addSubview:button];
        
        j ++;
    }
    
    
    
    [self loadCase];

    
}

- (void)loadData{
    
    _viewControllers = [[NSMutableArray alloc] init];
    
    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    

 }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    launchView .frame = CGRectMake(0, -scrollView.contentOffset.y, 1024, 768);
    iv.frame = CGRectMake(0, -scrollView.contentOffset.y+ 768*2, 1024, 768);
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 500) {
        [scrollView setScrollEnabled:NO];
        [launchView removeFromSuperview];
        
        
        
        [self showMenuView];
        
        
        if ( [Cookie getCookie:@"update"] == nil) {
            
            [self updateData];
        }
    }
    
    

}

#pragma mark - Action

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    

    
    
    int index = item.tag-1;
    
    NSString *cate_id = [NSString stringWithFormat:@"%d", [[[self.dataMArray objectAtIndex:index] objectForKey:@"id"] intValue]];
    
    
    
    NSMutableArray *products = [[ZHDBData share] getCasesDetailForC_Id:cate_id];
    

    
    if (products.count == 0) {
        [[Message share] messageAlert:@"敬请期待！"];
        return;
    }
    
    ZHCaseDetailViewController *lvc = [[ZHCaseDetailViewController alloc] init];
    lvc.dataMArray = products;
    lvc.dataMDict = [self.dataMArray objectAtIndex:index] ;
    
    
    
    [self.view addSubview:lvc.view];
    [self addChildViewController:lvc];
    
    lvc.view.alpha = 0;
    
    [UIView animateWithDuration:KLongDuration animations:^{
        lvc.view.alpha = 1;
    }];
    

}


#pragma mark - Action
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1) {
        
        [self updateData];

    }
}

#pragma mark - update

- (PendingOperations *)pendingOperations {
    if (!_pendingOperations) {
        _pendingOperations = [[PendingOperations alloc] init];
    }
    return _pendingOperations;
}


- (void)cancelAllOperations {
    [self.pendingOperations.downloadQueue cancelAllOperations];
}

// 3. 每一次下载完成一个进行回调

- (void)downloaderDidFinish:(ImageDownloader *)downloader
{
    
    
    if ([downloader.dict[@"type"] isEqualToString:@"pdf"]) {
        [[ZHDBData share] updatePDFDownLoaded:[downloader.dict objectForKey:@"id"]];
    }
    else {
        [[ZHDBData share] updatePicDownLoaded:[downloader.dict objectForKey:@"id"]];
    }

    [self.pendingOperations.downloadsInProgress removeObjectForKey: [downloader.dict objectForKey:@"url"]];
    
    float xiazaishuliang = [picArray count] - [self.pendingOperations.downloadsInProgress count];

    
    
    if (xiazaishuliang < 0  || xiazaishuliang > 1000000000) {
        xiazaishuliang = 0;
    }
    
    NSString *s = [NSString stringWithFormat:@"已下载%f个，共%d个",  xiazaishuliang, [picArray count]];
    s = [NSString stringWithFormat:@"%.1f%%  \n\n 请保持屏幕为常亮状态",  (xiazaishuliang/[picArray count]) *100];
    [SVProgressHUD showWithStatus:s maskType:SVProgressHUDMaskTypeGradient];
    
    
    if ([self.pendingOperations.downloadsInProgress count] == 0 ) {
        [Cookie setCookie:@"update" value:@"s"];
        [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;

        
        [self loadCase];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLoadCase" object:nil userInfo:nil];
        
        
        

        [SVProgressHUD showWithStatus:@"更新已完成！" maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
        
    }
    
}




//  2. 下载图片文件
- (void)passDidFinish
{
    
    picArray = [[ZHDBData share] getPics];
    


    
    for (NSMutableDictionary *dict in picArray) {
        
        NSString *fileName = [dict objectForKey:@"name"];
        NSString *writableDBPath = KCachesName(fileName);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager fileExistsAtPath:writableDBPath];
        if (success) {
            
            [[ZHDBData share] updatePicDownLoaded:[dict objectForKey:@"id"]];
            continue;
        }
        
        [dict setObject:@"image" forKey:@"type"];

        
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:dict  delegate:self];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:[dict objectForKey:@"url"]];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
    
    
    NSMutableArray *pdfArray =  [[ZHDBData share] getPDFFiles];
    for (NSMutableDictionary *dict in pdfArray) {
        
        NSString *fileName = [dict objectForKey:@"name"];
        NSString *writableDBPath = KCachesName(fileName);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager fileExistsAtPath:writableDBPath];
        if (success) {
            
            [[ZHDBData share] updatePicDownLoaded:[dict objectForKey:@"id"]];
            continue;
        }
        
        [dict setObject:@"pdf" forKey:@"type"];
        
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:dict  delegate:self];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:[dict objectForKey:@"url"]];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
    
    if (self.pendingOperations.downloadsInProgress.count == 0 ) {
        
        [self loadCase];
        [Cookie setCookie:@"update" value:@"s"];
        [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
        [SVProgressHUD showWithStatus:@"更新已完成！" maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
        
    }
    
    
}


- (void)update
{
    alertUpdate = YES;
    
    
    [[Message share] messageAlert:@"更新需要花费一些时间，并且您无法做任何操作， 您确定要更新吗？" delegate:self];
    
}



//- (void)updateData
//{
//    
//    
//    
//    NSString *url = [NSString stringWithFormat:@"%@/api/newsapi/queryTopNNewsList?topn=%d", KHomeUrl, KPageSize];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        [self.dataMArray setArray: responseObject];
//        
//        [tb reloadData];
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        
//        [[Message share] messageAlert:[NSString stringWithFormat:@"网络发生错误， 请刷新重试"]];
//        
//        
//    }];
//    
//    
//    
//}


//  1.  下载json
- (void)updateData
{
    
    
    
    
    [SVProgressHUD showWithStatus:@"正在更新数据..." maskType:SVProgressHUDMaskTypeGradient];
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
    
    
    [[ZHDBData share] deleteAllData];
//    http://115.28.182.9:8080/  api/designerapi/queryProfile/1
    
    NSString *url = [NSString stringWithFormat:@"%@api/designerapi/queryProfile/%@", KHomeUrl, kD_Id];
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.ple.queue", NULL);
    dispatch_async(queue, ^(void) {
        
        if ( [[NetWork shareNetWork] CheckNetwork]) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString: url]];
            NSDictionary *jsonData = [data objectFromJSONData];
            
            
            
            if ( jsonData != nil ) {
                
                
//                if ([[jsonData objectForKey:@"status"] intValue] == 100) {
                
                    ZHPassDataJSON *passData = [ZHPassDataJSON share];
                    passData.delegate = self;
                
                
                    [passData jsonToDB:jsonData ];
//                }
            }
            else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    [[Message share] messageAlert:@"服务器错误发生！"];
                    
                });
                
            }
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                [[Message share] messageAlert:@"更新必须联网，请检查是否连接到了网络！"];
                
            });
            
            
            
        }
    });
    
    
    
}





@end
