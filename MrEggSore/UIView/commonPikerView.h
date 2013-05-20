//
//  commonPikerView.h
//  mmBox
//
//  Created by Simon on 13-4-20.
//  Copyright (c) 2013年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol commonPikerDelegate <NSObject>

-(void)pikerCancel;
-(void)pikerGo:(int)page;
@optional
-(int)numberOfRows;
@end

@interface commonPikerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,retain) id<commonPikerDelegate> delegate;


@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnGo;
@property (retain, nonatomic) IBOutlet UIPickerView *piker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *spaceItem;
@end
