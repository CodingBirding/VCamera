//
//  FlashView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FlashView.h"

@implementation FlashView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

- (void)flash
{
    [UIView animateWithDuration:0.2 animations:^
    {
        self.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }];
}

@end
