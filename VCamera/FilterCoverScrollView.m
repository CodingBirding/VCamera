//
//  FilterCoverScrollView.m
//  VCamera
//
//  Created by ShenZheng on 16/10/6.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FilterCoverScrollView.h"
#import "BaseDefines.h"

#define FilterCoverWidth 40

@interface FilterCoverScrollView()

@property (nonatomic, assign) int filterAmount;

@property (nonatomic, retain) NSArray *filterNameList;
@property (nonatomic, retain) NSMutableArray *filterCoverImageArray;
@property (nonatomic, retain) UIScrollView *myScrollView;

@end

@implementation FilterCoverScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    self.filterCoverImageArray = [[NSMutableArray alloc] init];
    
    UIImage *image0 = [UIImage imageNamed:@"filtercover_yuantu"];
    UIImage *image1 = [UIImage imageNamed:@"filtercover_huaijiu"];
    UIImage *image2 = [UIImage imageNamed:@"filtercover_heibai"];
    UIImage *image3 = [UIImage imageNamed:@"filtercover_qiangguang"];
    UIImage *image4 = [UIImage imageNamed:@"filtercover_lomo"];
    UIImage *image5 = [UIImage imageNamed:@"filtercover_gete"];
    UIImage *image6 = [UIImage imageNamed:@"filtercover_danya"];
    UIImage *image7 = [UIImage imageNamed:@"filtercover_langman"];
    UIImage *image8 = [UIImage imageNamed:@"filtercover_landiao"];

    [self.filterCoverImageArray addObject:image0];
    [self.filterCoverImageArray addObject:image1];
    [self.filterCoverImageArray addObject:image2];
    [self.filterCoverImageArray addObject:image3];
    [self.filterCoverImageArray addObject:image4];
    [self.filterCoverImageArray addObject:image5];
    [self.filterCoverImageArray addObject:image6];
    [self.filterCoverImageArray addObject:image7];
    [self.filterCoverImageArray addObject:image8];

    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.filterAmount = (int)[[FilterManager sharedFilterManager] currentFilterList].count;
        self.filterNameList = [[FilterManager sharedFilterManager] currentFilterList];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.myScrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.myScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.myScrollView];
        
        self.myScrollView.showsVerticalScrollIndicator = NO;
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        
        
        for (UIView *myView in self.myScrollView.subviews) {
            if ([myView isKindOfClass:[UIImageView class]])
            {
                myView.hidden = YES;
            }
        }
        
        for (int i = 0; i < self.filterAmount; i++)
        {
            if ([self viewWithTag:FilterCoverView_tag + i ])
            {
                [self viewWithTag:FilterCoverView_tag + i].hidden = NO;
            }else
            {
                UIImageView *filterCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*kLeftSpace+i*FilterCoverWidth, 5, FilterCoverWidth, FilterCoverWidth)];
                filterCoverImageView.tag = FilterCoverView_tag + i;
                filterCoverImageView.backgroundColor = [UIColor blueColor];
                filterCoverImageView.image = self.filterCoverImageArray[i];
                [self.myScrollView addSubview:filterCoverImageView];
                
                filterCoverImageView.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePtr:)];
                [filterCoverImageView addGestureRecognizer:tapGesture];
            }
        }
        
        self.myScrollView.contentSize = CGSizeMake(self.filterAmount*(kLeftSpace+FilterCoverWidth)+kLeftSpace, frame.size.height);
        
        
        
    }
    return self;
}

- (void) changePtr: (UIGestureRecognizer *)gesture
{
    FilterPtr = (int)gesture.view.tag - FilterCoverView_tag;
    if (self.tapCover) {
        self.tapCover();
    }
    
}

@end
