//
//  NoteBaseViewController.m
//  Designer
//
//  Created by bejoy on 14/7/1.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NoteBaseViewController.h"

@interface NoteBaseViewController ()

@end

@implementation NoteBaseViewController

- (void)back:(UIButton *)button
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

- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"笔记-bgall-00"]];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
