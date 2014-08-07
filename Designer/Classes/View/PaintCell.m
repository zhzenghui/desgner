//
//  PaintCell.m
//  Designer
//
//  Created by bejoy on 14/6/23.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "PaintCell.h"

@implementation PaintCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[ImageView share] addToView:self.contentView imagePathName:@"手绘-cell-bg" rect:CGRectMake(0, 0, 647/2, 419/2)];
        self.imgView1 = [[UIImageView alloc]  initWithFrame:RectMake2x(16, 16, 615, 386)];
        self.imgView1.contentMode = UIViewContentModeScaleAspectFit;

        [self.contentView addSubview:self.imgView1];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)setDict:(NSDictionary *)dict
{
    if (_dict != dict) {
        _dict = dict;
    }
    NSString *imgStr =[NSString stringWithFormat:@"%@", dict[@"store_name"]];
    NSString *name = [[imgStr componentsSeparatedByString:@"."] firstObject];
    NSString *fileName = [NSString stringWithFormat:@"%@895x577.jpg", name];    
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
    
    self.imgView1.image = img;
}



@end
