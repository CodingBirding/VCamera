//
//  AttachBaseView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/8.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "AttachBaseView.h"

@interface AttachBaseView ()
@property (nonatomic, retain) UIImageView *transformImageView;

@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGPoint transformPoint;

@property (nonatomic) CGPoint originTransPoint;

@property (nonatomic) CGFloat lastAngle;
@property (nonatomic) CGFloat lastDistance;

@end

@implementation AttachBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isEditing = YES;
        
        self.Vctl = [[UIViewController alloc] init];
        
        self.deletImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        self.deletImageView.userInteractionEnabled = YES;
        self.deletImageView.backgroundColor = [UIColor clearColor];
        self.deletImageView.image = [UIImage imageNamed:@"delete"];
        [self addSubview:self.deletImageView];
        
//        self.transformImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)-30, 30, 30)];
//        self.transformImageView.userInteractionEnabled = YES;
//        self.transformImageView.layer.cornerRadius = 15;
//        self.transformImageView.clipsToBounds = YES;
//        self.transformImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
//        self.transformImageView.layer.borderWidth = 1;
//        self.transformImageView.backgroundColor = [UIColor clearColor];
//        self.transformImageView.image = [UIImage imageNamed:@"transform"];
//        [self addSubview:self.transformImageView];
        
        self.centerPoint = self.center;
        self.transformPoint = CGPointMake(self.center.x+75, self.center.y+75);
//        self.transformPoint = self.transformImageView.center;
        self.originTransPoint = self.transformPoint;
//        self.lastDistance = [self distanceFromPointX:self.centerPoint distanceToPointY:self.originTransPoint];
        
        self.biankuangView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)-30)];
        self.biankuangView.layer.borderColor = [default_light_blue CGColor];
        self.biankuangView.layer.borderWidth = 1;
        [self addSubview:self.biankuangView];
        
        UITapGestureRecognizer *deleteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [self.deletImageView addGestureRecognizer:deleteGesture];
        
//        UIPanGestureRecognizer *transformGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(transform:)];
//        [self.transformImageView addGestureRecognizer:transformGesture];
        
        UIPanGestureRecognizer *yidongGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panShape:)];
        [self addGestureRecognizer:yidongGesture];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchShape:)];
        [self addGestureRecognizer:pinchGesture];
        
        UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateShape:)];
        [self addGestureRecognizer:rotateGesture];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.originTransPoint = CGPointMake(self.center.x+75, self.center.y+75);
    self.centerPoint = self.center;    
    self.deletImageView.frame = CGRectMake(0, 0, 25, 25);

}

- (void) remove
{
    NSLog(@"删除");
    [self removeFromSuperview];
}

//- (void) transform: (UIGestureRecognizer *)sender
//{
//    CGFloat originDistance;
//    if (sender.state == UIGestureRecognizerStateBegan) {
//       //开始之前记录一下原始位置，计算一下原始距离
//        originDistance = [self distanceFromPointX:self.centerPoint distanceToPointY:self.originTransPoint];
//    }
//    
//    //获取实时的位置
//    CGPoint touchPoint = [sender locationInView:self.Vctl.view];
//    
//    //计算实时距离
//    CGFloat distance = [self distanceFromPointX:self.centerPoint distanceToPointY:touchPoint];
//    
//    //计算缩放比例
//    CGFloat bili = distance/_lastDistance;
//    
//    //计算旋转角度
//    CGFloat angle = getRotateAngle(self.originTransPoint.x-self.center.x, self.originTransPoint.y-self.center.y, touchPoint.x-self.center.x, touchPoint.y-self.center.y);
//    
////    self.transform = CGAffineTransformMakeScale(bili, bili);
//    self.transform = CGAffineTransformRotate(self.transform, angle-self.lastAngle);
//    self.lastAngle = angle;
//    self.lastDistance = distance;
//    
//}
//
//-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
//    float distance;
//    CGFloat xDist = (end.x - start.x);
//    CGFloat yDist = (end.y - start.y);
//    distance = sqrt((xDist * xDist) + (yDist * yDist));
//    return distance;
//}
//
//double getRotateAngle(double x1, double y1, double x2, double y2)
//{
//    const double epsilon = 1.0e-6;
//    const double nyPI = acos(-1.0);
//    double dist, dot, degree, angle;
//    
//    // normalize
//    dist = sqrt( x1 * x1 + y1 * y1 );
//    x1 /= dist;
//    y1 /= dist;
//    dist = sqrt( x2 * x2 + y2 * y2 );
//    x2 /= dist;
//    y2 /= dist;
//    // dot product
//    dot = x1 * x2 + y1 * y2;
//    if ( fabs(dot-1.0) <= epsilon )
//        angle = 0.0;
//    else if ( fabs(dot+1.0) <= epsilon )
//        angle = nyPI;
//    else {
//        double cross;
//        
//        angle = acos(dot);
//        //cross product
//        cross = x1 * y2 - x2 * y1;
//        // vector p2 is clockwise from vector p1
//        // with respect to the origin (0.0)
//        if (cross < 0 ) {
//            angle = 2 * nyPI - angle;
//        }    
//    }
//    degree = angle *  180.0 / nyPI;
//    return angle;
//}

- (void) yidong:(UIGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView:self.Vctl.view];
    self.center = touchPoint;
}

- (void) pinchShape: (UIPinchGestureRecognizer *) pinchGestureRecognizer
{
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        self.transform = CGAffineTransformScale(self.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        [pinchGestureRecognizer setScale:1];
    }
}

- (void) rotateShape: (UIRotationGestureRecognizer *) rotateGestureRecognizer
{
    if (rotateGestureRecognizer.state == UIGestureRecognizerStateBegan || rotateGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        self.transform = CGAffineTransformRotate(self.transform, rotateGestureRecognizer.rotation);
        [rotateGestureRecognizer setRotation:0];
    }
}

- (void) panShape: (UIPanGestureRecognizer *) panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged || panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint translation = [panGestureRecognizer translationInView:self.superview];
        [self setCenter:CGPointMake(self.center.x + translation.x, self.center.y + translation.y)];
        
        [panGestureRecognizer setTranslation:CGPointZero inView:self.superview];
        
    }
}
@end
