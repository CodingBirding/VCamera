//
//  LineView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 设置参考线
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        CGFloat cankao_x1 = self.frame.size.width / 3;
        CGFloat cankao_x2 = self.frame.size.width * 2 / 3;
        CGFloat cankao_y1 = self.frame.size.height / 3;
        CGFloat cankao_y2 = self.frame.size.height * 2 / 3;
        
        UIBezierPath *path1 = [[UIBezierPath alloc] init];
        
        [path1 moveToPoint:CGPointMake(0, cankao_y1)];
        [path1 addLineToPoint:CGPointMake(self.frame.size.width, cankao_y1)];
        [path1 moveToPoint:CGPointMake(0, cankao_y2)];
        [path1 addLineToPoint:CGPointMake(self.frame.size.width, cankao_y2)];
        [path1 moveToPoint:CGPointMake(cankao_x1, 0)];
        [path1 addLineToPoint:CGPointMake(cankao_x1, self.frame.size.height)];
        [path1 moveToPoint:CGPointMake(cankao_x2, 0)];
        [path1 addLineToPoint:CGPointMake(cankao_x2, self.frame.size.height)];
        
        lineLayer.path = [path1 CGPath];
        lineLayer.strokeColor = [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
        lineLayer.lineWidth = 0.5;
        lineLayer.backgroundColor = [[UIColor redColor] CGColor];
        
        [self.layer addSublayer:lineLayer];
        
        
    }
    return self;
}

@end
