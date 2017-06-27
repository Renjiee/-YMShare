//
//  ShareCollectionViewFlowLayout.m
//  CamelBB
//
//  Created by ChangRJey on 17/3/27.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ShareCollectionViewFlowLayout.h"
/** 屏幕的SIZE */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
/** define:屏幕的宽高比 */
#define CURRENT_SIZE(_size) _size / 375.0 * SCREEN_SIZE.width

@implementation ShareCollectionViewFlowLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置每个 UICollectionView 的大小
        self.itemSize = CGSizeMake(SCREEN_SIZE.width/4,CURRENT_SIZE(94));
        //设置每个 UICollectionView 的横向间距
        self.minimumLineSpacing = 0;
        //设置每个 UICollectionView 的纵向间距
        self.minimumInteritemSpacing = 0;
        //设置每个 UICollectionView 的边距
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return self;
}


@end
