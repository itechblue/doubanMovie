//
//  commonPikerView.m
//  mmBox
//
//  Created by Simon on 13-4-20.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import "commonPikerView.h"

@implementation commonPikerView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (IBAction)btnCancelClick:(id)sender {
    if(delegate)
    {
        [delegate pikerCancel];
    }
}

- (IBAction)btnGoClick:(id)sender {
    if(delegate)
    {
        [delegate pikerGo:[self.piker selectedRowInComponent:0]+1];
    }
}
#pragma mark - picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(delegate && [delegate respondsToSelector:@selector(numberOfRows)])
    {
        return [delegate numberOfRows];
    }
    else return 100;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"第%d页", row+1];
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    
}

@end
