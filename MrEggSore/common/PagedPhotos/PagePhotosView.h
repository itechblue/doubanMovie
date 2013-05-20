//
//  PagePhotosView.h
//  picMemory
//
//  Created by simon on 12-6-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
@interface PagePhotosView : UIView<UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	UILabel * lblTitle;
	//id<PagePhotosDataSource> dataSource;
	//NSMutableArray *imageViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    int lastMark;
    int firstMark;
}

@property (nonatomic, assign) id<PagePhotosDataSource> dataSource;
@property (nonatomic, retain) NSMutableArray *imageViews;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)_dataSource;
-(void)refreshCurrentPage;

@end
