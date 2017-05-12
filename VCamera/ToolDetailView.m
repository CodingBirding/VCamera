//
//  ToolDetailView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ToolDetailView.h"
#import "BaseDefines.h"
#import "FilterManager.h"
#import "FilterCoverScrollView.h"


@interface ToolDetailView()

@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) UILabel *myLabel1;
@property (nonatomic, retain) UILabel *myLabel2;
@property (nonatomic, retain) UISwitch *mySwitch1;
@property (nonatomic, retain) UISwitch *mySwitch2;
@property (nonatomic, assign) int filterAmount;
@property (nonatomic, retain) FilterCoverScrollView *scrollView;

@end

@implementation ToolDetailView

- (instancetype)initWithFrame:(CGRect)frame Type:(int) type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.lianpaiValue = 1;
        self.timerValue = 0;
        self.isFaceDetectOn = NO;
        self.filterPtr = 0;
        self.filterAmount = (int)[[FilterManager sharedFilterManager] currentFilterList].count;
        self.backgroundColor = [UIColor clearColor];
        
        switch (type) {
            case ToolTypeTimer:
            {
                self.slider = [[UISlider alloc] initWithFrame:CGRectMake(67, 0, CGRectGetWidth(self.frame)-67-37, 50)];
                self.slider.minimumValue = 0;
                self.slider.maximumValue = 10;
                [self.slider setMinimumTrackImage:[UIImage imageNamed:@"slider0"] forState:UIControlStateNormal];
                [self.slider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
                self.slider.value = 0;
                [self addSubview:self.slider];
                
                self.myLabel1 = [[UILabel alloc] init];
                self.myLabel1.text = @"0秒";
                self.myLabel1.textColor = default_light_blue;
                self.myLabel1.frame = CGRectMake(CGRectGetMinX(self.slider.frame)-35, 16, 50, 17);
                self.myLabel1.textAlignment = NSTextAlignmentLeft;
                [self.myLabel1 setCenter:CGPointMake(self.myLabel1.center.x, self.slider.center.y)];
                [self addSubview:self.myLabel1];
                
                [self.slider addTarget:self action:@selector(layoutSubviews) forControlEvents:UIControlEventValueChanged];
            
                
            }
                break;
                
            case ToolTypeLianpai:
            {
                self.slider = [[UISlider alloc] initWithFrame:CGRectMake(67, 0, CGRectGetWidth(self.frame)-67-37, 50)];
                self.slider.minimumValue = 1;
                self.slider.maximumValue = 9;
                [self.slider setMinimumTrackImage:[UIImage imageNamed:@"slider0"] forState:UIControlStateNormal];
                [self.slider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
                self.slider.value = 1;
                [self addSubview:self.slider];
                
                self.myLabel1 = [[UILabel alloc] init];
                self.myLabel1.text = @"1张";
                self.myLabel1.textColor = default_light_blue;

                self.myLabel1.frame = CGRectMake(CGRectGetMinX(self.slider.frame)-35, 16, 50, 17);
                [self.myLabel1 setCenter:CGPointMake(self.myLabel1.center.x, self.slider.center.y)];
                [self addSubview:self.myLabel1];
                
                [self.slider addTarget:self action:@selector(layoutSubviews) forControlEvents:UIControlEventValueChanged];
                
                
                
            }
                break;
                
            case ToolTypeLvjing:
            {
                self.scrollView = [[FilterCoverScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
                [self addSubview:self.scrollView];
                
                
            }
                break;
            case ToolTypeSetting:
                self.myLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(22, 16, 107, 25)];
                self.myLabel2.text = @"人脸对焦";
                self.myLabel1 = [[UILabel alloc] initWithFrame: CGRectMake(207, 16, 107, 25)];
                self.myLabel1.text = @"剪刀手捕捉";
                [self addSubview:self.myLabel1];
                [self addSubview:self.myLabel2];
                self.myLabel1.textColor = default_light_blue;
                self.myLabel2.textColor = default_light_blue;
                
                self.mySwitch1 = [[UISwitch alloc] initWithFrame:CGRectMake(129, 12, 40, 24)];
                self.mySwitch1.onTintColor = [UIColor grayColor];
                self.mySwitch1.on = NO;
                [self addSubview:self.mySwitch1];
                
                self.mySwitch2 = [[UISwitch alloc] initWithFrame:CGRectMake(307, 12, 40, 24)];
                self.mySwitch2.onTintColor = [UIColor grayColor];
                self.mySwitch2.on = NO;
                [self addSubview:self.mySwitch2];
                
                
                break;

            default:
                break;
        }
        
    }
    return self;
}

- (void) layoutSubviews
{
    switch (self.type) {
        case ToolTypeTimer:
        {
            self.myLabel1.text = [NSString stringWithFormat:@"%d秒", (int)self.slider.value];
            self.timerValue = (int)self.slider.value;
            NSLog(@"%d", (int)self.slider.value);
        }
            break;
            
        case ToolTypeLianpai:
            
        {
            self.myLabel1.text = [NSString stringWithFormat:@"%d张", (int)self.slider.value];
            self.lianpaiValue = (int)self.slider.value;

        }
            break;
            
        case ToolTypeLvjing:
        {
            
        }
            break;
        case ToolTypeSetting:
        {
            self.isFaceDetectOn = self.mySwitch1.on;
        }
            break;
            
        default:
            break;
    }
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸detailView");
}

@end
