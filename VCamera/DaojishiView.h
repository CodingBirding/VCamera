//
//  DaojishiView.h
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"


@interface DaojishiView : UIView

@property (nonatomic, copy) VoidBlockType timeOver;

- (void)setTime: (int)timerNumber;



@end
