//
//  ToolDetailView.h
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ToolTypeTimer 0
#define ToolTypeLianpai 1
#define ToolTypeLvjing 2
#define ToolTypeSetting 3




@interface ToolDetailView : UIView

@property (nonatomic, assign) BOOL isFaceDetectOn;
@property (nonatomic, assign) int timerValue;
@property (nonatomic, assign) int lianpaiValue;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int filterPtr;


- (instancetype)initWithFrame:(CGRect)frame Type:(int) type;

@end
