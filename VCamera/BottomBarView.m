//
//  BottomBarView.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "BottomBarView.h"
#import "UIImageView+AutoHighlighted.h"

#define SmallButtonWidth 40
#define BigButtonWidth 50


@interface BottomBarView()

@property (nonatomic, retain) UIImageView *flipView;
@property (nonatomic, retain) UIImageView *takeButtonView;
@property (nonatomic, retain) UIImageView *albumView;



@end

@implementation BottomBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
        self.flipView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 20, SmallButtonWidth, SmallButtonWidth   )];
        self.flipView.image = [UIImage imageNamed:@"翻转按钮"];
        self.flipView.highlightedImage = [UIImage imageNamed:@"翻转按钮0"];
        self.flipView.userInteractionEnabled = YES;
        [self addSubview:self.flipView];
        
        self.takeButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x - BigButtonWidth/2, self.center.y-BigButtonWidth/2 - self.frame.origin.y, BigButtonWidth, BigButtonWidth)];
        self.takeButtonView.image = [UIImage imageNamed:@"拍摄按钮"];
        self.takeButtonView.highlightedImage = [UIImage imageNamed:@"拍摄按钮0"];
        self.takeButtonView.userInteractionEnabled = YES;
        [self addSubview:self.takeButtonView];
        
        self.albumView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-SmallButtonWidth-28, CGRectGetMinY(self.flipView.frame), SmallButtonWidth, SmallButtonWidth)];
        self.albumView.image = [UIImage imageNamed:@"相册按钮"];
        self.albumView.highlightedImage = [UIImage imageNamed:@"相册按钮0"];
        self.albumView.userInteractionEnabled = YES;
        [self addSubview:self.albumView];
        
        //添加手势
        UITapGestureRecognizer *tapFlipGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFlip)];
        [self.flipView addGestureRecognizer:tapFlipGesture];
        
        UITapGestureRecognizer *tapTakeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTake)];
        [self.takeButtonView addGestureRecognizer:tapTakeGesture];
        
        UITapGestureRecognizer *tapAlbumGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAlbum)];
        [self.albumView addGestureRecognizer:tapAlbumGesture];
    }
    return self;
}

- (void) tapFlip
{
    if (self.flipBlock)
    {
        self.flipBlock();
    }
}

- (void) tapTake
{
    if (self.takePhotoBlock)
    {
        self.takePhotoBlock();
    }
    
}

- (void) tapAlbum
{
    if (self.albumBlock)
    {
        self.albumBlock();
    }
    
    
}

@end
