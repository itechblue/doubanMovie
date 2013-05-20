//
//  DoubanItem.h
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanItem : NSObject
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *href;

@end
