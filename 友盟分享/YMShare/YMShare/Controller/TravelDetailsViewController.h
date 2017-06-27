//
//  TravelDetailsViewController.h
//  CamelBB
//
//  Created by ChangRJey on 17/3/9.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelDetailsViewController : UIViewController
/**
 * 骑行时间
 */
@property (nonatomic, copy) NSString * dateStr;
/**
 * 骑行费用
 */
@property (nonatomic, copy) NSString * moneyStr;
/**
 * 自行车编号
 */
@property (nonatomic, copy) NSString * bikeCode;
/**
 * 路线ID
 */
@property (nonatomic, copy) NSString * routeId;
@end
