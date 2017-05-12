//
//  FilterNameView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FilterNameView.h"
#import "BaseDefines.h"
#import "FilterManager.h"


@interface FilterNameView()

@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) UILabel *nameLabel;

@end


@implementation FilterNameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = @"原图";
        self.nameLabel.font = Default_Font_24;
        self.nameLabel.textColor = [UIColor whiteColor];
        [self.nameLabel sizeToFit];
        self.nameLabel.alpha = 0;
        [self addSubview:self.nameLabel];
        self.backgroundColor = [UIColor clearColor];
        
        UISwipeGestureRecognizer *swipleftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
        swipleftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self addGestureRecognizer:swipleftGesture];
        
        UISwipeGestureRecognizer *swipRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
        [self addGestureRecognizer:swipRightGesture];
        
    }
    return self;
}

- (void) insertFilterNameArray: (NSMutableArray *)filterNameArray
{
    if (self.nameArray)
    {
        [self.nameArray removeAllObjects];
    }else
    {
        self.nameArray = [[NSMutableArray alloc] init];
        [self.nameArray addObjectsFromArray:filterNameArray];
        
    }
    
}

- (void) layoutSubviews
{
    [self.nameLabel setCenter:CGPointMake(self.center.x, self.center.y + 50)];
    
    
    
}

- (void) swipeLeft
{
    if (FilterPtr>0) {
        FilterPtr--;
    }
    self.nameLabel.text = self.nameArray[FilterPtr];
    [self.nameLabel sizeToFit];
    [UIView animateWithDuration:0.5 animations:^{
        self.nameLabel.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
            self.nameLabel.alpha = 0;
        }];
    }];
    
}

- (void) swipeRight
{
    if (FilterPtr<[self.nameArray count]-1) {
        FilterPtr++;
    }
    self.nameLabel.text = self.nameArray[FilterPtr];
    [self.nameLabel sizeToFit];
    [UIView animateWithDuration:0.5 animations:^{
        self.nameLabel.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
            self.nameLabel.alpha = 0;
        }];
    }];

    
}

@end
