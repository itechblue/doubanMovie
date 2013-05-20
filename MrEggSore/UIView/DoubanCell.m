//
//  DoubanCell.m
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import "DoubanCell.h"

@implementation DoubanCell

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

-(void)full:(NSString*)title date:(NSString*)date brief:(NSString*)brief href:(NSString*)href
{
    self.lblTitle.text = title;
    tmpPid = href;
    
    self.lblDate.text = date;
    self.lblBrief.text = brief;
}
@end
