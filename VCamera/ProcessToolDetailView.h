//
//  ProcessToolDetailView.h
//  VCamera
//
//  Created by ShenZheng on 16/10/6.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"
#import "FilterCoverScrollView.h"

@interface ProcessToolDetailView : UIView
@property (nonatomic, assign) float duibiC;
@property (nonatomic, assign) float baoguangC;
@property (nonatomic, assign) float baoheC;
@property (nonatomic, assign) int type;

@property (nonatomic, copy) FloatBlockType duibiBlcok;
@property (nonatomic, copy) FloatBlockType baoguangBlock;
@property (nonatomic, copy) FloatBlockType baoheBlock;


@property (nonatomic, retain) FilterCoverScrollView *scrollView;


- (instancetype)initWithFrame:(CGRect)frame withType:(int)type;

- (void)tanchu;
- (void)shouhui;
- (void) reset;

@end
