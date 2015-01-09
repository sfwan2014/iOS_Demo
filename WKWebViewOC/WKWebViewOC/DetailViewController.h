//
//  DetailViewController.h
//  WKWebViewOC
//
//  Created by sfwan on 14-12-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

