//
//  UIImageView + AutoHighlighted.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "UIImageView+AutoHighlighted.h"
#define buttonTimeInterval 0.2

@implementation UIImageView(AutoHighlited)


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self performSelector:@selector(setNotHighlighted) withObject:nil afterDelay:buttonTimeInterval];
}

-(void) setNotHighlighted
{
    self.highlighted = NO;
}


@end
