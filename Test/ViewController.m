//
//  ViewController.m
//  Test
//
//  Created by admin on 2020/6/19.
//  Copyright © 2020 Min zhang. All rights reserved.
//

#import "ViewController.h"

#import "WateFlowCollectionViewCell.h"
#import "WaterFlowLayout.h"

#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat kCollectionViewInterSpacing = 10;
static const CGFloat kCollectionViewLineSpacing = 10;

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/// <#Description#>
@property (nonatomic, strong)  UICollectionView *collectionView;
/// <#Description#>
@property (nonatomic, strong)  NSMutableArray *imagesArray;
/// <#Description#>
@property (nonatomic, strong)  NSMutableArray<NSNumber *> *imagesRatioArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    _collectionView.frame = self.view.bounds;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WateFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WateFlowCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < _imagesArray.count) {
        NSURL *imageURL = [NSURL URLWithString:_imagesArray[indexPath.row]];
        // 获取图片
        __weak typeof(self) weakSelf = self;
        [cell.imageView sd_setImageWithURL:imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image == nil) {
                return;
            }
            // 图片宽高比
            CGFloat imageHToW = image.size.height / image.size.width;
            if (indexPath.row < weakSelf.imagesRatioArray.count) {
                if ([weakSelf.imagesRatioArray[indexPath.row]  isEqual: @(imageHToW)]) {
                    return;
                }
            }
            
            weakSelf.imagesRatioArray[indexPath.row] = @(imageHToW);
            // 刷新对应位置Cell
//            [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];

            [UIView performWithoutAnimation:^{
                [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            
//            [weakSelf.collectionView performBatchUpdates:^{
//                [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//
//            } completion:^(BOOL finished) {
//
//            }];
        }];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (CGRectGetWidth([UIScreen mainScreen].bounds) - kCollectionViewInterSpacing * 3) / 2.0;
    CGFloat itemH = 0;
    if (indexPath.row < _imagesRatioArray.count) {
        itemH = [_imagesRatioArray[indexPath.row] floatValue] * itemW;
    }
    return CGSizeMake(itemW, itemH);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kCollectionViewInterSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kCollectionViewLineSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark -- Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc] initWithDataArray:self.imagesArray columnCount:2 lineSpacing:kCollectionViewLineSpacing interSpacing:kCollectionViewInterSpacing inset:UIEdgeInsetsMake(10, 10, 10, 10) ];

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WateFlowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WateFlowCollectionViewCell"];
    }
    return _collectionView;
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592565138595&di=1113a0d4619ce0cf3ac9c6e23d364f67&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201406%2F28%2F20140628141121_zYjLH.jpeg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592565096623&di=413ae8644b7cf5533e53ce6b1a07a052&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F02%2F93%2F01300543893970147279933938013_s.jpg", @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2758629521,704877235&fm=26&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1590790001,2715877802&fm=26&gp=0.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2762254234,3469733090&fm=15&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3371419587,3866629445&fm=26&gp=0.jpg", @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2368037349,1572984501&fm=26&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3211788661,2897552284&fm=26&gp=0.jpg", @"https://t7.baidu.com/it/u=2273319405,1074301713&fm=193",
        @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3932125539,1623067373&fm=26&gp=0.jpg", @"https://t8.baidu.com/it/u=1550536241,714026080&fm=193", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=516623523,778918237&fm=26&gp=0.jpg", @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4046212130,3583326820&fm=26&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2796337415,3035659905&fm=26&gp=0.jpg", @"https://pic.rmb.bdstatic.com/1f9071e7d03aab180ac7bce474339132.jpeg"] mutableCopy];
    }
    return _imagesArray;
}

- (NSMutableArray<NSNumber *> *)imagesRatioArray {
    if (!_imagesRatioArray) {
        _imagesRatioArray = [NSMutableArray arrayWithCapacity:self.imagesArray.count];
        for (int i = 0; i < self.imagesArray.count; i++) {
            _imagesRatioArray[i] = @(1);
        }
    }
    return _imagesRatioArray;
}

@end
