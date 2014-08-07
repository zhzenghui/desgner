//
//  ZHAppDelegate.m
//  Designer
//
//  Created by bejoy on 14-3-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ZHAppDelegate.h"
#import "ZHViewController.h"
#import "ZHMainViewController.h"
#import "M2_MainViewController.h"

#import "Theme.h"
#import "Customer.h"

#import <iflyMSC/IFlySetting.h>


@implementation ZHAppDelegate


- (void)createPhotoDir
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *writableDBPath = [KDocumentDirectory stringByAppendingPathComponent:@"photo"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;

    success = [fileManager createDirectoryAtPath:writableDBPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (success) {
        DLog(@"create photo dir sucess");
    }
    
}
- (void)copyPhotoDir
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success;

    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data/photo"];
   
    success = [fileManager fileExistsAtPath:KDocumentDirectoryPhoto];
    if (success) return;
    
    NSString *writePath =  KDocumentDirectoryPhoto;
    
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writePath error:&error];
    if (!success) {
        DLog(@"copy photo dir fails");
    }
}

- (void)copyData
{
    

    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *writableDBPath = [KCachesDirectory stringByAppendingPathComponent:@"files"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data/files"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        
    }
    
    
    
    NSString *writableDBPath1 = [KCachesDirectory stringByAppendingPathComponent:db_name];
    
    NSString *dbPath = [NSString stringWithFormat:@"data/%@", db_name];
    NSString *defaultDBPath1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbPath];
    success = [fileManager copyItemAtPath:defaultDBPath1 toPath:writableDBPath1 error:&error];
    if (!success) {
        
    }
}

- (void)updateBundleId
{
    
    

//    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
//    NSString *bundleid = [NSString stringWithFormat:@"com.i-bejoy.%@",  [UserSettingInfo share]];
//    
//    NSMutableDictionary *themeDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pathStr];
//    
//    
//    
//    [themeDict setObject:bundleid forKey:@"CFBundleIdentifier"];
//    
//    [themeDict writeToFile:pathStr atomically:YES];
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.以来
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [IFlySetting setLogFile:LVL_ALL];
    [IFlySetting showLogcat:YES];
    [IFlySetting getVersion];

    
    [self copyData];
    [self copyPhotoDir];
    
    [self updateBundleId];
//    笔记的模型
//    [MagicalRecord setupCoreDataStackWithStoreNamed:@"NoteModel"];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    
    
    if ( ! iOS7) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    
    

    UIViewController *vc ;
    int  themeID =  [[[Theme share]  getValueForKey:@"them_id"] intValue];
    switch (themeID) {
        case 0:
        {
           vc = [[ZHViewController alloc] init];
            break;
        }
        case 1:
        {
            vc = [[ZHMainViewController alloc] init];
            break;
        }
        case 2:
        {
            vc = [[M2_MainViewController alloc] initWithNibName:@"M2_MainViewController" bundle:nil];
            break;
        }
        default:
            break;
    }


    self.user = [[User alloc] init];
    
    SharedAppUser.ID  = 182891112;
    SharedAppUser.account = @"desg_name";
    SharedAppUser.name = @"昵称称";
    
    
    
    
    // Override point for customization after application launch.
    //[IFlySetting setLogFile:LVL_DETAIL];
    //[IFlySetting showLogcat:YES];
    
    
    

    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
