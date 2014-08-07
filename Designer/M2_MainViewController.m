//
//  M2_MainViewController.m
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_MainViewController.h"
#import "ZHViewController.h"
#import "BejoyViewController.h"
#import "M2_PaintViewController.h"
#import "M2_BaseViewController.h"
#import "M2_DesignerViewController.h"
#import "M2_CasesViewController.h"

#import "ZHCustomerViewController.h"


#define KMenuRectOpen RectMake2x(0, 1127, 2048, 410);
#define KMenuRectClose RectMake2x(0, 1456, 2048, 410);

@interface M2_MainViewController ()

@end

@implementation M2_MainViewController

#pragma mark - action


- (void)openCustomerViewController
{
    
    ZHCustomerViewController *pdfVC = [[ZHCustomerViewController alloc] initWithNibName:@"ZHCustomerViewController" bundle:nil];
    pdfVC.view.alpha  = 0 ;
    [UIView animateWithDuration:KLongDuration animations:^{
        pdfVC.view.alpha  = 1 ;
    }];
    
    [self.view addSubview:pdfVC.view];
    [self addChildViewController:pdfVC];
    
}


- (IBAction)openViewController:(UIButton *)button {
    
    
    M2_BaseViewController *vc = nil;
    
    switch (button.tag ) {
        case 1:
        {
            vc = [[M2_DesignerViewController alloc] initWithNibName:@"M2_DesignerViewController" bundle:nil];
            break;
        }
        case 2:
        {
            
            vc = [[M2_CasesViewController alloc] initWithNibName:@"M2_CasesViewController" bundle:nil];

            break;
        }
        case 3:
        {
            vc = [[M2_PaintViewController alloc] initWithNibName:@"M2_PaintViewController" bundle:nil];

            break;
        }
        case 4:
        {
            [self openCustomerViewController];
            return;
            break;
        }
        default:
            break;
    }
    
    
    vc.view.alpha  = 0 ;
    [UIView animateWithDuration:KLongDuration animations:^{
        vc.view.alpha  = 1 ;
    }];
    
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    
}

- (IBAction)update:(UIButton *)button
{
    
    ZHViewController *vc = [[ZHViewController alloc] init];
    [self addChildViewController:vc];
    
    [vc update];
    
}

- (IBAction)openBejoy:(UIButton *)button
{
    
    BejoyViewController *    bv = [[BejoyViewController alloc] init];
    
    
    
    
    bv.view.alpha  = 0;
    [self.view addSubview:bv.view];
    [self addChildViewController:bv];
    
    [UIView animateWithDuration:KMiddleDuration animations:^{
        bv.view.alpha  = 1;
    }];
}



#pragma mark - animation 

- (void)titlePageAnimation {
    
    [UIView animateWithDuration:kLongLongDuration animations:^{
       
        self.avatarImageView.alpha = 1;

    
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:KLongDuration animations:^{
               
                
                self.zhengImageView.alpha = 1;
                
                
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:kLongLongDuration animations:^{
                        
                        self.titlePageView.alpha = 0;
                        
                    } completion:^(BOOL finished) {
                        [self mainAnimation];
                    }];

                }
            }];
            
        }
    }];
    
}


- (void)mainAnimation
{

    [UIView animateWithDuration:KLongDuration animations:^{
        self.menuView.frame = KMenuRectClose;
    }];
    
    
}



#pragma mark - view cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.mainScrollView addSubview:self.mainView];
    [self.mainScrollView setContentSize:self.mainView.frame.size];
    
    
    
    [self.casesScrollView addSubview:self.casesView];
    [self.casesScrollView setContentSize:self.casesView.frame.size];
    
    
    
//     menu
    self.menuView.frame = KMenuRectOpen;
    [self.view addSubview:self.menuView];

    
    
    [self.view addSubview:self.titlePageView];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self titlePageAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:KMiddleDuration animations:^{
        self.menuView.frame = KMenuRectClose;
    }];
    
    self.ren2ImageView.alpha = floor(scrollView.contentOffset.x/102.4)/10;
    self.ren1ImageView.alpha = 1-(floor(scrollView.contentOffset.x/102.4)/10);
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
