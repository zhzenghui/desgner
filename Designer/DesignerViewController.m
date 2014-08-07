//
//  DesignerViewController.m
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "DesignerViewController.h"
#import "PdfPopoverController.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"

#define ImageLeftCount 3
#define ImageRightCount 3


@interface DesignerViewController ()
{
    UILabel *titleLabel;
    UILabel *contentLabel;
    
    UIButton *_button;
    UIScrollView *infoSV;
    
    
    UIView *leftView;

    
    
    UIImageView *leftImageView;
    UIImageView *leftImageView1;
    UIImageView *rightImageView;
    UIImageView *rightImageView1;
    
    
    int imageLeftCount;
    int imageRightCount;
    
    
    NSArray *leftImageNameArray;
    NSArray *rightImageNameArray;
    
    

}
@end

@implementation DesignerViewController

//
//- (void)back:(UIButton *)button
//{
//    
//    
//    [UIView animateWithDuration:KMiddleDuration animations:^{
//        self.view.alpha  = 0;
//    }];
//    
//    
//    
//}

- (void)openPDFListView:(UIButton *)button
{
    PdfPopoverController *pdfVC = [[PdfPopoverController alloc] init];
    pdfVC.viewController = self;
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:pdfVC];
    pdfVC.popController = _popover;
    if (iOS7) {
        _popover.backgroundColor = [UIColor clearColor];        
    }


    
    [_popover presentPopoverFromRect:_button.bounds inView:_button
            permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
    [super loadView];
    

//    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"理念-bg-photo1@2x"]];
//    iv.frame = RectMake2x(110, 190, 1938, 1346);
//    
//    [self.view addSubview:iv];
    
//    SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:@"title1" image:[UIImage imageNamed:@"理念-bg-photo1@2x"] tag:0];
//    SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithTitle:@"title2" image:[UIImage imageNamed:@"理念-bg-photo2@2x"] tag:1];
//    SGFocusImageItem *item3 = [[SGFocusImageItem alloc] initWithTitle:@"title3" image:[UIImage imageNamed:@"理念-bg-photo3@2x"] tag:2];
//    SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:RectMake2x(110, 190, 1938, 1346)
//                                                                    delegate:self
//                                                             focusImageItems:item1, item2, item3, nil];
//    [self.view addSubview:imageFrame];
     leftImageNameArray = @[@"理念-bg-photo1", @"理念-bg-photo2", @"理念-bg-photo3"];

    
    
    leftView = [[UIView alloc] init];
    leftView.frame = RectMake2x(110, 190, 1938, 1346);
    [self.view addSubview:leftView];
    
    
    
    leftImageView = [[ImageView share] addToView:leftView imagePathName:[leftImageNameArray objectAtIndex:0] rect:RectMake2x(0, 0, 1938, 1346)];
    leftImageView1 = [[ImageView share] addToView:leftView imagePathName:[leftImageNameArray objectAtIndex:0] rect:RectMake2x(0, 0, 1938, 1346)];
    leftImageView1.alpha = 0;

    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    titleLabel.frame = RectMake2x(1229, 292, 500, 88);

    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    

    
    
    infoSV = [[UIScrollView alloc] initWithFrame:RectMake2x(1233, 422, 736, 1028)];
    
    contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.frame = RectMake2x(0, 0, 736, 1028);
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    [infoSV addSubview:contentLabel];
    
    [self.view addSubview:infoSV];
    

    
    

}



- (void)handleTimerLeft
{
    if (imageLeftCount == 0) {
        imageLeftCount = ImageLeftCount;
    }
    
    imageLeftCount--;
    
    
    
    
    if (imageRightCount == 0) {
        imageRightCount = ImageRightCount;
        
    }
    
    imageRightCount--;
    
    if (leftImageView.alpha == 1) {
        leftImageView1.image = [UIImage imageNamed:[leftImageNameArray objectAtIndex:imageLeftCount]];
        
        [UIView animateWithDuration:KLongDuration animations:^{
            leftImageView.alpha = 0;
            leftImageView1.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [leftView exchangeSubviewAtIndex:rightImageView.layer.zPosition withSubviewAtIndex:rightImageView1.layer.zPosition];
            }
        }];
        
    }
    else {
        leftImageView.image = [UIImage imageNamed:[leftImageNameArray objectAtIndex:imageLeftCount]];
        [UIView animateWithDuration:KLongDuration animations:^{
            leftImageView.alpha = 1;
            leftImageView1.alpha = 0;
        }completion:^(BOOL finished) {
            if (finished) {
                [leftView exchangeSubviewAtIndex:leftImageView.layer.zPosition withSubviewAtIndex:leftImageView1.layer.zPosition];
            }
        }];
    }
    
}



- (void)loadData{
    
    NSDictionary *designerDict = [[ZHDBData share] getDesignerForD_Id:kD_Id];
    titleLabel.text = designerDict[@"real_name"];
    contentLabel.text = designerDict[@"introduction"];
    
    NSString *intro = designerDict[@"introduction"];
    
    CGSize lSize = [intro sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(736/2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    contentLabel.frame = RectMake2x(0, 0, 736, lSize.height*2);

    [infoSV setContentSize:CGSizeMake(736/2, lSize.height)];
    

    
    
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];

        [self addMemu];
    [self addBackView];
    NSString *str = @"按钮-文件";
    int yHeight = 190/2;
//    int y = 130/2;
    
    int i = 1;
    
    NSString *imgNormal = [NSString stringWithFormat:@"%@-0", str ];
    NSString *imgSelect = [NSString stringWithFormat:@"%@-1", str ];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, yHeight , 110/2, 130/2);
    _button.tag = i;
    [_button addTarget:self action:@selector(openPDFListView:) forControlEvents:UIControlEventTouchUpInside];
    [_button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_button];

    
    
    
    NSString *s = [[Theme share] getValueForKey:@"designer_imageCount"];
    
    if ([s isEqualToString:@"1"]) {
        
    }
    else {
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleTimerLeft)  userInfo:nil  repeats: YES];        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
