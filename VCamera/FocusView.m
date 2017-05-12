//
//  FocusView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FocusView.h"
#import "BaseDefines.h"
@interface FocusView()

@property (nonatomic, retain) UIImageView *image;

@end

@implementation FocusView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 60, 60);
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(5, 5)];
        [path addLineToPoint:CGPointMake(55, 5)];
        [path addLineToPoint:CGPointMake(55, 55)];
        [path addLineToPoint:CGPointMake(5, 55)];
        [path addLineToPoint:CGPointMake(5, 5)];
        
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 2;
        
        shapeLayer.fillColor = [[UIColor colorWithRed:1 green:1 blue:1 alpha:0] CGColor];
        
        [self.layer addSublayer:shapeLayer];
    }
    return self;
}

- (void) setPoint: (CGPoint)point inView: (UIView *)targetView
{
    [self setCenter:point];
    [targetView addSubview:self];
    self.alpha = 1;
    
    WEAKSELF
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}

@end
