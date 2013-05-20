//
//  DoubanViewController.m
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "DoubanViewController.h"
#import "Project.h"
#import "DoubanCell.h"
#import "DoubanItem.h"
#import "NIWebController.h"

@interface DoubanViewController ()

@end

@implementation DoubanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"豆瓣趣文";
    self.navigationController.navigationBar.tintColor = getColor(43, 133, 25, 1);
    self.navigationItem.rightBarButtonItem = HDBarButtonWithImage(@"pin_32x32_green", CGSizeMake(16,16), self, @selector(gotoPage:));
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self commonInitWithTabbar];
    
    [self initPiker];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mobClickBeginLogPageView(self.navigationItem.title);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    mobClickEndLogPageView(self.navigationItem.title);
}

#pragma mark - 获取数据
-(void)getDataAt:(int)page
{
    [super getDataAt:page];
    
    [self loadHtml:[NSString stringWithFormat:@"http://www.douban.com/people/guyi/notes?start=%d", (page-1)*10]];
    isLoadingMore= NO;
}

-(void) refreshData:(UIButton*)btn
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [btn removeFromSuperview];
    });
    [self getDataAt:goingPage];
}

#pragma mark - html parse
-(void)loadHtml:(NSString*)url {
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:url];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    //    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //    NSString *retStr = [[NSString alloc] initWithData:tutorialsHtmlData encoding:enc];
    //    tutorialsHtmlData = [retStr dataUsingEncoding:NSUnicodeStringEncoding];
    //
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='article']/div";
    
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    if(tutorialsNodes==nil || tutorialsNodes.count==0)
    {
        if(nilCount>3)
        {
            nilCount = 0;
            [self getDataAt:goingPage=1];
        }
        else{
            nilCount++;
            setRefreshButton(self.view, table.frame, self, @selector(refreshData:));
        }
        return;
    }
    // 4
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in tutorialsNodes) {
        if([[element.attributes objectForKey:@"id"] hasPrefix:@"note-"])
        {
            NSString *title = @"";
            NSString *href = @"";
            NSString *date = @"";
            NSString *brief = @"";
            TFHppleElement *titleElement = [[[[element firstChildWithTagName:@"div"] firstChildWithClassName:@"wrap"] firstChildWithTagName:@"h3"] firstChildWithTagName:@"a"];
            if(titleElement)
            {
                title = [titleElement.attributes objectForKey:@"title"];
                href = [titleElement.attributes objectForKey:@"href"];
            }
            TFHppleElement *dateElement = [[[[element firstChildWithTagName:@"div"] firstChildWithTagName:@"div"] firstChildWithTagName:@"span"] firstChildWithTagName:@"text"];
            if(dateElement)
            {
                date = dateElement.content;
            }
            TFHppleElement *briefElement = [[element firstChildWithClassName:@"note"] firstChildWithTagName:@"text"];
            if(briefElement)
            {
                brief = briefElement.content;
            }
            if(href.length>0)
            {
                DoubanItem *item = [[DoubanItem alloc] init];
                item.title = title;
                item.pid = href;
                item.href = href;
                item.date = date;
                item.brief = brief;
                [newTutorials addObject:item];
            }
        }
    }
    
    // 8
    if(self.result&&self.result.count>0 && newTutorials.count>0)
    {
        [self.result addObjectsFromArray:newTutorials];
    }
    else self.result = newTutorials;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [table reloadData];
        [table setNeedsDisplay];
    });
    isLoadingMore=NO;
    if(isGoingPage)
    {
        [table scrollRectToVisible:CGRectMake(0, 0, 320, 20) animated:NO];
        isGoingPage = NO;
    }
}

#pragma mark - table事件
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DoubanCell *cell = (DoubanCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (DoubanCell *)[[[UINib nibWithNibName:@"CommonUI" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect frame = cell.frame;
        frame.size.width = self.view.frame.size.width;
        cell.frame = frame;
    }
    
    hidingIndex = indexPath.row;
    DoubanItem *item = [self.result objectAtIndex:indexPath.row];
    
    [cell full:item.title date:item.date brief:item.brief href:item.href];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoubanItem *item = [self.result objectAtIndex:indexPath.row];
    
    NIWebController* webController = [[NIWebController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBriefUrlHeader, item.href]]];
    webController.toolbarTintColor = self.navigationController.navigationBar.tintColor;
    webController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webController
                                         animated:YES];
}

#pragma mark - piker
-(void)initPiker
{
    CGSize size = table.bounds.size;
    self.pikerView = (commonPikerView *)[[[UINib nibWithNibName:@"CommonUI" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
    self.pikerView.hidden = YES;
    self.pikerView.delegate = self;
    self.pikerView.piker.dataSource =self.pikerView;
    self.pikerView.piker.delegate = self.pikerView;
    self.pikerView.frame = CGRectMake(0.0f, size.height - 259, size.width, 259);
    
    [self.view addSubview:self.pikerView];
}

-(void)pikerCancel{
    self.pikerView.hidden = YES;
    [table setScrollEnabled:YES];
}

-(void)pikerGo:(int)page{
    [self pikerCancel];
    [self.result removeAllObjects];
    isGoingPage = YES;
    [self gettingDataAt:page];
}

-(void)gotoPage:(UIButton*)sender
{
    self.pikerView.hidden = NO;
    [table setScrollEnabled:NO];
}

#pragma mark - alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1000&&buttonIndex==1)
    {
        [self getDataAt:goingPage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
