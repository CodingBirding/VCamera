//
//  VCameraManager.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "VCameraManager.h"
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation VCameraManager


- (void)updateOrientation;
{
    self->customPreviewLayer.bounds = CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height);
    [self layoutPreviewLayer];
}

+ (void)switchFlashModeWith: (BOOL)isOn
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSLog(@"调用切换闪光灯方法");
    [device lockForConfiguration:nil];
    if ([device hasFlash])
    {
        if (isOn)
        {
            [device setFlashMode:AVCaptureFlashModeOff];
            NSLog(@"闪光灯关闭");
        } else
        {
            [device setFlashMode:AVCaptureFlashModeOn];
            NSLog(@"闪光灯打开");
        }
    }
    [device unlockForConfiguration];
}

+ (void)setForcusPoint: (CGPoint)forcusPoint;
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setFocusMode:AVCaptureFocusModeAutoFocus];
    [device setFocusPointOfInterest:forcusPoint];
    [device unlockForConfiguration];
    

    
}




- (void)layoutPreviewLayer;
{
    if (self.parentView != nil)
    {
        CALayer* layer = self->customPreviewLayer;
        CGRect bounds = self->customPreviewLayer.bounds;
        int rotation_angle = 0;
        
        switch (defaultAVCaptureVideoOrientation) {
            case AVCaptureVideoOrientationLandscapeRight:
                rotation_angle = 270;
                break;
            case AVCaptureVideoOrientationPortraitUpsideDown:
                rotation_angle = 180;
                break;
            case AVCaptureVideoOrientationLandscapeLeft:
                rotation_angle = 90;
                break;
            case AVCaptureVideoOrientationPortrait:
            default:
                break;
        }
        
        layer.position = CGPointMake(self.parentView.frame.size.width/2., self.parentView.frame.size.height/2.);
        layer.affineTransform = CGAffineTransformMakeRotation( DEGREES_RADIANS(rotation_angle) );
        layer.bounds = bounds;
    }
}

@end
