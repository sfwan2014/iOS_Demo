//
//  TaskProcessCell.m
//  TableViewCellTalk
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "TaskProcessCell.h"
#import "FileCell.h"

#define kFileRowHeight      35
#define kContextLabelWidth     200

#define kSpaceHeight        10
#define kTimeLabelHeight    21

#define kBottomSpace        5

#define kDefaultHeight      58

#define kFontSize           14
#define kContentSpace       50
#define kContentLabelTop    7

@interface TaskProcessCell ()<UITableViewDelegate, UITableViewDataSource>

// self
@property (weak, nonatomic) IBOutlet UIView *selfBackView;
@property (weak, nonatomic) IBOutlet UIImageView *selfHeadProtraitView;
@property (weak, nonatomic) IBOutlet UIView *selfBubbleBackView;
@property (weak, nonatomic) IBOutlet UILabel *selfContentLabel;
@property (weak, nonatomic) IBOutlet UIView *selfLineView;
@property (weak, nonatomic) IBOutlet UIView *selfFileBackView;
@property (weak, nonatomic) IBOutlet UITableView *selfTableView;
@property (weak, nonatomic) IBOutlet UILabel *selfTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *selfNameLabel;

// other
@property (weak, nonatomic) IBOutlet UIView *otherBackView;
@property (weak, nonatomic) IBOutlet UIImageView *otherHeadProtraitView;
@property (weak, nonatomic) IBOutlet UIView *otherBubbleBackView;
@property (weak, nonatomic) IBOutlet UILabel *otherContentLabel;
@property (weak, nonatomic) IBOutlet UIView *otherLineView;
@property (weak, nonatomic) IBOutlet UIView *otherFileBackView;
@property (weak, nonatomic) IBOutlet UITableView *otherTableView;
@property (weak, nonatomic) IBOutlet UIImageView *otherTaskStateView;
@property (weak, nonatomic) IBOutlet UILabel *otherTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherNameLabel;

@end

@implementation TaskProcessCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];    
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    
    [self setNeedsLayout];
}

-(void)_initView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSArray *files = _data[key_files];
    NSString *content = _data[key_content];
    
    _selfBackView.hidden = YES;
    _otherBackView.hidden = YES;
    if ([_data[key_perstate] boolValue]) {// self
        
        _selfBackView.hidden = NO;
        _selfContentLabel.height = [TaskProcessCell cellContentHeightFromText:content withFontSize:kFontSize];
        _selfBubbleBackView.height = [TaskProcessCell cellContentHeightFromFiles:files] + [TaskProcessCell cellContentHeightFromText:content withFontSize:kFontSize];
        if (files.count > 0) {
            _selfLineView.hidden = NO;
            _selfFileBackView.hidden = NO;
            _selfLineView.top = _selfContentLabel.bottom;
            _selfFileBackView.top = _selfLineView.bottom+kBottomSpace;
            _selfFileBackView.height = [TaskProcessCell cellContentHeightFromFiles:files];
        } else {
            _selfLineView.hidden = YES;
//            _selfContentLabel.top = kContentLabelTop;
            _selfFileBackView.hidden = YES;
        }
        
        _selfContentLabel.top = kContentLabelTop;
        _selfContentLabel.text = _data[key_content];
        _selfTimeLabel.text = @"2014-06-11";
        _selfNameLabel.text = _data[key_username];
        
    } else {
        
        _otherBackView.hidden = NO;
        _otherContentLabel.height = [TaskProcessCell cellContentHeightFromText:content withFontSize:kFontSize];
        _otherBubbleBackView.height = [TaskProcessCell cellContentHeightFromFiles:files] + [TaskProcessCell cellContentHeightFromText:content withFontSize:kFontSize];
        
        if (files.count > 0) {
            _otherFileBackView.hidden = NO;
            _otherLineView.hidden = NO;
            _otherLineView.top = _otherContentLabel.bottom;
            _otherFileBackView.top = _otherLineView.bottom+kBottomSpace;
            _otherFileBackView.height = [TaskProcessCell cellContentHeightFromFiles:files];
        } else {
            _otherFileBackView.hidden = YES;
            _otherLineView.hidden = YES;
//            _otherContentLabel.top = kContentLabelTop;
        }
        
        _otherContentLabel.top = kContentLabelTop;
        _otherContentLabel.text = _data[key_content];
        _otherTimeLabel.text = @"2014-06-11";
        _otherNameLabel.text = _data[key_username];
    }
}


#pragma mark - cellContent height
+(CGFloat)cellContentHeightFromData:(NSDictionary *)dic
{
    CGFloat height = 0;
    NSString *text = dic[key_content];
    height = [TaskProcessCell cellContentHeightFromText:text withFontSize:14];
    height += kSpaceHeight;

    NSArray *files = [dic objectForKey:key_files];
    height += [TaskProcessCell cellContentHeightFromFiles:files];
    
    height += kTimeLabelHeight;
    
    if (height < kDefaultHeight) {
        height = kDefaultHeight;
    }
    
    return height;
}

+(CGFloat)cellContentHeightFromFiles:(NSArray *)files
{
    CGFloat height = 0;
    
    height = files.count * kFileRowHeight;
    
    return height;
}

+(CGFloat)cellContentHeightFromText:(NSString *)text withFontSize:(CGFloat)fontSize
{
    CGFloat height = 0;
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(kContextLabelWidth, 10000)];
    height = size.height + kContentSpace;
    return height;
}

#pragma mark - table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *files = self.data[key_files];
    return files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"fileCellId";
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FileCell" owner:nil options:nil] lastObject];
    }
    
    NSArray *files = self.data[key_files];
    cell.filename = files[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFileRowHeight-5;
}

@end
