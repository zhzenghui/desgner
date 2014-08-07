//
//  UserSettingInfo.m
//  Designer
//
//  Created by bejoy on 14-5-19.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "UserSettingInfo.h"



static UserSettingInfo *userInfo;

NSDictionary *userDict;


@implementation UserSettingInfo



+ (id)share
{
    if (userInfo) {
        return userInfo;
    }
    userInfo = [[UserSettingInfo alloc] init];
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"];
    
    userDict = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    return userInfo;
}




- (NSString *)getValueForKey:(NSString *)keyString
{
    
    NSString *string = [userDict objectForKey:keyString];
    
    return string;
}


@end
