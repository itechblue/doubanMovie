//
//  Project.m
//  mmBox
//
//  Created by Simon on 13-4-25.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import "Project.h"
#import "MobClick.h"
#import "BaiduMobStat.h"
#import "AFAppDotNetAPIClient.h"

@implementation Project

void mobClickBeginLogPageView(NSString*title)
{
//    [MobClick beginLogPageView:title];
//    baiduMobPageViewEnd(title);
}

void mobClickEndLogPageView(NSString*title)
{
//    [MobClick endLogPageView:title];
//    baiduMobPageViewEnd(title);
}

void mobClickEvent(NSString*event)
{
//    [MobClick event:event];
//    baiduMobEvent(event);
}

void baiduMobPageViewStart(NSString*title)
{
    [[BaiduMobStat defaultStat] pageviewStartWithName:title];
}

void baiduMobPageViewEnd(NSString*title)
{
    [[BaiduMobStat defaultStat] pageviewEndWithName:title];
}

void baiduMobEvent(NSString*event)
{
    [[BaiduMobStat defaultStat] logEvent:event eventLabel:@"备注"];
}

void appendItem(id value, NSString*k)
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[defaults objectForKey:k]];

    [defaults removeObjectForKey:k];
    if (value != nil) {
        [temp insertObject:value atIndex:0];
    }
    [defaults setObject:temp forKey:k];
}

void deleteItem(id key, NSString*k)
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[defaults objectForKey:k]];
    
    for(int i=0;i<temp.count;++i)
    {
        NSDictionary *dic = [temp objectAtIndex:i];
        if([key isEqualToString: [dic objectForKey:@"pid"]])
        {
            [temp removeObjectAtIndex:i];
            [defaults removeObjectForKey:k];
            [defaults setObject:temp forKey:k];
            break;
        }
    }
}

BOOL isItemCollected(id key, NSString*k)
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[defaults objectForKey:k]];
    
    for(int i=0;i<temp.count;++i)
    {
        NSDictionary *dic = [temp objectAtIndex:i];
        if([key isEqualToString: [dic objectForKey:@"pid"]])
        {
            return YES;
        }
    }
    return NO;
}

void setRefreshButton(UIView*v, CGRect frame, id obj, SEL selector)
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = frame;
    btn.backgroundColor = [UIColor blackColor];
    btn.alpha = 0.7;
    [btn setTitle:@"-_-||| 没刷出数据，点我重刷~" forState:UIControlStateNormal];
    [btn addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
}

GADBannerView * setBanner(id obj)
{
    // 在屏幕底部创建标准尺寸的视图。
    GADBannerView*bannerView_ = [[GADBannerView alloc]
                                 initWithFrame:CGRectMake(0.0,
                                                          0.0,
                                                          GAD_SIZE_320x50.width,
                                                          GAD_SIZE_320x50.height)];
    
    // 指定广告的“单元标识符”，也就是您的 AdMob 发布商 ID。
    bannerView_.adUnitID = AdMobKey;
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController
    // 并将其添加至视图层级结构。
    bannerView_.rootViewController = obj;
    
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
    
    return bannerView_;
}

#pragma mark - 
+ (void)requestTop250WithBlock:(int)page block:(void (^)(NSArray *posts, NSError *error))block {
    [[AFAppDotNetAPIClient sharedClient] getPath:[NSString stringWithFormat: @"https://api.douban.com/v2/movie/top250?start=%d&count=20", (page-1)*20] parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"subjects"];
        
        if (block) {
            block(postsFromResponse, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
@end
