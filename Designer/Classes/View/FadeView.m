//
//  FadeView.m
//  Designer
//
//  Created by bejoy on 14/6/19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "FadeView.h"

@implementation FadeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        filesArray = [[NSMutableArray alloc]  init];
        current = 0;
    }
    return self;
}

- (void)fade
{


    UIImageView *ivBack = filesArray[current];

    [UIView animateWithDuration:KLongDuration animations:^{

        ivBack.alpha = 0;
    }];

    
    if (current == filesArray.count-1 ) {
        current = 0;
    }
    else {
        current ++;
    }
    
    
    
    UIImageView *iv = filesArray[current];

    [UIView animateWithDuration:KLongDuration animations:^{
        iv.alpha = 1;
    }];

    
}

- (void)startFade{
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:kLongLongDuration target:self selector:@selector(fade) userInfo:nil repeats:YES];
}

- (void)stopFade {
    
    if ([timer isValid]) {
        
        timer = nil;
    }
    
    
}


- (void)setFileNamesArray:(NSArray *)fileNamesArray
{
    if (_fileNamesArray == fileNamesArray) {
        return;
    }
    
    UIImage *img = [UIImage imageNamed:fileNamesArray[0]];
    CGSize size = img.size;
    
    
    if (fileNamesArray.count > 0) {

        for (NSString *fname in fileNamesArray) {
            UIImageView *iv = [[ImageView share] addToView:self imagePathName:fname rect:CGRectMake(0, 0, size.width, size.height )];
            iv.alpha = 0;
            
            [filesArray addObject:iv];
        }
    }
    
    
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
