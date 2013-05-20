//
//  Project.h
//  mmBox
//
//  Created by Simon on 13-4-25.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kYouku @"kYouku"
#define kRetarded @"kRetarded"
#define kJandan @"kJandan"

#define kBriefUrlHeader @"http://h2w.iask.cn/gate.php?url="

#define kTab3Title @"弱智者语"

#import "GADBannerView.h"

@interface Project : NSObject

void mobClickBeginLogPageView(NSString*title);
void mobClickEndLogPageView(NSString*title);
void mobClickEvent(NSString*event);

void baiduMobPageViewStart(NSString*title);
void baiduMobPageViewEnd(NSString*title);
void baiduMobEvent(NSString*event);

void appendItem(id value, NSString*k);
void deleteItem(id key, NSString*k);
BOOL isItemCollected(id key, NSString*k);

void setRefreshButton(UIView*v, CGRect frame, id obj, SEL selector);

GADBannerView * setBanner(id obj);

+ (void)requestTop250WithBlock:(int)page block:(void (^)(NSArray *posts, NSError *error))block;
@end
