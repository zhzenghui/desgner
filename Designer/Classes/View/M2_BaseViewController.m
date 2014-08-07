//
//  M2_BaseViewController.m
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_BaseViewController.h"

@interface M2_BaseViewController ()

@end

@implementation M2_BaseViewController


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

- (void)addBackButtion {

    [[Button share] addToView:self.view addTarget:self rect:RectMake2x(1888, 120 , 100, 100) tag:1001 action:@selector(back:) imagePath:@"按钮-返回-rigth-top@2x"];

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadData {
    self.dataMArray = [[NSMutableArray alloc] init];
    self.dataMDict = [[NSMutableDictionary alloc] init];
    
}

- (void)loadView {
    [super loadView];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
