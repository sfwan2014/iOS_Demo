//
//  HeadView.m
//  tableViewbugDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView.backgroundColor = [UIColor yellowColor];
        self.tintColor = [UIColor orangeColor];
        self.contentView.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
