//
//  PageingViewController.h
//  itechblue
//
//  Created by Simon on 13-4-18.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"

@interface PageingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, MBProgressHUDDelegate,UIScrollViewDelegate> {
    UITableView *table;
    UIScrollView *mainScroll;
    
    int total;
    int countPerPage;
    int goingPage;
    int currentPage;
    BOOL isLoadingMore;

    //refresh
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSString *emptyTip;
    
    MBProgressHUD *HUD;

}

@property (nonatomic, assign) BOOL dontHaveRefresh;
-(void)gettingDataAt:(int)page;
-(void)getDataAt:(int)page;

@property (nonatomic, retain) NSMutableArray *result;
-(void)commonInitWithTabbar;

@end
