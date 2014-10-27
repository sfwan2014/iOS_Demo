//
//  ClientInfoHeadView.m
//  ClientInfoTableViewDemo
//
//  Created by sfwan on 14-7-28.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "ClientInfoHeadView.h"
#import "StarView.h"

@interface ClientInfoHeadView ()
@property (weak, nonatomic) IBOutlet StarView *starView;

@end

@implementation ClientInfoHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _starView.value = 1.2;
}

@end
