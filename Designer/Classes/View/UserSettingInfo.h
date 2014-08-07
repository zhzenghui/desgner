//
//  UserSettingInfo.h
//  Designer
//
//  Created by bejoy on 14-5-19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettingInfo : NSObject


+ (id)share;


- (NSString *)getValueForKey:(NSString *)keyString;

@end
