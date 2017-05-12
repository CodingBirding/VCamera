//
//  DaojishiView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "DaojishiView.h"

#define daojishiD 100

@interface DaojishiView()

@property (retain, nonatomic) CAShapeLayer *circleLayer1;
@property (assign, nonatomic) int timerNumber;
@property (nonatomic, retain) UIBezierPath *path1;
@property (nonatomic, retain) UILabel *number;

@property (nonatomic, retain) NSTimer *myTimer;

@end

@implementation DaojishiView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, daojishiD, daojishiD);
        self.backgroundColor = [UIColor clearColor];
        self.circleLayer1 = [[CAShapeLayer alloc] init];
        CAShapeLayer *circleLayer2 = [[CAShapeLayer alloc] init];
        
        self.path1 = [[UIBezierPath alloc] init];
        UIBezierPath *path2 = [[UIBezierPath alloc] init];
        
        [self.path1 addArcWithCenter:CGPointMake(daojishiD/2, daojishiD/2) radius:daojishiD/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        
        self.circleLayer1.path = [self.path1 CGPath];
        self.circleLayer1.backgroundColor = [[UIColor clearColor] CGColor];
        self.circleLayer1.fillColor = [[UIColor clearColor] CGColor];
        
        circleLayer2.backgroundColor = [[UIColor clearColor] CGColor];
        circleLayer2.fillColor = [[UIColor clearColor] CGColor];
        
        [path2 addArcWithCenter:CGPointMake(daojishiD/2, daojishiD/2) radius:daojishiD/2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        
        circleLayer2.path = [path2 CGPath];
        
        self.circleLayer1.strokeColor = [default_light_blue CGColor];
        circleLayer2.strokeColor = [[UIColor colorWithRed:85.00/255 green:85.00/255 blue:85.00/255 alpha:1] CGColor];
        
        self.circleLayer1.lineCap = @"round";
        self.circleLayer1.lineWidth = 3;
        circleLayer2.lineWidth = 3;

        [self.layer addSublayer:circleLayer2];
        [self.layer addSublayer:self.circleLayer1];
        
        //设置倒计时的数字
        self.number = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.number.textColor = default_light_blue;
        self.number.backgroundColor = [UIColor clearColor];
        self.number.textAlignment = NSTextAlignmentCenter;
        self.number.font = [UIFont systemFontOfSize:56];
        [self addSubview:self.number];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [self.number setCenter:CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)];
    NSLog(@"%f, %f", self.number.frame.origin.x, self.number.frame.origin.y);

}


- (void)setTime: (int)timerNumber
{
    self.timerNumber = timerNumber;
    self.hidden = NO;
    [self beginDaojishi];
}

- (void) beginDaojishi
{
    // 圈圈的动画
    CAKeyframeAnimation *daojishiAnimation = [[CAKeyframeAnimation alloc] init];
    daojishiAnimation.keyPath  = @"strokeEnd";
    daojishiAnimation.values   = @[@1, @0];
    daojishiAnimation.keyTimes = @[@0, @1];
    daojishiAnimation.duration = self.timerNumber;
    [self.circleLayer1 addAnimation:daojishiAnimation forKey:nil];
    
    // 中间数字的改变
    if (self.myTimer) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }else
    {
        self.myTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(changeNumber) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSDefaultRunLoopMode];
        [self.myTimer setFireDate:[NSDate distantPast]];
    }
    
}

- (void)changeNumber
{
    self.number.text = [NSString stringWithFormat:@"%d", self.timerNumber];
    self.timerNumber--;
    if (self.timerNumber < 0)
    {
        [self removeFromSuperview];
        [self.myTimer invalidate];
        self.myTimer = nil;
        if (self.timeOver)
        {
            self.timeOver();
        }
        
    }
    
}


@end
