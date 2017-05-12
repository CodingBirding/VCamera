//
//  VCameraManager.h
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/videoio/cap_ios.h>
#import "SynthesizeSingleton.h"

@protocol VideoCameraDelegate <CvVideoCameraDelegate>
@end

@interface VCameraManager : CvVideoCamera

- (void)updateOrientation;
- (void)layoutPreviewLayer;
+ (void)switchFlashModeWith: (BOOL)isOn;
+ (void)setForcusPoint: (CGPoint)forcusPoint;
@end
