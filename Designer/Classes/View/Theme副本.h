//
//  Theme.h
//  Designer
//
//  Created by bejoy on 14-3-24.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plist : NSObject

+ (id)share:(NSString *)name;

- (NSString *)getValueForKey:(NSString *)keyString;

@end
