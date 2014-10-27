//
//  AppDelegate.m
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
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



//http://www.oauth.net/2/state=1212#access_token=61026055d2a601d83896b9ed59f1c595909e134333b045d1858718825&token_type=Bearer&expires_in=86400&refresh_token=61014055e0a21163c327eae947e71da41e895db836dd7561858718825&re_expires_in=2592000&r1_expires_in=86400&r2_expires_in=86400&taobao_user_id=1858718825&taobao_user_nick=%E4%BD%A0%E5%9C%9F%E8%B1%AA%E9%87%91%E6%8E%89%E4%BA%86&w1_expires_in=86400&w2_expires_in=1800&state=&top_sign=6DFADD13F9FF8B27BDD43D7CE5F669AD
