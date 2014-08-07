//
//  productCCell.m
//  OrientParkson
//
//  Created by i-Bejoy on 14-1-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "CustomerCell.h"
#import "Customer.h"





@implementation CustomerCell
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setType:(CollectionTableType)type
{


    if (type == CollectionTableTypeNormal ) {
        
        self.button.alpha = 0;
    }
    else if (type == CollectionTableTypeDelete)  {
        self.button.alpha = 1;
    }

    
    
}

- (void)setCustomer:(Customer *)customer
{
    self.nameLabel.text = customer.name;
    
    
    
    if (customer.mobile == 0) {
        self.phoneLabel.text = @"";
    }
    else {
        self.phoneLabel.text = [NSString stringWithFormat:@"%@", customer.mobile];
    }

    self.adreeLable.text = customer.adress;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18]};
    CGRect rect = [customer.adress boundingRectWithSize:CGSizeMake(self.adreeLable.frame.size.width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    self.adreeLable.frame = CGRectMake(self.adreeLable.frame.origin.x, self.adreeLable.frame.origin.y, self.adreeLable.frame.size.width, rect.size.height);
    
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
