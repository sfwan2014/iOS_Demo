//
//  QuestionAndAnswerViewController.m
//  LogViewDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "QuestionAndAnswerViewController.h"
#import "QuestionTableView.h"
#import "Tools.h"


@interface QuestionAndAnswerViewController ()
@property (weak, nonatomic) IBOutlet QuestionTableView *tableView;

@end

@implementation QuestionAndAnswerViewController
{
    NSMutableArray *dataArray;
}

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
    
    self.title = @"关联问题";
    
    [self addBackgroundImageViewWithImageName:@"question_background_image.png"];
    
    [self _loadLocationData];
}

#pragma mark - private method
-(void)_initNavgationItems
{
    [self initBackItem];
}

-(void)_loadLocationData
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", resourcePath, @"QuestionList.geojson"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error = nil;
    id jsonValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *problems = jsonValue[@"problem"];

    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in problems) {
        NSString *problem = dic[@"problem"];
        if (problem == nil || [problem isKindOfClass:[NSNull class]]) {
            problem = @"";
        }
        
        NSString *answer = dic[@"answer"];
        if (answer == nil || [answer isKindOfClass:[NSNull class]]) {
            answer = @"";
        }
        
        [array addObject:[NSString stringWithFormat:@"%@%@", kQuestionPrefix, problem]];
        [array addObject:[NSString stringWithFormat:@"%@%@", kAnswerPrefix, answer]];
    }
    
//    dataArray = array;
    
    self.tableView.data = array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
