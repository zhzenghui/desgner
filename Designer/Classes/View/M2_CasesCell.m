//
//  M2_CasesCell.m
//  Designer
//
//  Created by bejoy on 14/7/31.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "M2_CasesCell.h"

@implementation M2_CasesCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imgView1 = [[UIImageView alloc]  initWithFrame:RectMake2x(10, 10, 600, 450)];
        self.imgView1.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView1.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.imgView1];
        
        [[ImageView share] addToView:self.contentView imagePathName:@"双子-郭正作品-画框" rect:CGRectMake(0, 0, 620/2, 470/2)];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:RectMake2x(39, 398, 522, 35)];
        self.titleLabel.textColor = [UIColor whiteColor];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.titleLabel];
        
        
    }
    return self;
}


- (void)setDict:(NSDictionary *)dict
{
    if (_dict != dict) {
        _dict = dict;
    }

    NSString *nameString1 = [NSString stringWithFormat:@"%@", [dict objectForKey:@"p_name"]];
    NSString *name = [[nameString1 componentsSeparatedByString:@"."] firstObject];
    
    NSString *fileName = [NSString stringWithFormat:@"%@600x500.jpg", name];
    
    UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:KCachesName(fileName)];
    self.imgView1.image = img1;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",  dict[@"a_name"]];

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
