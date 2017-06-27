# -YMShare
友盟第三方分享(精简版)

![][image-1]

打开工程AppDelegate.h文件夹导入头文件
`#import <UMSocialCore/UMSocialCore.h>`

	-  (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	/* 打开调试日志 */
	[[UMSocialManager defaultManager] openLog:YES];
	/* 设置友盟appkey */
	[[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
	
	[self configUSharePlatforms];
	
	return YES;
	}

	-  (void)configUSharePlatforms
	{
	/* 设置微信的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPKEY appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
	/* 设置分享到QQ互联的appID
	 * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
	 */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPKEY/*设置QQ平台的appID*/  appSecret:QQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
	
	
	}


[image-1]:	https://ooo.0o0.ooo/2017/06/27/5951d9663f7a8.png "效果图"