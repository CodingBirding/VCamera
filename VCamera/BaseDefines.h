//
//  BaseDefines.h
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"

#define kLeftSpace 12
#define BottomBarHeight 80

#pragma ViewTag
#define ToolDetailView_tag 10000
#define FilterCoverView_tag 20000
#define ProcessToolDetailView_tag 30000
#define ItemCoverView_tag 40000


#pragma WEAKEELF
#define WEAKSELF typeof(self) __weak weakSelf = self;

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define default_light_blue RGBACOLOR(141, 255, 214, 100)

#pragma Size
/**********************************************/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height


#pragma Font
/**********************************************/
#define Default_Font_8  [UIFont systemFontOfSize:8]
#define Default_Font_10 [UIFont systemFontOfSize:10]
#define Default_Font_12 [UIFont systemFontOfSize:12]
#define Default_Font_14 [UIFont systemFontOfSize:14]
#define Default_Font_16 [UIFont systemFontOfSize:16]
#define Default_Font_18 [UIFont systemFontOfSize:18]
#define Default_Font_20 [UIFont systemFontOfSize:20]
#define Default_Font_22 [UIFont systemFontOfSize:22]
#define Default_Font_24 [UIFont systemFontOfSize:24]

#pragma Filters
/**********************************************/
#define Filter_Type_Yuantu           0
#define Filter_Type_Huaijiu          1
#define Filter_Type_Heibai           2
#define Filter_Type_Qiangguang       3
#define Filter_Type_LOMO             4
#define Filter_Type_Gete             5
#define Filter_Type_Danya            6
#define Filter_Type_Langman          7
#define Filter_Type_Landiao          8

#define FilterPtr [FilterManager sharedFilterManager].realTimeFilterPtr

#pragma ProcessToolType
/**********************************************/
#define ProcessType_Duibi     0
#define ProcessType_Baoguang  1
#define ProcessType_Baohe    2
#define ProcessType_Lvjing    3
#define ProcessType_Tiezhi    4

#pragma ProcessCoefficientType
/**********************************************/
#define ProcessCoefficientType_Duibi 0
#define ProcessCoefficientType_Baoguang 1
#define ProcessCoefficientType_Baohe 2

#define SAFECOLOR(color) MIN(255,MAX(0,color))

@interface BaseDefines : NSObject

typedef void (^VoidBlockType) (void);
typedef void (^UIImageBlockType) (UIImage *);
typedef void (^BoolBlockType) (BOOL);
typedef void (^FloatBlockType) (CGFloat);
//typedef void (^ArrayBlockType) (NSMutableArray *images);
typedef NSMutableArray* (^ArrayBlockType) (void);
typedef NSArray* (^returnImageArrayBlockType) (void);
typedef UIImage* (^inoutImageBlockType) (UIImage *);

@end
