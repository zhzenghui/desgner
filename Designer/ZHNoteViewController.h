//
//  ZHNoteViewController.h
//  Designer
//
//  Created by bejoy on 14/6/26.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "NoteBaseViewController.h"
#import "Note.h"

@class Customer;
@interface ZHNoteViewController : NoteBaseViewController
{
    UITextField *nameTF;
    UITextField *phoneTF;
    UITextField *telephoneTF;
    UITextView *addressTV;
    
    
    
    UILabel *customerLable;
    
    
    
    UIButton *newCustomerButton;
    UIButton *trashButton;
    
    UITableView *tb;
    
    UIImageView *space;

}

@property (nonatomic, retain) NSNumber *customer_id;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, assign) int type;

@property(nonatomic, retain) IBOutlet UIImageView *pageAnimotionImageView;


@end
