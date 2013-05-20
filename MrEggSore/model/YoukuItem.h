//
//  YoukuItem.h
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoukuItem : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *played;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *duration;

@end
