//
//  doubanMovieCell.m
//  doubanMovie
//
//  Created by Simon on 13-5-20.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "doubanMovieCell.h"
#import "UIImageView+WebCache.h"
@implementation doubanMovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)full:(NSDictionary*)info
{
    [self.imgCover setImageWithURL:[NSURL URLWithString:[[info objectForKey:@"images"] objectForKey:@"small"]] placeholderImage:nil];
    self.lblTitle.text = [info objectForKey:@"title"];
    self.lblOrigin.text = [info objectForKey:@"original_title"];
    self.lblYear.text = [info objectForKey:@"year"];
    self.lblPoint.text = [NSString stringWithFormat:@"%d",[[[info objectForKey:@"rating"] objectForKey:@"average"] intValue] ];

}

@end
