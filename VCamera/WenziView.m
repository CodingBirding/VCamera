//
//  WenziView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/8.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "WenziView.h"
#import "BaseDefines.h"
@interface WenziView()

@property (nonatomic, retain) UILabel *wenziLabel;

@end

@implementation WenziView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isEditing = YES;
        self.wenziLabel = [[UILabel alloc] initWithFrame:self.biankuangView.frame];
        self.wenziLabel.font = Default_Font_24;
        self.wenziLabel.textColor = [UIColor whiteColor];
        self.wenziLabel.textAlignment = NSTextAlignmentCenter;
        self.wenziLabel.contentMode = UIViewContentModeTopLeft;
        self.wenziLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.wenziLabel];
        
        
        self.textField = [[UITextField alloc] initWithFrame:self.biankuangView.frame];
        self.textField.font = Default_Font_20;
        self.textField.contentMode = UIViewContentModeCenter;
        self.textField.placeholder = @"输入文字";
        [self addSubview:self.textField];
        
        UITapGestureRecognizer *doubleTepleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
        doubleTepleGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:doubleTepleGesture];
        
        
        
    }
    return self;
}


- (void) refresh
{
    self.isEditing = NO;
    if (self.textField.text)
    {
        self.wenziLabel.text = self.textField.text;
    }else
    {
        self.wenziLabel.text = @"输入文字";
    }
    self.textField.hidden = YES;
    self.wenziLabel.hidden = NO;
    [self.wenziLabel sizeToFit];
    self.biankuangView.frame = CGRectMake(self.biankuangView.frame.origin.x, self.biankuangView.frame.origin.y, CGRectGetWidth(self.wenziLabel.frame), self.biankuangView.frame.size.height);
    self.textField.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y, CGRectGetWidth(self.wenziLabel.frame), self.textField.frame.size.height);;
    
    self.biankuangView.hidden = YES;
    self.deletImageView.hidden = YES;
}

- (void) doubleTap
{
    self.isEditing = YES;
    self.wenziLabel.hidden = YES;
    self.textField.hidden = NO;
    self.textField.text = self.wenziLabel.text;
    self.textField.selected = YES;
    self.biankuangView.hidden = NO;
    self.deletImageView.hidden = NO;
}

@end
