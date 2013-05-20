//
//  PagePhotosDataSource.h
//  PagePhotosDemo
//
//  Created by Andy soonest on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PagePhotosDataSource

// 有多少页
//
- (int)numberOfPages;

-(NSString*)imgUrlAtIndex:(int)index;
// 每页的图片
//
- (UIImage *)imageAtIndex:(int)index;

-(NSString*)titleAtIndex:(int)index;

@optional
//点击图片的事件
//
- (void)ImageTaped:(int)index;

//长按图片的事件
//
-(void) ImageLongPress:(int)index;
@end
