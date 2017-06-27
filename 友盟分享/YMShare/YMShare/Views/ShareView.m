//
//  ShareView.m
//  CamelBB
//
//  Created by ChangRJey on 17/3/25.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ShareView.h"
#import <Masonry.h>
#import "ShareCollectionViewFlowLayout.h"
#import "ShareCollectionViewCell.h"

/** 屏幕的SIZE */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
/** define:屏幕的宽高比 */
#define CURRENT_SIZE(_size) _size / 375.0 * SCREEN_SIZE.width
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define SELECT_COLOR(_r,_g,_b,_alpha) [UIColor colorWithRed:_r / 255.0 green:_g / 255.0 blue:_b / 255.0 alpha:_alpha]

/** 灰色 */
#define KGrayColor SELECT_COLOR(153,153,153,1)

@implementation ShareView


#pragma mark -------------------- 在layoutSubviews方法中设置子控件的frame --------------------

- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAKSELF
    [self addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(100), 1));
        make.top.equalTo(weakSelf).offset(CURRENT_SIZE(28));
        make.left.equalTo(weakSelf).offset(CURRENT_SIZE(34));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(80), CURRENT_SIZE(15)));
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.leftLine);
    }];
    
    [self addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(100), 1));
        make.centerY.equalTo(weakSelf.leftLine);
        make.right.equalTo(weakSelf).offset(-CURRENT_SIZE(34));
    }];
    
    [self addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width, CURRENT_SIZE(94)));
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
    }];
}


#pragma mark -------------------- 懒加载控件 --------------------

- (UIImageView *) leftLine{
    if(!_leftLine){
        _leftLine = [UIImageView new];
        _leftLine.backgroundColor = [UIColor clearColor];
        _leftLine.image = [UIImage imageNamed:@"750x1_line"];
    }
    return _leftLine;
}

- (UILabel *) titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = KGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:CURRENT_SIZE(15)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"分享到";
    }
    return _titleLabel;
}

- (UIImageView *) rightLine{
    if(!_rightLine){
        _rightLine = [UIImageView new];
        _rightLine.backgroundColor = [UIColor clearColor];
        _rightLine.image = [UIImage imageNamed:@"750x1_line"];
    }
    return _rightLine;
}

- (UICollectionView *) collection{
    if(!_collection){
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[[ShareCollectionViewFlowLayout alloc] init]];
        _collection.backgroundColor = [UIColor clearColor];
        //设置cell
        [_collection registerClass:[ShareCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}



@end
