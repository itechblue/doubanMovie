//
//  iTechBlueAppDelegate.m
//  MrEggSore
//
//  Created by Simon on 13-5-8.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "iTechBlueAppDelegate.h"
//#import <Parse/Parse.h>
#import "MobClick.h"
#import "BaiduMobStat.h"
#import "Project.h"

#import "DoubanViewController.h"
#import "doubanMovieTable.h"

@implementation iTechBlueAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self initTools];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self initCtrollers];

    [self.window makeKeyAndVisible];
    
//    [self setBanner];
//    [self setDomobBanner];
    return YES;
}

-(void)initTools
{
    //友盟
    [MobClick startWithAppkey:mobAppKey];
    //微信
    [WXApi registerApp:weixinAppkey];
    //百度
    BaiduMobStat*statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = NO;
    //    statTracker.channelId = @"Cydia";
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;
    //    statTracker.logSendInterval = 1;
    statTracker.logSendWifiOnly = YES;
    statTracker.sessionResumeInterval = 60;
    [statTracker startWithAppId:baiduMobAppKey];

    //parse
//    [Parse setApplicationId:@"s4xdv5vze4ccWPkpBYYhT5OpaFaVYGJLDLM2VCMz"
//                  clientKey:@"iaruHkSkaiGEm4eQi8hqJRCQYbtQHWvPea3mkc48"];
}

- (void)initCtrollers
{
    NSMutableArray *ctrls = [[NSMutableArray alloc] initWithCapacity:0];
    
//    DoubanViewController *douban = [[DoubanViewController alloc] init];
//    UINavigationController *doubanCtrl = [UINavigationController MyNaviWithRoot:douban];
//    doubanCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"少林修女" image:[UIImage imageNamed:@"document_64"] tag:2];
//    [ctrls addObject:doubanCtrl];

    doubanMovieTable *doubanMovie = [[doubanMovieTable alloc] init];
    UINavigationController *doubanMovieCtrl = [UINavigationController MyNaviWithRoot:doubanMovie];
    doubanMovieCtrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top250" image:[UIImage imageNamed:@"video_64"] tag:2];
    [ctrls addObject:doubanMovieCtrl];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.window.rootViewController =self.tabBarController;

    self.tabBarController.viewControllers = ctrls;

    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - MBHUD
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}

#pragma mark - weixin
-(void) onReq:(BaseReq*)req
{
    
    //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
}

-(void) onResp:(BaseResp*)resp
{
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
}

- (void) sendNewsContent:(NSString*)title description:(NSString*)description href:(NSString*)href image:(UIImage*)image mode:(int)mode
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:image];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = href;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = mode==1?WXSceneTimeline:WXSceneSession;
    
    [WXApi sendReq:req];
}

-(void) sendTextContent:(NSString *)nsText mode:(int)mode
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = nsText;
    req.scene = mode==1?WXSceneTimeline:WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark - banner
-(void)setBanner
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    UIView*v = [[UIView alloc] initWithFrame:CGRectMake((bounds.size.width-320)/2.0,
                                                        bounds.size.height-49-70,
                                                        320,
                                                        70)];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lbl.text = @"我是广告，点我，点我，不点我30秒后我就消失啦! >_<";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.backgroundColor = [UIColor clearColor];
    [v addSubview:lbl];
    
    GADBannerView*bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    [v addSubview:bannerView_];
    
    v.backgroundColor = [UIColor whiteColor];
    banner = v;
    banner.alpha = 0.8;
    banner.hidden = YES;
    [self.window.rootViewController.view addSubview:banner];
    
    // 指定广告的“单元标识符”，也就是您的 AdMob 发布商 ID。
    bannerView_.adUnitID = AdMobKey;
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController
    // 并将其添加至视图层级结构。
    bannerView_.rootViewController = self.window.rootViewController;
    bannerView_.delegate = self;
    GADRequest *request = [GADRequest request];
    request.gender = kGADGenderMale;
    request.additionalParameters =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"88c6d0", @"color_bg",
     @"FFFFFF", @"color_bg_top",
     @"88c6d0", @"color_border",
     @"000080", @"color_link",
     @"808080", @"color_text",
     @"008000", @"color_url",
     nil];
    [request setLocationWithDescription:@"中国"];

    // 启动一般性请求并在其中加载广告。
    [bannerView_ loadRequest:request];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:180
//                                                  target:self
//                                                selector:@selector (showBanner:)
//                                                userInfo:nil
//                                                 repeats:NO];

}

- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    [self.timer invalidate];
    banner.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30
                                                  target:self
                                                selector:@selector (stopBanner:)
                                                userInfo:nil
                                                 repeats:NO];
}
- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    GADRequest *request = [GADRequest request];
    request.gender = kGADGenderMale;
    request.additionalParameters =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"88c6d0", @"color_bg",
     @"FFFFFF", @"color_bg_top",
     @"88c6d0", @"color_border",
     @"000080", @"color_link",
     @"808080", @"color_text",
     @"008000", @"color_url",
     nil];
    [request setLocationWithDescription:@"中国"];
    
    // 启动一般性请求并在其中加载广告。
    [view loadRequest:request];
}

-(void)setDomobBanner
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    UIView*v = [[UIView alloc] initWithFrame:CGRectMake(0.0,
                                                        bounds.size.height-49-70,
                                                        bounds.size.width,
                                                        70)];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 20)];
    lbl.text = @"我是广告，点我，点我，不点我30秒后我就消失啦! >_<";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:12];
    [v addSubview:lbl];
    
    /* 创建⼲⼴广告视图,此处使⽤用的是测试ID,请登陆多盟官⺴⽹网(www.domob.cn)获取新的ID */
    DMAdView*_dmAdView = [[DMAdView alloc] initWithPublisherId:DoMobKey
                           placementId:DomobAd1 size:DOMOB_AD_SIZE_320x50];
    // 设置⼲⼴广告视图的位置
    _dmAdView.frame = CGRectMake((bounds.size.width-DOMOB_AD_SIZE_320x50.width)/2.0,
                                 20,
                                 DOMOB_AD_SIZE_320x50.width,
                                 DOMOB_AD_SIZE_320x50.height);
    _dmAdView.delegate = self; // 设置 Delegate
    _dmAdView.rootViewController = self.window.rootViewController; // 设置 RootViewController
    [v addSubview:_dmAdView]; // 将⼲⼴广告视图添加到⽗父视图中
    [_dmAdView loadAd]; // 开始加载⼲⼴广告}

    v.backgroundColor = [UIColor whiteColor];
    banner = v;
    banner.alpha = 0.7;
    banner.hidden = YES;
    [self.window.rootViewController.view addSubview:banner];

    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:180
                                                  target:self
                                                selector:@selector (showBanner:)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void) showBanner: (NSTimer*) timer {
    banner.hidden = NO;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30
                                                  target:self
                                                selector:@selector (stopBanner:)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void) stopBanner: (NSTimer*) timer {
    [banner removeFromSuperview];
    [self.timer invalidate];
}
@end
