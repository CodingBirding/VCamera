//
//  ShapeView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/8.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ShapeView.h"

@interface ShapeView()

@end

@implementation ShapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.imageView = [[UIImageView alloc] initWithFrame:self.biankuangView.frame];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void) finishEdit
{
    self.biankuangView.hidden = YES;
    self.deletImageView.hidden = YES;
}

- (void) beginEdit
{
    self.biankuangView.hidden = NO;
    self.deletImageView.hidden = NO;
}

@end
