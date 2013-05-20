//
//  iTechBlueAppDelegate.h
//  MrEggSore
//
//  Created by Simon on 13-5-8.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "MBProgressHUD.h"
#import "GADBannerView.h"
#import "DMAdView.h"
@interface iTechBlueAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,MBProgressHUDDelegate,WXApiDelegate,DMAdViewDelegate,GADBannerViewDelegate>
{
    UIView*banner;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

- (void) sendNewsContent:(NSString*)title description:(NSString*)description href:(NSString*)href image:(UIImage*)image mode:(int)mode;
-(void) sendTextContent:(NSString *)nsText mode:(int)mode;

@property (nonatomic, retain) NSTimer* timer;

@end
