//
//  PageingViewController.h
//  itechblue
//
//  Created by Simon on 13-4-18.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "PageingViewController.h"

@implementation PageingViewController

@synthesize dontHaveRefresh;

@synthesize result;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    emptyTip = @"";
    
    mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    mainScroll.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [mainScroll setScrollEnabled:YES];
    mainScroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [mainScroll setShowsVerticalScrollIndicator:NO];
    [mainScroll setShowsHorizontalScrollIndicator:NO];
    [mainScroll setPagingEnabled:NO];
    mainScroll.alwaysBounceHorizontal=YES;
    mainScroll.delegate = self;
    [self.view addSubview:mainScroll];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainScroll addSubview:table];

    if (_refreshHeaderView == nil && !dontHaveRefresh) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f - table.bounds.size.width, 0.0f, table.frame.size.width, table.bounds.size.height)];
		view.delegate = self;
		[mainScroll addSubview:view];
		_refreshHeaderView = view;
	}

    [self gettingDataAt:1];
}

-(void)commonInitWithTabbar
{
    CGRect bound = [UIScreen mainScreen].bounds;
    int pagewide = bound.size.width;
    int height = bound.size.height-20-44-49;
    mainScroll.frame = CGRectMake(0, 0, pagewide, height);
    mainScroll.contentSize = CGSizeMake(pagewide, height);
    table.frame = CGRectMake(0, 0, pagewide, height);
}
#pragma mark - 获取数据
-(void)gettingDataAt:(int)page
{
    goingPage = page;
    isLoadingMore=YES;
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = [NSString stringWithFormat:@"加载第%d页",goingPage];
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

-(void)getDataAt:(int)page
{
    goingPage = page;
    isLoadingMore = YES;
}

#pragma mark - tableview datasource / delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

#pragma mark - scroll delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if([scrollView isEqual:mainScroll])
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    else{
        if(isLoadingMore)return;
//        float t1 = scrollView.contentSize.height;
//        float t2 = scrollView.contentOffset.y;
//        float t3 = scrollView.frame.size.height;
//        if(t2>0)
//        {
//            float t4 = t3-(t1-t2);
//            if(t4>=10)
//            {
//                isLoadingMore=YES;
//                HUD = [[MBProgressHUD alloc] initWithView:self.view];
//                [self.view addSubview:HUD];
//                HUD.delegate = self;
//                
//                HUD.mode = MBProgressHUDModeText;
//                HUD.labelText = [NSString stringWithFormat:@"加载第%d页",currentPage+1];
//                [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//            }
//        }
        
        int y = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height;
        if (y < 50 && !isLoadingMore)
        {
            [self gettingDataAt:currentPage+1];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if([scrollView isEqual:mainScroll])
    {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark - task
- (void)myTask {
    sleep(1);
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"";
    [self getDataAt:goingPage];
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
    currentPage = goingPage;
	[HUD removeFromSuperview];
	HUD = nil;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
//    [self.result removeAllObjects];
    [self gettingDataAt:1];

	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    [table scrollRectToVisible:CGRectMake(0, 0, 320, 20) animated:NO];
    currentPage = 1;
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mainScroll];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.5];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    table = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end


