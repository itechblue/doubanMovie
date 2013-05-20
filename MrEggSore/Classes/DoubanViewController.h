//
//  DoubanViewController.h
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "PageingViewController.h"
#import "TFHpple.h"
#import "commonPikerView.h"
@interface DoubanViewController : PageingViewController<commonPikerDelegate>
{
    BOOL isGoingPage;
    
    int hidingIndex;
    
    int nilCount;
}

@property(nonatomic,assign)commonPikerView*pikerView;

@end
