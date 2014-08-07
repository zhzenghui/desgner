//
//  Customer.h
//  Designer
//
//  Created by bejoy on 14/6/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Customer : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSString * customer_id;
@property (nonatomic, retain) NSString * dgn_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) Note *relationship;

@end
