//
//  DoubanCell.h
//  MrEggSore
//
//  Created by Simon on 13-5-11.
//  Copyright (c) 2013年 itechblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubanCell : UITableViewCell
{
    NSString* tmpPid;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblBrief;

-(void)full:(NSString*)title date:(NSString*)date brief:(NSString*)brief href:(NSString*)href;
@end
