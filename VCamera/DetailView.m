//
//  DetailView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/9.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "DetailView.h"

#define ItemCoverWidth 40


@interface DetailView()

@property (nonatomic, retain) UIScrollView* itemScrollView;

@end

@implementation DetailView
- (instancetype)initWithFrame:(CGRect)frame withItemArray: (NSArray *)itemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.items = itemArray;
        
        self.currentPtr = 0;
        
        self.items = [[NSArray alloc] init];
        self.items = itemArray;
        
        self.itemScrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.itemScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.itemScrollView];
        self.itemScrollView.bounces = YES;
        self.itemScrollView.showsVerticalScrollIndicator = NO;
        self.itemScrollView.showsHorizontalScrollIndicator = NO;
        
        for (UIView *myView in self.itemScrollView.subviews) {
            if ([myView isKindOfClass:[UIImageView class]])
            {
                myView.hidden = YES;
            }
        }
        
        for (int i = 0; i < self.items.count; i++)
        {
            if ([self viewWithTag:ItemCoverView_tag + i ])
            {
                [self viewWithTag:ItemCoverView_tag + i].hidden = NO;
            }else
            {
                UIImageView *filterCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*kLeftSpace+i*ItemCoverWidth, 5, ItemCoverWidth, ItemCoverWidth)];
                filterCoverImageView.tag = ItemCoverView_tag + i;
                filterCoverImageView.backgroundColor = [UIColor clearColor];
                [self.itemScrollView addSubview:filterCoverImageView];
                
                filterCoverImageView.image = self.items[i];
                
                filterCoverImageView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(change:)];
                [filterCoverImageView addGestureRecognizer:tapGesture];
            }
        }
        
        self.itemScrollView.contentSize = CGSizeMake(self.items.count*(kLeftSpace+ItemCoverWidth)+kLeftSpace, frame.size.height);
        
        
    }
    return self;
}

- (void) change: (UIGestureRecognizer *)sender
{
    self.currentPtr = (int)sender.view.tag - ItemCoverView_tag;
    if (self.tapItem) {
        self.tapItem();
    }
    
}

@end
