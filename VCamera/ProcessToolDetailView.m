//
//  ProcessToolDetailView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/6.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ProcessToolDetailView.h"

@interface ProcessToolDetailView()

@property (nonatomic, retain) UISlider *mySlider;
@property (nonatomic) CGRect originalRect;



@end

@implementation ProcessToolDetailView

- (instancetype)initWithFrame:(CGRect)frame withType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.originalRect = frame;
        self.type = type;
        self.duibiC = 1;
        self.baoheC = 1;
        self.baoguangC = 1;
    
        
        switch (type) {
            case ProcessType_Duibi:
            {
                self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(self.frame)-60, 60)];
                self.mySlider.minimumValue = 0.6;
                self.mySlider.maximumValue = 1.8;
                [self.mySlider setMinimumTrackImage:[UIImage imageNamed:@"slider0"] forState:UIControlStateNormal];
                [self.mySlider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
                self.mySlider.value = 1;
                [self addSubview:self.mySlider];
                [self.mySlider addTarget:self action:@selector(layoutSubviews) forControlEvents:UIControlEventValueChanged];
                
            }
                break;
            case ProcessType_Baoguang:
            {
                NSLog(@"初始化曝光");
                self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(self.frame)-60, 60)];
                self.mySlider.minimumValue = 0.5;
                self.mySlider.maximumValue = 1.5;
                [self.mySlider setMinimumTrackImage:[UIImage imageNamed:@"slider0"] forState:UIControlStateNormal];
                [self.mySlider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
                self.mySlider.value = 1;
                [self addSubview:self.mySlider];
                [self.mySlider addTarget:self action:@selector(layoutSubviews) forControlEvents:UIControlEventValueChanged];
                
            }
                break;
            case ProcessType_Baohe:
            {
                self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(self.frame)-60, 60)];
                self.mySlider.minimumValue = 0.5;
                self.mySlider.maximumValue = 1.5;
                [self.mySlider setMinimumTrackImage:[UIImage imageNamed:@"slider0"] forState:UIControlStateNormal];
                [self.mySlider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
                self.mySlider.value = 1;
                [self addSubview:self.mySlider];
                [self.mySlider addTarget:self action:@selector(layoutSubviews) forControlEvents:UIControlEventValueChanged];
            }
                break;
            case ProcessType_Lvjing:
            {
                self.scrollView = [[FilterCoverScrollView alloc] initWithFrame:CGRectMake(0, 2.5, frame.size.width, frame.size.height)];
                [self addSubview:self.scrollView];
            }
                break;
            case ProcessType_Tiezhi:
            {
                
            }
                break;
            default:
                break;
        }
        
        
        
    }
    return self;
}

- (void) layoutSubviews

{
    NSLog(@"layoutSubviews,%d", self.type);
    switch (self.type) {
        case ProcessType_Duibi:
        {
            self.duibiC = self.mySlider.value;
            if (self.duibiBlcok)
            {
                NSLog(@"改变对比度为，%f", self.duibiC);
                self.duibiBlcok(self.duibiC);
            }
            
        }
            break;
        case ProcessType_Baoguang:
        {
            self.baoguangC = self.mySlider.value;
            if (self.baoguangBlock) {
                NSLog(@"改变对比度为，%f", self.duibiC);
                self.baoguangBlock(self.baoguangC);
            }
        }
            break;
        case ProcessType_Baohe:
        {
            self.baoheC = self.mySlider.value;
            if (self.baoheBlock) {
                self.baoheBlock(self.baoheC);
            }
        }
            break;
        case ProcessType_Lvjing:
        {
            
        }
            break;
        case ProcessType_Tiezhi:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void) tanchu
{
    self.frame = CGRectMake(self.originalRect.origin.x, self.originalRect.origin.y-self.frame.size.height, self.frame.size.height, self.frame.size.height);
}

- (void) shouhui
{
    self.frame = self.originalRect;
}

- (void) reset
{
    self.mySlider.value = 1;
}

@end
