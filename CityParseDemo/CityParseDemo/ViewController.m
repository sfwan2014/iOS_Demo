//
//  ViewController.m
//  CityParseDemo
//
//  Created by sfwan on 14-9-12.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ViewController.h"
#import "ChineseToPinyin.h"
#import "XMLReader.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self handleBank];
    [self handleCity];
}

-(void)handleCity{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city.xml" ofType:nil];
    NSString *bankStr = [[NSString alloc] initWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    
    //XML文本范例
    NSString *testXMLString = bankStr;//@"Cake0.55RegularChocolateBlueberryNoneGlazedSugar";
    
    //    NSLog(@"xml string[\n%@\n]", testXMLString);
    // 解析XML为NSDictionary
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    // 打印 NSDictionary
    //    NSLog(@"%@", xmlDictionary);
    
    NSDictionary *data = xmlDictionary[@"data"];
    NSArray *rows = data[@"row"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in rows) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
//        NSDictionary *org_industry = dict[@"org_industry"];
//        NSString *text = org_industry[@"text"];
//        if ([text integerValue] != 1) {
//            continue;
//        }
        
        NSString *city = dict[@"city"][@"text"];
        NSString *code = dict[@"code"][@"text"];
        NSString *province = dict[@"province"][@"text"];
        NSString *pinyin = dict[@"pinyin"][@"text"];
//        NSString *county = dict[@"county"][@"text"];
        
        [dic setObject:city forKey:@"content"];
        [dic setObject:code forKey:@"code"];
        [dic setObject:province forKey:@"province"];
        [dic setObject:pinyin forKey:@"pinyin"];
        [dic setObject:@"China" forKey:@"county"];
        
        [dic setObject:@"city" forKey:@"type"];
        [dic setObject:@NO forKey:@"status"];
//        [dic setObject:text forKey:@"org_industry"];
        [arr addObject:dic];
    }
    
    [arr sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSString *cityName1 = obj1[@"pinyin"];
        NSString *cityName2 = obj2[@"pinyin"];
        NSComparisonResult result = [cityName1 compare:cityName2];
        
        return result;
    }];
    
    NSMutableDictionary *outDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in arr) {
        
        NSString *pinyin = dic[@"pinyin"];
        NSString *firstWord = [[pinyin substringToIndex:1] capitalizedString];
        NSMutableArray *inArray = [outDic objectForKey:firstWord];
        if (inArray == nil) {
            inArray = [NSMutableArray array];
            [outDic setObject:inArray forKey:firstWord];
        }
        [inArray addObject:dic];
    }
    
    NSString *savePath= [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), @"CityList.plist"];
    [outDic writeToFile:savePath atomically:YES];
    //NSDictionary转换为Data
    //    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:xmlDictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
}

-(void)handleBank{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"bank.xml" ofType:nil];
    NSString *bankStr = [[NSString alloc] initWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    
    //XML文本范例
    NSString *testXMLString = bankStr;//@"Cake0.55RegularChocolateBlueberryNoneGlazedSugar";
    
//    NSLog(@"xml string[\n%@\n]", testXMLString);
    // 解析XML为NSDictionary
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    // 打印 NSDictionary
//    NSLog(@"%@", xmlDictionary);
    
    NSDictionary *data = xmlDictionary[@"data"];
    NSArray *rows = data[@"row"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in rows) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSDictionary *org_industry = dict[@"org_industry"];
        NSString *text = org_industry[@"text"];
        if ([text integerValue] != 1) {
            continue;
        }
        
        NSString *bank = dict[@"org_name_short"][@"text"];
        NSString *code = dict[@"CODE"][@"text"];
        NSString *name_short_pinyin = dict[@"name_short_pinyin"][@"text"];
        [dic setObject:bank forKey:@"content"];
        [dic setObject:code forKey:@"code"];
        [dic setObject:name_short_pinyin forKey:@"pinyin"];
        [dic setObject:@"bank" forKey:@"type"];
        [dic setObject:@NO forKey:@"status"];
        [dic setObject:text forKey:@"org_industry"];
        [arr addObject:dic];
    }
    
    [arr sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSString *cityName1 = obj1[@"pinyin"];
        NSString *cityName2 = obj2[@"pinyin"];
        NSComparisonResult result = [cityName1 compare:cityName2];
        
        return result;
    }];

    NSMutableDictionary *outDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in arr) {

        NSString *pinyin = dic[@"pinyin"];
        NSString *firstWord = [pinyin substringToIndex:1];
        NSMutableArray *inArray = [outDic objectForKey:firstWord];
        if (inArray == nil) {
            inArray = [NSMutableArray array];
            [outDic setObject:inArray forKey:firstWord];
        }
        [inArray addObject:dic];
    }
    
    NSString *savePath= [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), @"BankList.plist"];
    [outDic writeToFile:savePath atomically:YES];
    //NSDictionary转换为Data
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:xmlDictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
}

-(void)handleBank1
{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"bankList.js" ofType:nil];
    NSString *bankStr = [[NSString alloc] initWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *banks = [bankStr componentsSeparatedByString:@"\n"];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < banks.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *bank = banks[i];
        NSString *code = [NSString stringWithFormat:@"%d",100000001+i];
        [dic setObject:bank forKey:@"content"];
        [dic setObject:code forKey:@"code"];
        [dic setObject:@"bank" forKey:@"type"];
        [dic setObject:@NO forKey:@"status"];
        [arr addObject:dic];
    }
    
    [arr sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSString *cityName1 = obj1[@"content"];
        NSString *cityName2 = obj2[@"content"];
        cityName1 = [ChineseToPinyin pinyinFromChineseString:cityName1];
        cityName2 = [ChineseToPinyin pinyinFromChineseString:cityName2];
        NSComparisonResult result = [cityName1 compare:cityName2];
        
        return result;
    }];
    
    NSMutableDictionary *outDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in arr) {
        NSString *bankName = dic[@"content"];
        NSString *pinyin = [ChineseToPinyin pinyinFromChineseString:bankName];
        NSString *firstWord = [pinyin substringToIndex:1];
        NSMutableArray *inArray = [outDic objectForKey:firstWord];
        if (inArray == nil) {
            inArray = [NSMutableArray array];
            [outDic setObject:inArray forKey:firstWord];
        }
        [inArray addObject:dic];
    }
    
    NSString *savePath= [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), @"BankList.plist"];
    [outDic writeToFile:savePath atomically:YES];
}

-(void)handleCity2
{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city.js" ofType:nil];
    NSString *cityStr = [[NSString alloc] initWithContentsOfFile:resourcePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *citys = [cityStr componentsSeparatedByString:@"\n"];
    NSLog(@"%@", citys);
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *city in citys) {
        NSArray *array = [city componentsSeparatedByString:@"="];
        if (array.count < 2) {
            continue;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *code = array[0];
        NSString *cityName = array[1];
        [dic setObject:code forKey:@"code"];
        [dic setObject:cityName forKey:@"content"];
        [dic setObject:@NO forKey:@"status"];
        [dic setObject:@"city" forKey:@"type"];
        [arr addObject:dic];
    }
    
    [arr sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        NSString *cityName1 = obj1[@"content"];
        NSString *cityName2 = obj2[@"content"];
        cityName1 = [ChineseToPinyin pinyinFromChineseString:cityName1];
        cityName2 = [ChineseToPinyin pinyinFromChineseString:cityName2];
        NSComparisonResult result = [cityName1 compare:cityName2];
        
        return result;
    }];
    
    //[ {A : [{},{}]}, {B:[{},{}]} ]
    NSMutableDictionary *outDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in arr) {
        NSString *cityName = dic[@"content"];
        NSString *pinyin = [ChineseToPinyin pinyinFromChineseString:cityName];
        NSString *firstWord = [pinyin substringToIndex:1];
        NSMutableArray *inArray = [outDic objectForKey:firstWord];
        if (inArray == nil) {
            inArray = [NSMutableArray array];
            [outDic setObject:inArray forKey:firstWord];
        }
        [inArray addObject:dic];
    }
    
    NSString *savePath= [NSString stringWithFormat:@"%@/tmp/%@", NSHomeDirectory(), @"city.plist"];
    [outDic writeToFile:savePath atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
