//
//  chooseView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ChooseView.h"

@interface ChooseView()

@property (nonatomic, retain) NSMutableArray *images;
//@property (nonatomic, assign) BOOL anLe;
@property (nonatomic, assign) int photoNumber;

@property (nonatomic, retain) UIView *ganzhiView;


@end

@implementation ChooseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.originImages = [[NSMutableArray alloc] init];
        self.images = [[NSMutableArray alloc] init];
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
        self.ganzhiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 510)];
        [self addSubview:self.ganzhiView];
        
        self.selectedImage = [[UIImage alloc] init];
        self.selectedOriginImage = [[UIImage alloc] init];
        NSLog(@"init完成");
    }
    return self;
}

- (void)setNeedPhotoNumber: (int)photoNumbers
{
    self.originImages = self.originImageArrayBlock();
        self.images = self.imageArrayBlock();
        self.jishu = 0;
        self.photoNumber = photoNumbers;
        
    
        
        
        for (int i = 0; i < photoNumbers; i++)
        {
            UIImageView *zhanshiTuView =  [[UIImageView alloc] init];
            
            zhanshiTuView.tag = 100 + i;
            zhanshiTuView.image = self.images[i];
            zhanshiTuView.highlightedImage = self.originImages[i];
            [self setImageViewPosition:zhanshiTuView];
            zhanshiTuView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
            [self.ganzhiView addSubview:zhanshiTuView];
        }
        
    
        UISwipeGestureRecognizer *tuHuadongRight;
        UISwipeGestureRecognizer *tuHuadongLeft;
        UISwipeGestureRecognizer *tuHuadongUp;
        
        // 设置互动手势
        tuHuadongLeft  = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePhotoLeft)];
        tuHuadongRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePhotoRight)];
        tuHuadongUp    = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipePhotoUp)];
        
        tuHuadongUp.direction     = UISwipeGestureRecognizerDirectionUp;
        tuHuadongRight.direction  = UISwipeGestureRecognizerDirectionRight;
        tuHuadongLeft.direction   = UISwipeGestureRecognizerDirectionLeft;
        
        [self.ganzhiView addGestureRecognizer:tuHuadongUp];
        [self.ganzhiView addGestureRecognizer:tuHuadongLeft];
        [self.ganzhiView addGestureRecognizer:tuHuadongRight];
        
        
        // 设置确定按钮
        
        UIImageView *quedingView = [[UIImageView alloc] initWithFrame:CGRectMake(163, 576, 50, 50)];
        quedingView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        quedingView.image = [UIImage imageNamed:@"queding"];
        quedingView.userInteractionEnabled = YES;
        quedingView.highlightedImage = [UIImage imageNamed:@"quding0"];
        
        UITapGestureRecognizer *quedingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextStep)];
        quedingTap.cancelsTouchesInView = NO;
        [quedingView addGestureRecognizer:quedingTap];
        [self addSubview:quedingView];
        
        
        
        
    
    
}

- (void)setImageViewPosition: (UIImageView *) zhanshitu
{
    int i = zhanshitu.tag - 100;
    CGRect tuRect = CGRectMake(83 + i * 245, 110, 225, 300) ;
    zhanshitu.frame = tuRect;
}


-(void)swipePhotoLeft
{

    if (self.jishu < self.photoNumber - 1)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            for (int i = 0; i < self.photoNumber; i++)
            {
                [self.ganzhiView viewWithTag:(i + 100 - self.jishu)].tag -= 1;
                int m = (int)[self.ganzhiView viewWithTag:(i + 99 - self.jishu)].tag - 100;
                CGRect tuRect = CGRectMake(83 + m * 245, 110, 225, 300);
                [self.ganzhiView viewWithTag:(i + 99 - self.jishu)].frame = tuRect;
            }
            
        }];
        self.jishu++;
    }
    [self refreshSubView];

}

- (void)swipePhotoRight
{

    if ( self.jishu > 0)
    {
        [UIView animateWithDuration:0.6 animations:^{
            NSLog(@"右边滑了");
            
            for (int i = self.photoNumber-1; i >= 0; i--)
            {
                [self.ganzhiView viewWithTag:(i + 100 - self.jishu)].tag += 1;
                NSLog(@"%f, %f", [self.ganzhiView viewWithTag:(i + 101 - self.jishu)].frame.origin.x,[self.ganzhiView viewWithTag:(i + 101 - self.jishu)].frame.origin.y);
                
                int m = (int)[self.ganzhiView viewWithTag:(i + 101 - self.jishu)].tag - 100;
                CGRect tuRect = CGRectMake(83 + m * 245, 110, 225, 300);
                [self.ganzhiView viewWithTag:(i + 101 - self.jishu)].frame = tuRect;
                //
            }
        }];
        self.jishu--;
    }
    [self refreshSubView];

    
}

- (void)swipePhotoUp
{
    if (self.photoNumber > 0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect tempRect = [self.ganzhiView viewWithTag:100].frame;
            tempRect.origin.y = -400;
            [self.ganzhiView viewWithTag:100].frame = tempRect;
            [self.ganzhiView viewWithTag:100].tag = 10000;
            
            [UIView animateWithDuration:0.5 animations:^{
                for (int i = self.jishu + 1; i < self.photoNumber; i++)
                {
                    [self.ganzhiView viewWithTag:(i + 100 - self.jishu)].tag -= 1;
                    int m = (int)[self.ganzhiView viewWithTag:(i + 99 - self.jishu)].tag - 100;
                    CGRect tuRect = CGRectMake(83 + m * 245, 110, 225, 300);
                    [self.ganzhiView viewWithTag:(i + 99 - self.jishu)].frame = tuRect;
                }
                
            }];
            
        }];
        self.photoNumber --;
        if (self.photoNumber == 0)
        {
            [self performSelector:@selector(yichuView) withObject:self afterDelay:0.5];
        }
        // 如果移除了最后一张照片
        if (self.photoNumber >= 1 && [self.ganzhiView viewWithTag:100] == NULL)
        {
            [UIView animateWithDuration:0.5 animations:^{
                for (int i = 0; i < self.jishu; i++)
                {
                    [self.ganzhiView viewWithTag:(100 - i - 1)].tag += 1;
                    CGRect tuRect = CGRectMake(83 - i * 245, 110, 225, 300);
                    [self.ganzhiView viewWithTag:(100 - i)].frame = tuRect;
                }
                
            }];
            self.jishu--;
            
        }
    }
    [self refreshSubView];

}

- (void)yichuView
{
    self.hidden = YES;
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self removeFromSuperview];
    
}

- (void) nextStep
{
    
    
    if (self.confirmBlock)
    {

        self.confirmBlock();
    }
    
}

- (void) layoutSubviews
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:100];
    
    self.selectedImage = imageView.image;
    self.selectedOriginImage = imageView.highlightedImage;
}

- (void) refreshSubView
{
   UIImageView *imageView = (UIImageView *)[self viewWithTag:100];
    
    self.selectedImage = imageView.image;
    self.selectedOriginImage = imageView.highlightedImage;

}

- (UIViewController *)getViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
