//
//  WateFlowCollectionViewCell.m
//  Test
//
//  Created by admin on 2020/6/19.
//  Copyright © 2020 Min zhang. All rights reserved.
//

#import "WateFlowCollectionViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface WateFlowCollectionViewCell ()

@end

@implementation WateFlowCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
}

@end
