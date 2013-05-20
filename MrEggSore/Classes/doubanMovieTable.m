//
//  doubanMovieTable.m
//  doubanMovie
//
//  Created by Simon on 13-5-20.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "doubanMovieTable.h"
#import "Project.h"
#import "doubanMovieCell.h"
@interface doubanMovieTable ()

@end

@implementation doubanMovieTable

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
    self.navigationItem.title = @"Top250";
    self.navigationController.navigationBar.tintColor = getColor(43, 133, 25, 1);
    self.navigationItem.rightBarButtonItem = HDBarButtonWithImage(@"pin_32x32_green", CGSizeMake(16,16), self, @selector(gotoPage:));
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self commonInitWithTabbar];
    
    [self initPiker];
}

#pragma mark - 获取数据
-(void)getDataAt:(int)page
{
    [super getDataAt:page];

    [Project requestTop250WithBlock:page block:^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            if(self.result&&self.result.count>0 && posts.count>0)
            {
                if(goingPage==1)    [self.result removeAllObjects];
                
                [self.result addObjectsFromArray:posts];
            }
            else
            {
                self.result = [[NSMutableArray alloc] initWithCapacity:0];
                [self.result addObjectsFromArray:posts];
            }
            
            [table reloadData];
            [table setNeedsDisplay];
        }
    }];
    
    if(page<13)isLoadingMore= NO;
}

#pragma mark - table事件
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    doubanMovieCell *cell = (doubanMovieCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (doubanMovieCell *)[[[UINib nibWithNibName:@"CommonUI" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect frame = cell.frame;
        frame.size.width = self.view.frame.size.width;
        cell.frame = frame;
    }
    
    NSDictionary *item = [self.result objectAtIndex:indexPath.row];
    
    [cell full:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

-(int)numberOfRows
{
    return 13;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
