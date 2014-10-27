//
//  FileCell.m
//  TableViewCellTalk
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "FileCell.h"

@interface FileCell ()
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@end

@implementation FileCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setFilename:(NSString *)filename
{
    _filename = filename;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _fileNameLabel.text = _filename;
}

@end
