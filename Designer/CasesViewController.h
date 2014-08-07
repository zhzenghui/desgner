//
//  CasesViewController.h
//  Designer
//
//  Created by bejoy on 14-3-4.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "BaseViewController.h"

@interface CasesViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    UITableView *tb;
    

    NSMutableArray *tagsArray;
}




@end
