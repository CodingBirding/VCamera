//
//  ProcessingBottomBar.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ProcessingBottomBar.h"
#import "BaseDefines.h"
#import "AttachBaseView.h"

#define ARROW_SPACE_WIDTH 27.5
#define ARROW_SPACE_Height 22

@interface ProcessingBottomBar()
@property (nonatomic, retain) UIImageView *leftArrow1;
@property (nonatomic, retain) UIImageView *leftArrow2;
@property (nonatomic, retain) UIImageView *leftArrow3;

@property (nonatomic, retain) UIImageView *rightArrow1;
@property (nonatomic, retain) UIImageView *rightArrow2;

@property (nonatomic, retain) UIView *shuxian1;
@property (nonatomic, retain) UIView *shuxian2;
@property (nonatomic, retain) UIView *shuxian3;
@property (nonatomic, retain) UIView *shuxian7;
@property (nonatomic, retain) UIView *shuxian5;
@property (nonatomic, retain) UIView *shuxian6;


@property (nonatomic, retain) UIImageView *biankuangImageView;
@property (nonatomic, retain) UIImageView *wenziImageView;
@property (nonatomic, retain) UIImageView *xingzhuangImageView;
@property (nonatomic, retain) UIImageView *duibiduImageView;
@property (nonatomic, retain) UIImageView *baoguangImageView;
@property (nonatomic, retain) UIImageView *sediaoImageView;
@property (nonatomic, retain) UIImageView *lvjingImageView;
@property (nonatomic, retain) UIImageView *roundImageView;
@property (nonatomic, retain) UIImageView *saveImageView;
@property (nonatomic, retain) UILabel *saveLabel;




@end

@implementation ProcessingBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isBiankuang = NO;
        self.doSaveOriginalPic = YES;
        self.backgroundColor = RGBACOLOR(0, 0, 0, 1);
        
        // 所有的箭头
        self.leftArrow1 = [[UIImageView alloc] initWithFrame:CGRectMake(ARROW_SPACE_WIDTH, ARROW_SPACE_Height, 21, 36)];
        self.leftArrow1.image = [UIImage imageNamed:@"左箭头"];
        self.leftArrow1.userInteractionEnabled = YES;
        [self addSubview:self.leftArrow1];
        
        self.leftArrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(ARROW_SPACE_WIDTH + SCREEN_WIDTH, ARROW_SPACE_Height, 21, 36)];
        self.leftArrow2.image = [UIImage imageNamed:@"左箭头"];
        self.leftArrow2.userInteractionEnabled = YES;

        [self addSubview:self.leftArrow2];
        
        self.leftArrow3 = [[UIImageView alloc] initWithFrame:CGRectMake(ARROW_SPACE_WIDTH + 2*SCREEN_WIDTH, ARROW_SPACE_Height, 21, 36)];
        self.leftArrow3.image = [UIImage imageNamed:@"左箭头"];
        self.leftArrow3.userInteractionEnabled = YES;

        [self addSubview:self.leftArrow3];
 
        
        self.rightArrow1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ARROW_SPACE_WIDTH - 21, ARROW_SPACE_Height, 21, 36)];
        self.rightArrow1.image = [UIImage imageNamed:@"右箭头"];
        self.rightArrow1.userInteractionEnabled = YES;
        [self addSubview:self.rightArrow1];
        
        self.rightArrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH - ARROW_SPACE_WIDTH - 21, ARROW_SPACE_Height, 21, 36)];
        self.rightArrow2.image = [UIImage imageNamed:@"右箭头"];
        self.rightArrow2.userInteractionEnabled = YES;
        [self addSubview:self.rightArrow2];
        
        self.saveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3*SCREEN_WIDTH - ARROW_SPACE_WIDTH - 35, 20, 40, 40)];
        self.saveImageView.image = [UIImage imageNamed:@"save"];
        self.saveImageView.userInteractionEnabled = YES;
        [self addSubview:self.saveImageView];
        
        // 所有的竖线
        
        self.shuxian1 = [[UIView alloc] initWithFrame:CGRectMake(78, 10, 1, 60)];
        self.shuxian1.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian1];
        
        self.shuxian2 = [[UIView alloc] initWithFrame:CGRectMake(78+SCREEN_WIDTH, 15, 1, 50)];
        self.shuxian2.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian2];
        
        self.shuxian3 = [[UIView alloc] initWithFrame:CGRectMake(78+2*SCREEN_WIDTH, 15, 1, 50)];
        self.shuxian3.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian3];
        
        
        self.shuxian5 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-78-3, 15, 1, 50)];
        self.shuxian5.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian5];
        
        self.shuxian6 = [[UIView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH-78-3, 15, 1, 50)];
        self.shuxian6.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian6];
        
        self.shuxian7 = [[UIView alloc] initWithFrame:CGRectMake(3*SCREEN_WIDTH-78-3, 15, 1, 50)];
        self.shuxian7.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shuxian7];
        
        
        self.duibiduImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 48)];
        self.duibiduImageView.image = [UIImage imageNamed:@"对比度"];
        self.duibiduImageView.userInteractionEnabled = YES;
        [self addSubview:self.duibiduImageView];
        
        self.sediaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 49)];
        self.sediaoImageView.image = [UIImage imageNamed:@"色调"];
        self.sediaoImageView.userInteractionEnabled = YES;
        [self addSubview:self.sediaoImageView];
        
        self.baoguangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 50)];
        self.baoguangImageView.image = [UIImage imageNamed:@"曝光度"];
        self.baoguangImageView.userInteractionEnabled = YES;
        [self addSubview:self.baoguangImageView];
        
        self.lvjingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 47)];
        self.lvjingImageView.image = [UIImage imageNamed:@"滤镜"];
        self.lvjingImageView.userInteractionEnabled = YES;
        [self addSubview:self.lvjingImageView];
        
        self.biankuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 48)];
        self.biankuangImageView.image = [UIImage imageNamed:@"加边框"];
        self.biankuangImageView.highlightedImage = [UIImage imageNamed:@"加边框0"];
        self.biankuangImageView.userInteractionEnabled = YES;
        [self addSubview: self.biankuangImageView];
        
        self.wenziImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 48)];
        self.wenziImageView.image = [UIImage imageNamed:@"文字"];
        self.wenziImageView.userInteractionEnabled = YES;
        [self addSubview:self.wenziImageView];
        
        self.xingzhuangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 48)];
        self.xingzhuangImageView.image = [UIImage imageNamed:@"形状"];
        self.xingzhuangImageView.userInteractionEnabled = YES;
        [self addSubview:self.xingzhuangImageView];
        
        self.saveLabel = [[UILabel alloc] init];
        self.saveLabel.textColor = [UIColor blackColor];
        self.saveLabel.backgroundColor = [UIColor whiteColor];
        self.saveLabel.layer.cornerRadius = 5;
        self.saveLabel.clipsToBounds = YES;
        self.saveLabel.text = @"保存原图";
        self.saveLabel.font = Default_Font_24;
        [self.saveLabel sizeToFit];
        self.saveLabel.font = Default_Font_18;
        self.saveLabel.textAlignment = NSTextAlignmentCenter;
        self.saveLabel.userInteractionEnabled = YES;
        [self addSubview:self.saveLabel];
        
#pragma 添加gesture
        UITapGestureRecognizer *leftArrow1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftArrow1)];
        [self.leftArrow1 addGestureRecognizer:leftArrow1Gesture];
        
        UITapGestureRecognizer *leftArrow2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftArrow)];
        [self.leftArrow2 addGestureRecognizer:leftArrow2Gesture];
        
        UITapGestureRecognizer *leftArrow3Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftArrow)];
        [self.leftArrow3 addGestureRecognizer:leftArrow3Gesture];
        
        UITapGestureRecognizer *rightArrow1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightArrow)];
        [self.rightArrow1 addGestureRecognizer:rightArrow1Gesture];
        
        UITapGestureRecognizer *rightArrow2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightArrow)];
        [self.rightArrow2 addGestureRecognizer:rightArrow2Gesture];
     
        UITapGestureRecognizer *saveLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSaveLabel)];
        [self.saveLabel addGestureRecognizer:saveLabelGesture];
        
        UITapGestureRecognizer *duibiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDuibi)];
        [self.duibiduImageView addGestureRecognizer:duibiGesture];
        
        UITapGestureRecognizer *baoheGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBaohe)];
        [self.sediaoImageView addGestureRecognizer:baoheGesture];
        
        UITapGestureRecognizer *baoguangGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBaoguang)];
        [self.baoguangImageView addGestureRecognizer:baoguangGesture];
        
        UITapGestureRecognizer *lvjingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLvjing)];
        [self.lvjingImageView addGestureRecognizer:lvjingGesture];
        
        UITapGestureRecognizer *biankuangGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBiankuang)];
        [self.biankuangImageView addGestureRecognizer:biankuangGesture];
        
        UITapGestureRecognizer *wenziGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWenzi)];
        [self.wenziImageView addGestureRecognizer:wenziGesture];
        
        UITapGestureRecognizer *xingzhuangGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapXingzhuang)];
        [self.xingzhuangImageView addGestureRecognizer:xingzhuangGesture];
        
        UITapGestureRecognizer *saveGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSave)];
        [self.saveImageView addGestureRecognizer:saveGesture];
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat leftSpace = (SCREEN_WIDTH-75*2-(48+50+49+47))/5-3;
    CGFloat leftSpace2 = (SCREEN_WIDTH-75*2-48*3)/4-3;
    
//    self.duibiduImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + leftSpace+10, 0, self.duibiduImageView.frame.size.width, self.duibiduImageView.frame.size.height);
//    [self.duibiduImageView setCenter:CGPointMake(self.duibiduImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.duibiduImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + 4*leftSpace+48+50+49+6, 0, self.duibiduImageView.frame.size.width, self.duibiduImageView.frame.size.height);
    [self.duibiduImageView setCenter:CGPointMake(self.duibiduImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.baoguangImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + 2*leftSpace+48+6, 0, self.baoguangImageView.frame.size.width, self.baoguangImageView.frame.size.height);
    [self.baoguangImageView setCenter:CGPointMake(self.baoguangImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.sediaoImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + 3*leftSpace+48+50+6, 0, self.sediaoImageView.frame.size.width, self.sediaoImageView.frame.size.height);
    [self.sediaoImageView setCenter:CGPointMake(self.sediaoImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.lvjingImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + leftSpace+10, 0, self.lvjingImageView.frame.size.width, self.lvjingImageView.frame.size.height);
    [self.lvjingImageView setCenter:CGPointMake(self.lvjingImageView.center.x, self.center.y - self.frame.origin.y)];
    
//    self.lvjingImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + 4*leftSpace+48+50+49+6, 0, self.lvjingImageView.frame.size.width, self.lvjingImageView.frame.size.height);
//    [self.lvjingImageView setCenter:CGPointMake(self.lvjingImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.biankuangImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + SCREEN_WIDTH+leftSpace2+8, 0, self.biankuangImageView.frame.size.width, self.biankuangImageView.frame.size.height);
    [self.biankuangImageView setCenter:CGPointMake(self.biankuangImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.wenziImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + SCREEN_WIDTH+2*leftSpace2+48+8, 0, self.wenziImageView.frame.size.width, self.wenziImageView.frame.size.height);
    [self.wenziImageView setCenter:CGPointMake(self.wenziImageView.center.x, self.center.y - self.frame.origin.y)];
    
    self.xingzhuangImageView.frame = CGRectMake(CGRectGetMaxX(self.shuxian1.frame) + SCREEN_WIDTH+3*leftSpace2+48*2+8, 0, self.xingzhuangImageView.frame.size.width, self.xingzhuangImageView.frame.size.height);
    [self.xingzhuangImageView setCenter:CGPointMake(self.xingzhuangImageView.center.x, self.center.y - self.frame.origin.y)];
    
    [self.saveLabel setCenter:CGPointMake(2*SCREEN_WIDTH+SCREEN_WIDTH/2, self.center.y - self.frame.origin.y)];
    
    
    
    
    
}

- (void)tapLeftArrow1
{
    if (self.cancelBlock)
    {
        NSLog(@"返回");
        self.cancelBlock();
    }
}

- (void)tapLeftArrow
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x + SCREEN_WIDTH, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }];
    
    if (self.leftBlock) {
        self.leftBlock();
    }
    
}

- (void)tapRightArrow
{
    if (self.rightBlock) {
        self.rightBlock();
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x - SCREEN_WIDTH, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)tapSaveLabel
{
    
    if (self.doSaveOriginalPic)
    {
        self.saveLabel.text = @"不保存原图";
        self.saveLabel.textColor = [UIColor whiteColor];
        self.saveLabel.backgroundColor = [UIColor clearColor];
    }else
    {
        self.saveLabel.text = @"保存原图";
        self.saveLabel.textColor = [UIColor blackColor];
        self.saveLabel.backgroundColor = [UIColor whiteColor];
    }
    
    
    self.doSaveOriginalPic = !self.doSaveOriginalPic;
    
}

#pragma 按按钮
- (void) tapDuibi
{
    if (self.duibiBlock) {
        self.duibiBlock();
    }
}

- (void) tapBaohe
{
    if (self.baoheBlock) {
        self.baoheBlock();
    }
}

- (void) tapBaoguang
{
    if (self.baoguangBlock) {
        self.baoguangBlock();
    }
}

- (void) tapLvjing
{
    if (self.lvjingBlock) {
        self.lvjingBlock();
    }
}

- (void) tapBiankuang
{
    if (self.biankuangBlock) {
        self.biankuangBlock(self.isBiankuang);
    }
//    if (self.isBiankuang) {
//        self.biankuangImageView.highlighted = NO;
//    }else
//        self.biankuangImageView.highlighted = YES;
    self.isBiankuang = !self.isBiankuang;
    
   
}

- (void) tapWenzi
{
    if (self.wenziBlock) {
        self.wenziBlock();
    }
}

- (void) tapXingzhuang
{
    if (self.xingzhuangBlock) {
        self.xingzhuangBlock();
    }
}

- (void) tapSave
{
    if (self.saveBlock) {
        self.saveBlock(self.doSaveOriginalPic);
    }
}

@end
