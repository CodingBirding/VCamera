//
//  FilterManager.h
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDefines.h"

@interface FilterManager : NSObject

@property (nonatomic, assign) int realTimeFilterPtr;

+(instancetype)sharedFilterManager;
- (UIImage *) processImage: (UIImage *)originalImage withFilterType: (int)type;
- (NSArray *)currentFilterList;
- (UIImage *) processImage: (UIImage *)originImage withCoefficient: (CGFloat)coefficient withProcessType:(int)type;

@end
