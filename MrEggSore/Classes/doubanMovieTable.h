//
//  doubanMovieTable.h
//  doubanMovie
//
//  Created by Simon on 13-5-20.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "PageingViewController.h"
#import "commonPikerView.h"

@interface doubanMovieTable : PageingViewController<commonPikerDelegate>
{
    BOOL isGoingPage;
}
@property(nonatomic,assign)commonPikerView*pikerView;

@end
