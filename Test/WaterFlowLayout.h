//
//  WaterFlowLayout.h
//  Test
//
//  Created by admin on 2020/6/19.
//  Copyright © 2020 Min zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterFlowLayout : UICollectionViewFlowLayout

- (instancetype)initWithDataArray:(NSArray *)dataArray columnCount:(NSInteger)columnCount lineSpacing:(CGFloat)lineSpacing interSpacing:(CGFloat)interSpacing inset:(UIEdgeInsets)inset;

@end

NS_ASSUME_NONNULL_END
