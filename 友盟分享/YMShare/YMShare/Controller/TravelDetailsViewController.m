//
//  TravelDetailsViewController.m
//  CamelBB
//
//  Created by ChangRJey on 17/3/9.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "TravelDetailsViewController.h"
#import "ShareCollectionViewCell.h"
#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>

#import <LCProgressHUD.h>

/** 屏幕的SIZE */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
/** define:屏幕的宽高比 */
#define CURRENT_SIZE(_size) _size / 375.0 * SCREEN_SIZE.width

@interface TravelDetailsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>



/** 分享 */
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong) ShareCollectionViewCell * shareCell;
@property (nonatomic, strong) NSArray * shareIconAry;
/** 邀请码 */
@property (nonatomic, strong) NSString * codeStr;

@property (nonatomic, assign) double totalTraceLength;
@property (nonatomic, strong) NSMutableArray *tempTraceLocations;




@end

@implementation TravelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"友盟分享";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor] ,
                                                                      //设置字体大小
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 分享按钮
    UIBarButtonItem * shareButon = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareInfo:)];
    self.navigationItem.rightBarButtonItem = shareButon;

    
    self.shareIconAry = @[@"微信ico",@"朋友圈icon",@"QQicon",@"Qzone"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 初始化分享界面 */
- (void) initShareView{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnBgView:)];
    [self.bgView addGestureRecognizer:tapIt];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    self.shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, SCREEN_SIZE.height-CURRENT_SIZE(130), SCREEN_SIZE.width, CURRENT_SIZE(130))];
    self.shareView.backgroundColor = [UIColor whiteColor];
    
    self.shareView.collection.delegate = self;
    self.shareView.collection.dataSource = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
    
}

- (void)tapOnBgView:(UITapGestureRecognizer *)recognizer {
    
    [self.shareView removeFromSuperview];
    self.bgView.hidden = YES;
}

#pragma mark -------------------- UICollectionViewDataSource --------------------

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shareIconAry.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    self.shareCell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    //    [cell sizeToFit];
    
    self.shareCell.icon.image = [UIImage imageNamed:self.shareIconAry[indexPath.row]];
    
    return self.shareCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;

    switch (indexPath.row) {
        case 0:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];

            break;
        case 1:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            
            break;
        case 2:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            
            break;
        case 3:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            
            break;
            
        default:
            break;
    }
}

#pragma mark -------------------- 按钮点击事件 --------------------

- (void) shareInfo:(UIButton *) sender{
    NSLog(@"分享");
    [self initShareView];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    
    NSString * link = @"share_download";
    NSString * thumbURL = [[NSString alloc]initWithFormat:@"www.baidu.com"];
    // 将链接转译为UTF8因为 codeStr中有中文会导致QQ分享链接出错
    NSString* encodedString = [thumbURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"百度一下，你就知道" descr:nil thumImage:encodedString];
    //设置网页地址
    shareObject.webpageUrl = encodedString;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [LCProgressHUD showFailure:@"分享失败"];

        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                [LCProgressHUD showSuccess:@"分享成功"];
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

@end
