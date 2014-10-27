//
//  CustomGroupCell.m
//  CustomGroupTableView
//
//  Created by sfwan on 14-10-11.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomGroupCell.h"
#import "CustomViewOne.h"
@interface CustomGroupCell()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation CustomGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self _initViews];
}

-(void)_initViews
{
    _backView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _backView.layer.borderWidth = 1.0;
    _backView.layer.cornerRadius = 4.0;
}

-(void)setStyle:(kCellStyle)style
{
    _style = style;
    
    [self resetSubViews];
}

-(void)resetSubViews
{
    NSString *nibName = nil;
    switch (_style) {
        case kCellStyleA:
        {
            nibName = @"CustomViewOne";
        }
            break;
        case kCellStyleB:
        {
            nibName = @"CustomViewTwo";
        }
            break;
        case kCellStyleC:
        {
            nibName = @"CustomViewThree";
        }
            break;
        case kCellStyleD:
        {
            nibName = @"CustomViewThree";
        }
            break;
        case kCellStyleE:
        {
            nibName = @"CustomViewThree";
        }
            break;
            
        default:
            break;
    }
    if (nibName == nil) {
        return;
    }
    for (UIView *view in _backView.subviews) {
        [view removeFromSuperview];
    }
    
    BaseView *view = [NSClassFromString(nibName) loadFormXib];
    [_backView addSubview:view];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _backView.frame = CGRectMake(4, 4, self.frame.size.width-8, self.frame.size.height-8);
}

@end
