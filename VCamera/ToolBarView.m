//
//  ToolBarView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ToolBarView.h"
#import "BaseDefines.h"

#define buttonWidth 24
#define narrowHeight 20
#define spaceWidth (self.frame.size.width - 6*24) / 7
@interface ToolBarView()

@property (nonatomic, retain) UIImageView *lightImageView;
@property (nonatomic, retain) UIImageView *lineImageView;
@property (nonatomic, retain) UIImageView *timerImageView;
@property (nonatomic, retain) UIImageView *lianpaiImageView;
@property (nonatomic, retain) UIImageView *lvjingImageView;
@property (nonatomic, retain) UIImageView *settingImageView;
@property (nonatomic, retain) UIImageView *narrowImageView;



@end

@implementation ToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isLineOn = NO;
        self.isLightOn = NO;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.isVisible = NO;
//        self.narrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-18, 5, 36, 15)];
//        self.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
//        [self addSubview:self.narrowImageView];
        
        
        self.lightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth, kLeftSpace, buttonWidth, buttonWidth)];
        self.lightImageView.image = [UIImage imageNamed:@"闪光灯开关"];
//        self.lightImageView.highlightedImage = [UIImage imageNamed:@"闪光灯开关0"];
        self.lightImageView.userInteractionEnabled = YES;
        self.lightImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.lightImageView];
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth*2+buttonWidth*1, kLeftSpace, buttonWidth, buttonWidth)];
        self.lineImageView.image = [UIImage imageNamed:@"参考线开关"];
//        self.lineImageView.highlightedImage = [UIImage imageNamed:@"参考线开关0"];
        self.lineImageView.userInteractionEnabled = YES;
        [self addSubview:self.lineImageView];
        
        self.timerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth*3+buttonWidth*2, kLeftSpace, buttonWidth, buttonWidth)];
        self.timerImageView.image = [UIImage imageNamed:@"计时器开关"];
        self.timerImageView.highlightedImage = [UIImage imageNamed:@"计时器开关0"];
        self.timerImageView.userInteractionEnabled = YES;
        [self addSubview:self.timerImageView];
        
        self.lianpaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth*4+buttonWidth*3, kLeftSpace, buttonWidth, buttonWidth)];
        self.lianpaiImageView.image = [UIImage imageNamed:@"连拍开关"];
        self.lianpaiImageView.highlightedImage = [UIImage imageNamed:@"连拍开关0"];
        self.lianpaiImageView.userInteractionEnabled = YES;
        [self addSubview:self.lianpaiImageView];
        
        self.lvjingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth*5+buttonWidth*4, kLeftSpace, buttonWidth, buttonWidth)];
        self.lvjingImageView.image = [UIImage imageNamed:@"滤镜-1"];
        self.lvjingImageView.userInteractionEnabled = YES;
        [self addSubview:self.lvjingImageView];
        
        self.settingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceWidth*6+buttonWidth*5, kLeftSpace, buttonWidth, buttonWidth)];
        self.settingImageView.image = [UIImage imageNamed:@"更多"];
        self.settingImageView.userInteractionEnabled = YES;
        self.lightImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.settingImageView];
        
        UITapGestureRecognizer *tapLightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLight)];
        [self.lightImageView addGestureRecognizer:tapLightGesture];
        
        UITapGestureRecognizer *tapLineGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLine)];
        [self.lineImageView addGestureRecognizer:tapLineGesture];
        
        UITapGestureRecognizer *tapTimerGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTimer)];
        [self.timerImageView addGestureRecognizer:tapTimerGesture];
        
        UITapGestureRecognizer *tapLianPaiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLianPai)];
        [self.lianpaiImageView addGestureRecognizer:tapLianPaiGesture];
        
        UITapGestureRecognizer *tapLvjingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLvjing)];
        [self.lvjingImageView addGestureRecognizer: tapLvjingGesture];
        
        UITapGestureRecognizer *tapSettingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSetting)];
        [self.settingImageView addGestureRecognizer:tapSettingGesture];
        
        
        
    }
    return self;
}

- (void) tapLight
{
    if (self.lightBlock)
    {
        self.lightBlock(self.isLightOn);
    }
    
    if (self.isLightOn)
    {
        self.lightImageView.image = [UIImage imageNamed:@"闪光灯开关"];
    }else
    {
        self.lightImageView.image = [UIImage imageNamed:@"闪光灯开关0"];
    }
    self.isLightOn = !self.isLightOn;
    
}

- (void) tapLine
{
    NSLog(@"点击了参考线");
    
    if (self.isLineOn)
    {
        self.lineImageView.image = [UIImage imageNamed:@"参考线开关"];
    }else
    {
        self.lineImageView.image = [UIImage imageNamed:@"参考线开关0"];
    }
    
    if (self.lineBlock)
    {
        self.lineBlock(self.isLineOn);
    }
    self.isLineOn = !self.isLineOn;
}

- (void) tapTimer
{
    if (self.timerBlock)
    {
        self.timerBlock();
    }
    NSLog(@"按了计时器");
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[ToolDetailView class]]) {
            subView.alpha = 0;
        }
    }
    
    self.timerView = [self viewWithTag:ToolDetailView_tag+1];
    
    if (self.timerView) {
        self.timerView.alpha = 1;
    }else
    {
        self.timerView = [[ToolDetailView alloc] initWithFrame:CGRectMake(0, 2*kLeftSpace+buttonWidth, CGRectGetWidth(self.frame), 50) Type:ToolTypeTimer];
        self.timerView.tag = ToolDetailView_tag+1;
        [self addSubview:self.timerView];
    }
    
    
}

- (void) tapLianPai
{
    if (self.lianpaiBlock)
    {
        self.lianpaiBlock();
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[ToolDetailView class]]) {
            subView.alpha = 0;
        }
    }
    
    self.lianpaiView = [self viewWithTag:ToolDetailView_tag+2];
    
    if (self.lianpaiView) {
        self.lianpaiView.alpha = 1;
    }else
    {
        self.lianpaiView = [[ToolDetailView alloc] initWithFrame:CGRectMake(0, 2*kLeftSpace+buttonWidth, CGRectGetWidth(self.frame), 50) Type:ToolTypeLianpai];
        self.lianpaiView.tag = ToolDetailView_tag+2;
        [self addSubview:self.lianpaiView];

    }
}

- (void) tapLvjing
{
    if (self.lvjingBlock)
    {
        self.lvjingBlock();
    }
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[ToolDetailView class]]) {
            subView.alpha = 0;
        }
    }
    
    self.lvjingView = [self viewWithTag:ToolDetailView_tag+4];
    if (self.lvjingView) {
        self.lvjingView.alpha = 1;
    }else
    {
        self.lvjingView = [[ToolDetailView alloc] initWithFrame:CGRectMake(0, 2*kLeftSpace+buttonWidth, CGRectGetWidth(self.frame), 50) Type:ToolTypeLvjing];
        self.lvjingView.tag = ToolDetailView_tag+4;
        [self addSubview:self.lvjingView];
    }
    
    
    
}

- (void) tapSetting
{
    if (self.settingBlock)
    {
        self.settingBlock();
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[ToolDetailView class]]) {
            subView.alpha = 0;
        }
    }
    
    self.settingView = [self viewWithTag:ToolDetailView_tag+3];
    
    if (self.settingView) {
        self.settingView.alpha = 1;
    }else
    {
        self.settingView = [[ToolDetailView alloc] initWithFrame:CGRectMake(0, 2*kLeftSpace+buttonWidth, CGRectGetWidth(self.frame), 50) Type:ToolTypeSetting];
        self.settingView.tag = ToolDetailView_tag+3;
        [self addSubview:self.settingView];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸toolbar");
}
@end
