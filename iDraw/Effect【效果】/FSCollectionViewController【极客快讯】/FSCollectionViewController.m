//
//  FSCollectionViewController.m
//  ForceSource
//
//  Created by 翁志方 on 16/3/11.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "FSCollectionViewController.h"

@interface FSCollectionViewController ()

@end

@implementation FSCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 8;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    CGFloat r = (arc4random()%1000) / 1000.0;
    CGFloat g = (arc4random()%1000) / 1000.0;
    CGFloat b = (arc4random()%1000) / 1000.0;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    cell.backgroundColor = color;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取页面中所有的CollectionViewCell进行动画
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    // 播放transform动画
    {
        CATransform3D toTransform3D = CATransform3DMakeTranslation(-300, -300, 0);
        
        
        toTransform3D = CATransform3DRotate(toTransform3D, 3.14/2, 0, 1, 0);
        //        CATransform3DMakeRotation(3.14/2, 0, 1, 0);
        toTransform3D.m34 = -0.01;
        
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:toTransform3D];
        animation.duration = 1;
        
        animation.removedOnCompletion = NO;
        cell.layer.fillMode = kCAFillModeBackwards;
        cell.layer.anchorPoint = CGPointMake(0, 0);
        [cell.layer addAnimation:animation forKey:nil];
    }
    
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //整个视图的顶端左端底端右端
    UIEdgeInsets top = {25,25,25,25};
    return top;
}

//定义每个UICollectionView的大小,注意：这里需要和BTCollectionCell的大小设置一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 80);
}


@end
