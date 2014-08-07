//
//  Note.h
//  Designer
//
//  Created by bejoy on 14/6/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSString * cstm_id;
@property (nonatomic, retain) NSString * note_id;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSNumber * photoNum;


@end
