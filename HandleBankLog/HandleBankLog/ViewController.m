//
//  ViewController.m
//  HandleBankLog
//
//  Created by sfwan on 14-11-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *directory = @"/Users/wanshaofa/Desktop/sfwan/documents/App文档/切图/银行LogoCode";
    NSString *saveDirectory = @"/Users/wanshaofa/Desktop/FinancialManage/FinancialManage/Images.xcassets/Product/ProductCenter/bank_icon";
//    NSString *saveDirectory = @"/Users/wanshaofa/Desktop/javaScript/iOS";
    
    NSString *subDirectory = [NSString stringWithFormat:@"%@.imageset", @"fileName"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *array = [fm directoryContentsAtPath:directory];
    
    for (NSString *fileName in array) {
        
        if (![fileName hasSuffix:@"@2x.png"] && [fileName hasSuffix:@"png"]) {
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", directory, fileName];
            NSString *str = [fileName substringWithRange:NSMakeRange(0, fileName.length - 4)];
            NSString *subDirectory = [NSString stringWithFormat:@"%@/%@.imageset", saveDirectory, str];
            [fm createDirectoryAtPath:subDirectory attributes:nil];
            
            NSString *newImgPath = [NSString stringWithFormat:@"%@/%@@2x.png", subDirectory, str];
            [fm copyItemAtPath:filePath toPath:newImgPath error:nil];
            
            NSString *newJsonPath = [NSString stringWithFormat:@"%@/Contents.json", subDirectory];
            NSString *jsonStr = [self jsonStr:[NSString stringWithFormat:@"%@@2x.png", str]];
            [jsonStr writeToFile:newJsonPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }
    
}

-(NSString *)jsonStr:(NSString *)fileName
{
    NSString *jsonStr = [NSString stringWithFormat:@"{\n"
                         "\"images\" : [\n"
                         "{\n"
                         "\"idiom\" : \"universal\",\n"
                         "\"scale\" : \"1x\"\n"
                         "},\n"
                         "{\n"
                         "\"idiom\" : \"universal\",\n"
                         "\"scale\" : \"2x\",\n"
                         "\"filename\" : \"%@\"\n"
                         "},\n"
                         "{\n"
                         "\"idiom\" : \"universal\",\n"
                         "\"scale\" : \"3x\"\n"
                         "}\n"
                         "],\n"
                         "\"info\" : {\n"
                         "\"version\" : 1,\n"
                         "\"author\" : \"xcode\"\n"
                         "}\n"
                         "}", fileName];
    
    return jsonStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
