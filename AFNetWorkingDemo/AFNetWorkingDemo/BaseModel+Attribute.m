//
//  BaseModel+Attribute.m
//  AFNetWorkingDemo
//
//  Created by sfwan on 14-7-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "BaseModel+Attribute.h"

@implementation BaseModel (Attribute)
id _contentDic;

/*
 * 1 需要建立映射关系（key ： model属性， value ：JSON的key）
 * 2 构建一个BaseModel类（initWithContent:）
 * 3 拿到JSON数据与Model模型的映射关系表（字典）
 * 4 根据映射关系表，以此得到JSON数据的key（通过映射关系表），从而得到JSON的value
 * 5 生成SEL类型变量（生成setter方法）
 * 6 将model对象赋值
 *
 *  注意：构建映射关系表时，一定要注意key，value不要写错
 */

- (id)initWithContent:(id)json
{
    self = [super init];
    if (self) {
        
        // 获取JSON数据
        _contentDic = [json retain];
        
        // 设置数据
        [self setterModelData];
        
    }
    return self;
} // 初始化方法

- (id)setMapAttributes
{
    return nil;
} // 防止出现警告

/*
 *  SEL sel NSSelectorFromString(@"")
 *  SEL sel @selector(test)
 */
- (SEL)pendingSetterMethod:(NSString *)key
{
    // 取出首字母，并且大写
    NSString *capital = [[key substringToIndex:1] uppercaseString];
    // 取出剩下字母
    NSString *character = [key substringFromIndex:1];
    // 合成setter方法
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", capital, character];
    // 生成SEL变量
    return NSSelectorFromString(setter);
} // 合成SEL变量

- (void)setterModelData
{
    // 得到关系字典
    NSDictionary *ralationshipDic = [self setMapAttributes];
    
    for (id key in ralationshipDic) {
        
        // 获取JSON数据
        id jsonKey = ralationshipDic[key];
        // 获取到数据
        id jsonValue = _contentDic[jsonKey];
        // 生成SEL变量
        SEL sel = [self pendingSetterMethod:key];
        
        // 增强程序健壮性
        if ([self respondsToSelector:sel]) {
            
            [self performSelector:sel withObject:jsonValue];
            
            //[self performSelector:@selector(setArray:) withObject:@[@"hehe", @"xixi"]];
            
            //[self performSelector:@selector(setTitle:) withObject:@"hehe"];
        }
    }
} // 设置属性内容

- (void)dealloc
{
    [_contentDic release];
    [super dealloc];
}
@end
