//
//  Theme.m
//  Designer
//
//  Created by bejoy on 14-3-24.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "Plist.h"


static Plist *theme;

@implementation Plist


NSDictionary *themeDict;

- (id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}




+ (id)share:(NSString *)name
{
    if (theme) {
        return theme;
    }
    theme = [[Plist alloc] init];

    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
    
    themeDict = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    return theme;
}



- (NSString *)getValueForKey:(NSString *)keyString;
{
    
    NSString *string = [themeDict objectForKey:keyString];
    
    return string;
}



@end
