//
//  AppDelegate.m
//  NewCity
//
//  Created by shaofa on 1/11/14.
//  Copyright (c) 2014 shaofa. All rights reserved.
//

#define   ZIMU @"P"
#define ZI @"浦江"
#import "AppDelegate.h"

#import "ChineseToPinyin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSString *path = [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents/newCity.plist"];
    NSDictionary  *dic  =[NSDictionary  dictionaryWithContentsOfFile:path];
//    NSString  *a = @"我是中国人";
//    NSString  *b=@"我是哈";
//    for (int i = 0; i < a.length; i ++) {
//        char  achar = [a  characterAtIndex:i];
//        for (int j = 0; j < b.length; j ++)
//        {
//            char  bchar = [b  characterAtIndex:j];
//            if (achar  == bchar) {
//                NSLog(@"yesyes");
//            }else
//            {
//                NSLog(@"nono");
//            }
//        }
//    }
//    for (int i = 0; i < ZI.length; i ++)
//    {
//        NSLog(@"%c",pinyinFirstLetter([ZI  characterAtIndex:i]));
//    }
    NSArray  *dicAr = [dic  objectForKey:ZIMU];
    int   i;
    for (i = 0; i < dicAr.count; i ++) {
        NSString  *name = dicAr[i][0];
       
        char  nameChar = [name  characterAtIndex:0];
        char  ziChar  =[ZI  characterAtIndex:0];
        if (nameChar == ziChar)
        {
            NSString  *ziStr = [ChineseToPinyin  pinyinFromChiniseString:ZI];
            NSString  *nameStr = [ChineseToPinyin  pinyinFromChiniseString:name];
//            if (ziStr  ) {
//                <#statements#>
//            }
            if ([ziStr caseInsensitiveCompare:nameStr] <= 0) {
                NSLog(@"应该在%d之前",i);
                NSLog(@"%@",name);
                break;
            }        }
    }
    if (i ==dicAr.count  ) {
        for ( i = 0; i < dicAr.count; i ++) {
            NSString  *name = dicAr[i][0];
            
            NSString  *ziStr = [ZI  substringToIndex:1];
            ziStr = [ChineseToPinyin  pinyinFromChiniseString:ziStr];
            //NSLog(@"%@",ziStr);
            NSString  *nameStr = [name  substringToIndex:1];
            nameStr = [ChineseToPinyin  pinyinFromChiniseString:nameStr];
          //  NSLog(@"%@",[ChineseToPinyin  pinyinFromChiniseString:nameStr]);
            if ([ziStr caseInsensitiveCompare:nameStr] == 0) {
//                NSLog(@"%d",i);
//                NSLog(@"%@",name);
                NSRange  range =  NSMakeRange(1, 1);
                NSString  *ziStr2  = [ZI  substringWithRange:range];
                NSLog(@"%@",ziStr2);
                ziStr2 = [ChineseToPinyin  pinyinFromChiniseString:ziStr2];
               
                NSString  *nameStr2 = [name  substringWithRange:range];
                nameStr2 = [ChineseToPinyin  pinyinFromChiniseString:nameStr2];
               // if ([ziStr2  caseInsensitiveCompare:nameStr2] <= 0) {
                    NSLog(@"%d",i);
                    NSLog(@"%@",name);
                //}
                break;
            }
            
        }
    }
//    NSString  *engStr = @"hehaha";
//    NSString  *engStr2 = @"ha";
//    NSLog(@"%d",[engStr  caseInsensitiveCompare:engStr2]);
//    NSRange
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
