//
//  M2_BaseViewController.h
//  Designer
//
//  Created by bejoy on 14/7/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M2_BaseViewController : UIViewController



@property(nonatomic, strong) NSMutableArray *dataMArray;
@property(nonatomic, strong) NSMutableDictionary *dataMDict;

- (void)addBackButtion;
- (void)back:(UIButton *)button;

@end
