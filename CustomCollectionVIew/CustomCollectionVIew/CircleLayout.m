//
//  CircleLayout.m
//  CustomCollectionVIew
//
//  Created by sfwan on 14-10-13.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CircleLayout.h"
#define kRowSpacing         0

@implementation CircleLayout
//计算整个UICollectionView的contentSize，如果计算的大了，有可能会引起crash(具体情况取决于超出的尺寸是否会导致新的cell出现)

-(CGSize)collectionViewContentSize
{
    float width = (self.itemSize.width + kRowSpacing) *([self.collectionView numberOfItemsInSection:0 ] * 2);
    float height= self.collectionView.frame.size.height;
    CGSize  size = CGSizeMake(width, height);
    return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
#pragma mark - UICollectionViewLayout
#pragma mark - UICollectionViewLayout
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //3D代码
    UICollectionViewLayoutAttributes* attributes = attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    UICollectionView *collection = self.collectionView;
    float width = collection.frame.size.width;
    float x = collection.contentOffset.x;
    CGFloat arc = M_PI * 2.0f;
    
    
    int numberOfVisibleItems = [self.collectionView numberOfItemsInSection:0 ];
    
//    attributes.center = CGPointMake(x,50.0f);
//    attributes.size = CGSizeMake(100.0f, 100.0f);
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0f/700.0f;
    
    CGFloat radius = attributes.size.width/2/ tanf(arc/2.0f/numberOfVisibleItems);
    CGFloat angle = (indexPath.row-x/width+1)/ numberOfVisibleItems * arc;
    transform = CATransform3DRotate(transform, angle, 0.0f, 1.0f, 0.0f);
    transform = CATransform3DTranslate(transform, 0.f, 0.0f, radius);
//    attributes.transform3D = transform ;
    
    return attributes;
}

// 第二个获取在某个区域内(以contentSize为依据)可见cell的Attributes信息，这个函数需要获取这个可见区域内的indexPath的范围，而获取indexPath范围的方法需要获取某个点上cell的indexPath的方法，而这个方法又依赖于每个cell的size。
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"%d, %@", arr.count, NSStringFromCGRect(rect));
    if ([arr count] >0) {
        return arr;
    }
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}
@end
