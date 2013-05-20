//
//  Tool.h
//  HahaCamera
//
//  Created by Simon on 13-3-24.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kIPHONE5Difference (548-460)
#define kScreenHeightExceptNavibar (460-44)
#define kScreenHeightExceptNavibar_iphone5 (548-44)
#define kNormalFrameSize CGRectMake(0, 0, 320, 460)

@interface Tool : NSObject
BOOL IsIPHONE5();

void hideTabBar(UITabBarController* tabbarcontroller);

UIBarButtonItem * HDBarButtonItem(id title, id obj, SEL selector);
UIBarButtonItem * HDBarButtonWithImage(NSString* imageName, CGSize size, id obj, SEL selector);
UIBarButtonItem * HDBarButtonWithBackgroundImage(NSString* imageName, CGSize size, id obj, SEL selector);

void showAlert(NSString*text);
void showAlertWithDelegate(NSString*text, id delegate, int tag);
void showAlertChoiceWithDelegate(NSString*text, id delegate, int tag);

NSString *setFilePath(NSString*dic, NSString *subfix);
BOOL myDeleteFile (NSString* path);
UIImage * scaleFromImage(UIImage *image, CGSize size);

UIColor* getColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha);

void ShowHUDWithDuration(NSString * text, NSTimeInterval duration);
void ShowLoading(NSString * text);
void HideLoading();
@end

@interface UINavigationController (CustomImage)

+(UINavigationController *)MyNaviWithRoot:(UIViewController *)root;
@end
