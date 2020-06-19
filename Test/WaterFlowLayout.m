//
//  WaterFlowLayout.m
//  Test
//
//  Created by admin on 2020/6/19.
//  Copyright © 2020 Min zhang. All rights reserved.
//

#import "WaterFlowLayout.h"

@interface WaterFlowLayout ()

/// 竖列数
@property (nonatomic, assign)  NSUInteger columnCount;
/// 边距
@property (nonatomic, assign)  UIEdgeInsets inset;
/// 行间距
@property (nonatomic, assign)  CGFloat minLineSpacing;
/// 列间距
@property (nonatomic, assign)  CGFloat miniInterSpacing;
/// 所有元素
@property (nonatomic, strong)  NSMutableArray<UICollectionViewLayoutAttributes *> *attsArray;
/// 列的Y值数组
@property (nonatomic, strong)  NSMutableArray<NSNumber *> *columnMaxYArray;


@end

@implementation WaterFlowLayout

- (instancetype)initWithDataArray:(NSArray *)dataArray columnCount:(NSInteger)columnCount lineSpacing:(CGFloat)lineSpacing interSpacing:(CGFloat)interSpacing inset:(UIEdgeInsets)inset {
    self = [super init];
    if (self) {
        _columnCount = columnCount;
        _minLineSpacing = lineSpacing;
        _miniInterSpacing = interSpacing;
        _inset = inset;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    NSInteger section = 0;
    NSInteger totalItemCount = [self.collectionView numberOfItemsInSection:section];
    [self.attsArray removeAllObjects];
    
    
    self.columnMaxYArray = [NSMutableArray arrayWithCapacity:_columnCount];

    NSMutableArray<NSNumber *> *allColumnMaxY = [NSMutableArray array];
    for (int currentColumn = 0; currentColumn < _columnCount; currentColumn++) {
        allColumnMaxY[currentColumn] = @(0);
    }
    
    for (int i = 0; i < totalItemCount; i++) {
        
        // 获取当前屏幕上面最先的Item的Y 从最小的Y开始往下排列 这时colum的X也会随之变化
        //      1 *****   2 *****
        //        *****
        //        *****   3 *****
        //                  *****
        //      4 *****
        //        *****
        //        *****
        //
        // 获取最小Y的位置
        CGFloat currentMinY = allColumnMaxY[0].floatValue;
        NSInteger currentColumIndex = 0;

        for (int colum = 0; colum < _columnCount; colum++) {
            CGFloat currentItemY = allColumnMaxY[colum].floatValue;
            if (currentMinY > currentItemY) {
                currentMinY = currentItemY;
                currentColumIndex = colum;
            }
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        CGRect frame = att.frame;
        frame.origin.x = currentColumIndex * (CGRectGetWidth(frame) + _miniInterSpacing) + _inset.left;
        frame.origin.y = currentMinY + _minLineSpacing;
        att.frame = frame;
        
        allColumnMaxY[currentColumIndex] = @(CGRectGetMaxY(frame));
        [_attsArray addObject:att];
    }
    
    _columnMaxYArray = allColumnMaxY;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *att = [super layoutAttributesForItemAtIndexPath:indexPath];
    return att;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attsArray;
}

- (CGSize)collectionViewContentSize {
    
    CGFloat maxContentY = 0;
    for (int i = 0; i < self.columnMaxYArray.count; i++) {
        CGFloat currentY = _columnMaxYArray[i].floatValue;
        if (maxContentY < currentY) {
            maxContentY = currentY;
        }
    }
    
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), maxContentY + _inset.bottom);
}

#pragma mark -- Getter
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attsArray {
    if (!_attsArray) {
        _attsArray = [@[] mutableCopy];
    }
    return _attsArray;
}

- (NSMutableArray<NSNumber *> *)columnMaxYArray {
    if (!_columnMaxYArray) {
        _columnMaxYArray = [@[] mutableCopy];
    }
    return _columnMaxYArray;
}

@end
