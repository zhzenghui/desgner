//
//  PhotoCell.m
//  Designer
//
//  Created by bejoy on 14/7/8.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)init
{
    self = [super init];
    if (self) {

        self.nameLabel.delegate = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setCellType:(PhotoCellType)cellType
{
    if (cellType == PhotoCellTypeNormal) {
        self.button.alpha = 0;
        
    }
    else {
        self.button.alpha = 1;
    }
}

- (IBAction)openText:(id)sender {
    
    [self.nameLabel becomeFirstResponder];
}


- (void)setPhoto:(Photo *)photo
{
    
    NSString *path = KDocumentName(photo.stroe_name);
    
    self.imageView.image = [Image imageForPath:path];
    
    self.nameLabel.text = photo.name;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.view.frame = CGRectMake(0, -150, 1024, 768);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.view.frame = CGRectMake(0, 0, 1024, 768);
}




@end
