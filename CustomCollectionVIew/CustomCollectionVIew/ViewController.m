//
//  ViewController.m
//  CustomCollectionVIew
//
//  Created by sfwan on 14-10-13.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ViewController.h"
#import "HorCollectionView.h"
#import "CustomCollectionView.h"
#import "CircleLayout.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CustomCollectionView *collectionView;
@property (nonatomic, strong) HorCollectionView *hCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleLayout *layout = [[CircleLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _hCollectionView = [[HorCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(kItemWidth, 100);
    [self.view addSubview:_hCollectionView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.frame = CGRectMake(0, 20, 320, 153);
    
    _hCollectionView.frame = CGRectMake(0, 20 + 153 + 20, 300, 120);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
