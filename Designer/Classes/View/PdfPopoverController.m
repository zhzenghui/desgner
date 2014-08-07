//
//  PdfPopoverController.m
//  Designer
//
//  Created by bejoy on 14-3-7.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PdfPopoverController.h"
#import "WebViewController.h"

@interface PdfPopoverController ()
{

    NSMutableArray *fileArrayM ;
    
    UITableView *tb;
    
}
@end

@implementation PdfPopoverController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView
{
    
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
    

    tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, 290, 600-85)];
    
    if ( ! iOS7) {
        tb.frame = CGRectMake(0, 85, 350, 620);
    }
    
    
    tb.backgroundColor = [UIColor clearColor];
    tb.dataSource = self;
    tb.delegate = self;
    
    [self.view addSubview:tb];

}

- (void)loadData
{
    
    
    
    fileArrayM = [[ZHDBData share] getFilesForD_Id:kD_Id];
    
    
    [tb reloadData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"按钮-PDF-bg"]];

    
    

    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.contentSizeForViewInPopover = CGSizeMake(300, 600);
    

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
    
    
    NSDictionary *dict = [fileArrayM objectAtIndex:indexPath.row];
    
    
    NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict objectForKey:@"show_name"]];
    NSURL *url = [NSURL URLWithString:KCachesName(nameString3)];


    
    UIWindow *mWindow = self.view.window;
    
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = url;

    webVC.view.alpha  = 0;
    [mWindow.rootViewController.view addSubview:webVC.view];
    [mWindow.rootViewController addChildViewController:webVC];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        webVC.view.alpha  = 1;
    }];
    
    

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fileArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 130/2;
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell4";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil ) {
        cell =[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];

    }
    
    cell.imageView.image = [UIImage imageNamed:@"按钮-PDF-0"];
 

    NSString *string = fileArrayM[indexPath.row][@"show_name"];
    
    string = [string stringByReplacingOccurrencesOfString:@".pdf" withString:@""];
    cell.textLabel.text = string;
    cell.textLabel.font = [UIFont systemFontOfSize:13];

    return cell;
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    [_popController dismissPopoverAnimated:YES];
    
    
    
    NSDictionary *dict = [fileArrayM objectAtIndex:indexPath.row];
    
    
    NSString *nameString3 = [NSString stringWithFormat:@"%@", [dict objectForKey:@"show_name"]];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:KCachesName(nameString3)];
    
    

    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = url;
    
//    UIWindow *mWindow = self.view.window;

    webVC.view.alpha  = 0;
    [_viewController.view addSubview:webVC.view];
    [_viewController addChildViewController:webVC];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        webVC.view.alpha  = 1;
    }];
    

    
    
    
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        webVC.view.alpha  = 1;
    }];
}



@end
