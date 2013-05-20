//
//  Tool.m
//  HahaCamera
//
//  Created by Simon on 13-3-24.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import "Tool.h"
#import "MBProgressHUD.h"
#import "iTechBlueAppDelegate.h"
@implementation Tool

BOOL IsIPHONE5()
{
    return  ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON );
}

#pragma mark - UI
void hideTabBar(UITabBarController* tabbarcontroller)
{
    for(UIView*view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
        }
    }
}
UIBarButtonItem * HDBarButtonItem(id title, id obj, SEL selector){
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    //    [barButton setBackgroundImage:[UIImage imageNamed:@"nav-button-bg"] forState:UIControlStateNormal];
    if ([title isKindOfClass:[NSString class]]) {
        [barButton setTitle:title forState:UIControlStateNormal];
    }else if([title isKindOfClass:[UIImage class]]){
        [barButton setImage:title forState:UIControlStateNormal];
    }else if([title isKindOfClass:[UIImageView class]]){
        ((UIImageView*)title).frame = CGRectMake(14, 6, 22, 22);
        [barButton addSubview:title];
        [title release];
    }
    else{
        //NSAssert(YES, @"HDBarButtonItem 第一个参数不支持");
    }
    
    [barButton setFrame:CGRectMake(0.0f, 0.0f, 50.0f, 39.0f)];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return [backBarButton autorelease];
}

UIBarButtonItem * HDBarButtonWithImage(NSString* imageName, CGSize size, id obj, SEL selector)
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [barButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [barButton setFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return [backBarButton autorelease];
}

UIBarButtonItem * HDBarButtonWithBackgroundImage(NSString* imageName, CGSize size, id obj, SEL selector)
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [barButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [barButton setFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return [backBarButton autorelease];
}

void showAlert(NSString*text)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}

void showAlertWithDelegate(NSString*text, id delegate, int tag)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:text delegate:delegate cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
    [alert release];
    
}

void showAlertChoiceWithDelegate(NSString*text, id delegate, int tag)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:text delegate:delegate cancelButtonTitle:NSLocalizedString(@"NO", nil) otherButtonTitles:NSLocalizedString(@"YES", nil), nil];
    alert.tag = tag;
    [alert show];
    [alert release];
    
}

NSString *setFilePath(NSString*dic, NSString *subfix)
{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setDateFormat:@"yyyy'-'MM'-'dd'-'HH'-'mm'-'ss"];
    NSString *formatedDate = [format stringFromDate:date];
    NSString * fileDir  = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat: @"/Documents/%@/", dic]];
    NSLog(@"%@",fileDir);
    NSString *path = [[fileDir stringByAppendingString:[NSString stringWithFormat:@"%@.%@",formatedDate, subfix]] retain];
    
    NSFileManager *fileManager= [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
    
    BOOL isDir=YES;
    if(![fileManager fileExistsAtPath:fileDir isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:NULL])
            NSLog(@"Error: Create folder failed %@", fileDir);
    
    return path;
}

BOOL myDeleteFile (NSString* path) {
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSError *deleteErr = nil;
		[[NSFileManager defaultManager] removeItemAtPath:path error:&deleteErr];
		if (deleteErr) {
            //			NSLog (@"Can't delete %@: %@", path, deleteErr);
            return NO;
		}
        return YES;
	}
    return NO;
}

UIImage * scaleFromImage(UIImage *image, CGSize size)
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

UIColor* getColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

void ShowHUDWithDuration(NSString * text, NSTimeInterval duration){
    iTechBlueAppDelegate *dele = (iTechBlueAppDelegate *)[UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:dele.window];
    hud.delegate = dele;
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [dele.window addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:duration];
    [hud release];
}

void ShowLoading(NSString * text)
{    
    iTechBlueAppDelegate *dele = (iTechBlueAppDelegate *)[UIApplication sharedApplication].delegate;
    
    MBProgressHUD *existHud = [MBProgressHUD HUDForView:dele.window];
    if (existHud != nil) {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:dele.window];
    hud.dimBackground = YES;
    hud.labelText = text;
    //    hud.detailsLabelText = text;
    [dele.window addSubview:hud];
    [hud show:YES];
    //    hud.delegate = (VPlayerAppDelegate *)[UIApplication sharedApplication].delegate;
    [hud release];
}

void HideLoading()
{
    iTechBlueAppDelegate *dele = (iTechBlueAppDelegate *)[UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:dele.window];
    
    if (hud) {
        [hud hide:YES];
        [hud removeFromSuperview];
    }
}
@end

@implementation UINavigationController (CustomImage)

+(UINavigationController *)MyNaviWithRoot:(UIViewController *)root
{
    UINavigationController *nav = [[[NSBundle mainBundle] loadNibNamed:@"MyNav" owner:nil options:nil] objectAtIndex:0];
    nav.viewControllers = [NSArray arrayWithObject:root];
    nav.view.frame = kNormalFrameSize;

    return nav;
}

@end