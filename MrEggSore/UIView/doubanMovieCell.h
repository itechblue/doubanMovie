//
//  doubanMovieCell.h
//  doubanMovie
//
//  Created by Simon on 13-5-20.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doubanMovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOrigin;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblPoint;
@property (weak, nonatomic) IBOutlet UIImageView *imgCover;

-(void)full:(NSDictionary*)info;
@end
