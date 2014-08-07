//
//  M2_PaintCell.m
//  Designer
//
//  Created by bejoy on 14/7/31.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_PaintCell.h"

@implementation M2_PaintCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[ImageView share] addToView:self.contentView imagePathName:@"双子-郭正艺绘-画框" rect:CGRectMake(0, 0, 651/2, 351/2)];
        self.imgView1 = [[UIImageView alloc]  initWithFrame:RectMake2x(25, 25, 600, 300)];
        self.imgView1.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:self.imgView1];
    }
    return self;
}


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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
