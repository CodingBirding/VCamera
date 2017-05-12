//
//  ToolBarView.h
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"
#import "UIImageView+AutoHighlighted.h"
#import "ToolDetailView.h"

@interface ToolBarView : UIView

@property (nonatomic, copy) BoolBlockType lightBlock;
@property (nonatomic, copy) BoolBlockType lineBlock;
@property (nonatomic, copy) VoidBlockType timerBlock;
@property (nonatomic, copy) VoidBlockType lianpaiBlock;
@property (nonatomic, copy) VoidBlockType lvjingBlock;
@property (nonatomic, copy) VoidBlockType settingBlock;


@property (nonatomic, retain) ToolDetailView* settingView;
@property (nonatomic, retain) ToolDetailView* timerView;
@property (nonatomic, retain) ToolDetailView* lianpaiView;
@property (nonatomic, retain) ToolDetailView* lvjingView;

@property (nonatomic, assign) BOOL isVisible;

@property (nonatomic, assign) BOOL isLineOn;
@property (nonatomic, assign) BOOL isLightOn;

@end
