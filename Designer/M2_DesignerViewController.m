//
//  M2_DesignerViewController.m
//  Designer
//
//  Created by bejoy on 14/7/31.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_DesignerViewController.h"
#import "WebViewController.h"


#define KMenuRectOpen RectMake2x(0, 1127, 2048, 410);
#define KMenuRectClose RectMake2x(0, 1456, 2048, 410);


@interface M2_DesignerViewController ()
{
    NSMutableArray *fileArrayM;
}
@end

@implementation M2_DesignerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadData {
    fileArrayM = [[ZHDBData share] getFilesForD_Id:kD_Id];

}

- (void)loadPdf {
    
    
    int i = 0;
    
    int y = 508;
    
    
    CGRect r = RectMake2x(0, 0, 490, 298);
    
    for ( NSDictionary *dict in fileArrayM) {
        r = RectMake2x(0+y*i, 0, 490, 298);
        i ++;
        
        [[ImageView share] addToView:self.pdfScrollView imagePathName:@"双子-郭正pdf-bg" rect:r];
        
        UIButton *b = [[Button share] addToView:self.pdfScrollView addTarget:self rect:r tag:i action:@selector(openPdfView:)];
        [b setTitle:dict[@"show_name"]  forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        b.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

        b.titleLabel.numberOfLines = 0;
    }
    
    [self.pdfScrollView setContentSize:CGSizeMake((y/2)*fileArrayM.count, 298/2)];
}

- (void)loadView {
    [super loadView];
    

    
    
    //     menu
    self.menuView.frame = KMenuRectClose;
    [self.view addSubview:self.menuView];
    [self addBackButtion];

    [self loadData];

    [self loadPdf];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (IBAction)openPdfView:(UIButton *)sender {

    
    NSDictionary *dict = [fileArrayM objectAtIndex:sender.tag - 1];
    
    
    NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict objectForKey:@"show_name"]];
    
    NSLog(@"%@", KCachesDirectory);
    NSLog(@"%@", KCachesDirectoryFiles);
    NSLog(@"%@", KCachesName(@""));
    NSLog(@"%@", KCachesName(nameString3)) ;
    NSString *urlString = KCachesName(nameString3);
    
    NSURL *url = [NSURL URLWithString:urlString];


    url = [[NSURL alloc] initFileURLWithPath:urlString];
    
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = url;
    
    webVC.view.alpha  = 0;
    [self.view addSubview:webVC.view];
    [self addChildViewController:webVC];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        webVC.view.alpha  = 1;
    }];

}

- (IBAction)openCloseMenu:(UIButton *)sender {

    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        
        if (self.menuView.frame.origin.y == 1456/2) {
            self.menuView.frame = KMenuRectOpen;
            sender.selected = YES;
        }
        else {
            self.menuView.frame = KMenuRectClose;
            sender.selected = NO;
        }
        
    }];
}

@end
