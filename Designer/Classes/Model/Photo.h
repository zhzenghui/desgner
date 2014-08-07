//
//  Photo.h
//  Designer
//
//  Created by bejoy on 14/6/30.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * create_time;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note_id;
@property (nonatomic, retain) NSString * photo_id;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSDate * update_time;
@property (nonatomic, retain) NSString * stroe_name;
@property (nonatomic, retain) Note *relationship;

@end
