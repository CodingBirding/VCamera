//
//  ViewController.m
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "BottomBarView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BaseDefines.h"
#import "VCameraManager.h"
#import "ToolBarView.h"
#import "LineView.h"
#import "FocusView.h"
#import "DaojishiView.h"
#import "TakePhotoManager.h"
#import "ChooseView.h"
#import "FlashView.h"
#import "ImageProcessingViewController.h"
#import "FilterManager.h"
#import "FilterNameView.h"


#import "opencv2/opencv.hpp"
#import <opencv2/videoio/cap_ios.h>
#import "opencv2/imgcodecs/ios.h"


using namespace cv;

@interface TakePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CvVideoCameraDelegate>

@property (nonatomic, retain) BottomBarView* bottomBarView;
@property (nonatomic, retain) UIView *cameraView;
@property (nonatomic, retain) VCameraManager *cameraManager;
@property (nonatomic, retain) ToolBarView *toolBarView;
@property (nonatomic, retain) UIView *toolBarBgView;
@property (nonatomic, retain) UIImageView *narrowImageView;
@property (nonatomic, retain) LineView *lineView;
@property (nonatomic, retain) ChooseView *chooseView;
@property (nonatomic, retain) NSTimer *lianpaiTimer;
@property (nonatomic, retain) UIImage *currentPhoto;
@property (nonatomic, retain) UIImage *originImage;
@property (nonatomic, retain) UIImageView *bgImageView;

@property (nonatomic, retain) FlashView *flashView;

@property (nonatomic, retain) NSMutableArray *filterArray;
@property (nonatomic, assign) int filtrPtr;
@property (nonatomic, retain) FilterNameView *filterNameView;


@end

@implementation TakePhotoViewController

- (void)viewWillAppear:(BOOL)animated
{
    //设置滤镜
    self.filterArray = [[NSMutableArray alloc] init];
    NSArray *nameArray = [[FilterManager sharedFilterManager] currentFilterList] ;
    [self.filterArray addObjectsFromArray:nameArray];
    self.filtrPtr = 0;
    self.filterNameView = [[FilterNameView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-180)];
    [self.filterNameView insertFilterNameArray:nameArray];
    [self.view addSubview:self.filterNameView];
    
    if (self.cameraManager) {
        [self.cameraManager start];
        self.bgImageView.hidden = NO;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    self.originImage = [[UIImage alloc] init];

    self.bottomBarView = [[BottomBarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-BottomBarHeight, CGRectGetWidth(self.view.frame), BottomBarHeight)];
    [self.view addSubview:self.bottomBarView];
    
    WEAKSELF
    [self.bottomBarView setAlbumBlock:^()
    {
        [weakSelf openAlbum];
        
    }];
    
    self.currentPhoto = [[UIImage alloc] init];
    
    
    
    //设置对焦点
    UITapGestureRecognizer *tapFocusGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFocus:)];
    [self.view addGestureRecognizer:tapFocusGesture];
    
    //配置相机
    self.cameraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (CGRectGetHeight(self.view.frame) - BottomBarHeight)*3/4, CGRectGetHeight(self.view.frame) - BottomBarHeight)];
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.cameraView.frame];

    [self.cameraView setCenter:CGPointMake(self.view.center.x, self.cameraView.center.y)];
    self.cameraView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cameraView];
    
    self.cameraManager = [[VCameraManager alloc] initWithParentView:self.cameraView];
    
    self.cameraManager.delegate = self;
    self.cameraManager.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.cameraManager.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.cameraManager.defaultAVCaptureSessionPreset  = AVCaptureSessionPreset640x480;
    self.cameraManager.defaultFPS = 30;

    [self.cameraManager start];
    
    [self.cameraView addSubview:self.bgImageView];
    self.bgImageView.hidden = YES;

    //参考线图层
    self.lineView = [[LineView alloc] initWithFrame:self.cameraView.frame];
    self.lineView.hidden = YES;
    [self.view addSubview:self.lineView];
    
    //底部工具栏
    self.toolBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.bottomBarView.frame)-27-kLeftSpace, CGRectGetWidth(self.view.frame), 139)];
    self.toolBarBgView.backgroundColor = [UIColor clearColor];
    self.toolBarBgView.userInteractionEnabled = YES;
    [self.view addSubview: self.toolBarBgView];
    
    self.narrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 18, 12, 36, 15)];
    self.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
    self.narrowImageView.userInteractionEnabled = YES;
    [self.toolBarBgView addSubview:self.narrowImageView];
    
    UITapGestureRecognizer *tapNarrowGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNarrow)];
    [self.narrowImageView addGestureRecognizer:tapNarrowGesture];
    
    
    self.toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, 39, CGRectGetWidth(self.view.frame), 100)];
    [self.toolBarBgView addSubview:self.toolBarView];
    
    [self.view bringSubviewToFront:self.bottomBarView];
    
    
    [self.toolBarView setLightBlock:^(BOOL isOn)
     {
        [VCameraManager switchFlashModeWith:isOn];
     }];
    
    [self.toolBarView setLineBlock:^(BOOL isOn)
     {
         if (isOn)
         {
             weakSelf.lineView.hidden = YES;
         }else
         {
             weakSelf.lineView.hidden = NO;
         }
     }];
    
    [self.toolBarView setTimerBlock:^()
    {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, weakSelf.bottomBarView.frame.origin.y-139, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    [self.toolBarView setLianpaiBlock:^()
     {
         [UIView animateWithDuration:0.5 animations:^{
             weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, weakSelf.bottomBarView.frame.origin.y-139, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
         } completion:^(BOOL finished)
         {
             
         }];
         
     }];
    
    [self.toolBarView setLvjingBlock:^
    {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, weakSelf.bottomBarView.frame.origin.y-139, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
        
        
    }];
    
    [self.toolBarView setSettingBlock:^()
     {
         [UIView animateWithDuration:0.5 animations:^{
             weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, weakSelf.bottomBarView.frame.origin.y-139, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
         } completion:^(BOOL finished) {
             
         }];
         
     }];
    
    [self.bottomBarView setFlipBlock:^()
     {
         [weakSelf.cameraManager stop];
         if (weakSelf.cameraManager.defaultAVCaptureDevicePosition == AVCaptureDevicePositionFront) {
             weakSelf.cameraManager.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
         }else
         {
             weakSelf.cameraManager.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
         }
         
         [weakSelf.cameraManager start];
     }];
    
    self.chooseView = [[ChooseView alloc] init];
    [self.view addSubview:self.chooseView];
    
    self.chooseView.hidden = YES;

    
    // 拍照效果的图层
    self.flashView = [[FlashView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.flashView.userInteractionEnabled = NO;
    [self.view addSubview:self.flashView];
   
    
#pragma 按下拍摄按钮
    
    [self.bottomBarView setTakePhotoBlock:^()
     {
         //设置chooseView
         weakSelf.chooseView = [[ChooseView alloc] init];
         [weakSelf.view addSubview:weakSelf.chooseView];
         weakSelf.chooseView.hidden = YES;
         
         [weakSelf.chooseView setImageArrayBlock:^()
          {
              return [TakePhotoManager takenImagesArray];
          }];
         
         [weakSelf.chooseView setOriginImageArrayBlock:^()
          {
              return [TakePhotoManager originImagesArray];

          }];
         
         // 开始倒计时动画
         if (weakSelf.toolBarView.timerView.timerValue > 0)
         {
             DaojishiView *daojishiView = [[DaojishiView alloc] init];
             [weakSelf.view addSubview:daojishiView];
             [daojishiView setCenter:weakSelf.cameraView.center];
             
             [daojishiView setTimeOver:^()
              {
                  // 倒计时结束调用拍摄方法
                  
                  [[TakePhotoManager sharedTakePhotoManager] setNumberOfPhotoToTake:weakSelf.toolBarView.lianpaiView.lianpaiValue?weakSelf.toolBarView.lianpaiView.lianpaiValue:1];
                  weakSelf.lianpaiTimer = [NSTimer timerWithTimeInterval:0.6 target:weakSelf selector:@selector(takePhoto) userInfo:nil repeats:YES];
                  [weakSelf.lianpaiTimer setFireDate:[NSDate distantPast]];
                  [[NSRunLoop mainRunLoop] addTimer:weakSelf.lianpaiTimer forMode:NSDefaultRunLoopMode];
                  NSLog(@"daojishijieshu");
                  
              }];
             
             [daojishiView setTime:weakSelf.toolBarView.timerView.timerValue];
            
             [UIView animateWithDuration:0.5 animations:^{
                 weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, CGRectGetMinY(weakSelf.bottomBarView.frame)-27-kLeftSpace, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
             }completion:^(BOOL finished) {
                 weakSelf.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
             }];
             
         }else
         {
             [[TakePhotoManager sharedTakePhotoManager] setNumberOfPhotoToTake:weakSelf.toolBarView.lianpaiView.lianpaiValue?weakSelf.toolBarView.lianpaiView.lianpaiValue:1];
             NSLog(@"设置了要拍%d张", weakSelf.toolBarView.lianpaiView.lianpaiValue);
             weakSelf.lianpaiTimer = [NSTimer timerWithTimeInterval:0.6 target:weakSelf selector:@selector(takePhoto) userInfo:nil repeats:YES];
             [weakSelf.lianpaiTimer setFireDate:[NSDate distantPast]];
             [[NSRunLoop mainRunLoop] addTimer:weakSelf.lianpaiTimer forMode:NSDefaultRunLoopMode];
             
             [UIView animateWithDuration:0.5 animations:^{
                 weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, CGRectGetMinY(weakSelf.bottomBarView.frame)-27-kLeftSpace, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
             }completion:^(BOOL finished) {
                 weakSelf.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
             }];
             
         }
         
         
     }];
    
    
    
    
}

- (void) tapNarrow
{
    if (!self.toolBarView.isVisible)
    {
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, weakSelf.toolBarBgView.frame.origin.y-50, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
        } completion:^(BOOL finished) {
            weakSelf.narrowImageView.image = [UIImage imageNamed:@"弹出按钮0"];
        }];
    }else
    {
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, CGRectGetMinY(weakSelf.bottomBarView.frame)-27-kLeftSpace, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
        } completion:^(BOOL finished) {
            weakSelf.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
        }];
    }
    self.toolBarView.isVisible = !self.toolBarView.isVisible;
    
    
    
}

#pragma 打开相册
- (void) openAlbum
{
    
    UIImagePickerController *pickerVctl = [[UIImagePickerController alloc] init];
    pickerVctl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVctl.delegate = self;
//    pickerVctl.allowsEditing = YES;
//    pickerVctl.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    [self presentViewController:pickerVctl animated:YES completion:^{
        
    }];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSLog(@"有图吗");
    
//    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//    UIImage *originalImage, *editedImage, *imageToUse;
//    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeImage, 0)
//        == kCFCompareEqualTo)
//    {
//
//        editedImage = (UIImage *) [info objectForKey:
//                                   UIImagePickerControllerEditedImage];
//        originalImage = (UIImage *) [info objectForKey:
//                                     UIImagePickerControllerOriginalImage];
//        
//        if (editedImage) {
//            imageToUse = editedImage;
//        } else {
//            imageToUse = originalImage;
//        }
//        // Do something with imageToUse
//    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma 设置对焦点
- (void) tapFocus: (UITapGestureRecognizer *)gesture
{
    
    CGPoint touchPoint = [gesture locationInView:self.view];
    
    if ((touchPoint.y < CGRectGetMinY(self.bottomBarView.frame) - 100) && self.chooseView.hidden) {
        FocusView *focusPoint = [[FocusView alloc] init];
        [focusPoint setPoint:touchPoint inView:self.view];
        [VCameraManager setForcusPoint:touchPoint];
        
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.toolBarBgView.frame = CGRectMake(weakSelf.toolBarBgView.frame.origin.x, CGRectGetMinY(weakSelf.bottomBarView.frame)-27-kLeftSpace, weakSelf.toolBarBgView.frame.size.width, weakSelf.toolBarBgView.frame.size.height);
        } completion:^(BOOL finished) {
            weakSelf.narrowImageView.image = [UIImage imageNamed:@"弹出按钮"];
        }];
    }
    
    
    
    
    
    
    
}

#pragma 保存照片
- (void) takePhoto
{
    [[TakePhotoManager sharedTakePhotoManager] setOneImage:self.currentPhoto withOriginImage:self.originImage];
    if ([TakePhotoManager sharedTakePhotoManager].numberOfPhotoHaveTaken == [TakePhotoManager sharedTakePhotoManager].photoNumber)
    {
        //照片拍摄完毕
        [self.lianpaiTimer invalidate];
        self.lianpaiTimer = nil;
        [self.cameraManager stop];
        self.bgImageView.image = self.currentPhoto;
        self.bgImageView.hidden = NO;
        [self performSelector:@selector(saveImage:) withObject:[TakePhotoManager takenImagesArray] afterDelay:0.6];
//        [self saveImage:[TakePhotoManager takenImagesArray]];
//        NSLog(@"拍完了");
    }
    // flashView闪一次
    [self.flashView flash];
    
    
}

- (void) saveImage: (NSMutableArray *)takenImages
{
    
    self.chooseView.hidden = NO;
    self.chooseView.alpha = 1;
    [self.chooseView setNeedPhotoNumber:[TakePhotoManager sharedTakePhotoManager].photoNumber];
    
    
    
    WEAKSELF

    [self.chooseView setCancelBlock:^
     {
         [weakSelf.cameraManager start];
         weakSelf.bgImageView.hidden = NO;
     }];
    
    [self.chooseView setConfirmBlock:^()
     {
         NSLog(@"选好图");
         ImageProcessingViewController *processingController = [[ImageProcessingViewController alloc] init];
         
         [processingController setImageBlock:^
         {
             NSMutableArray *imageArray = [[NSMutableArray alloc] init];
             [imageArray insertObject:weakSelf.chooseView.selectedImage atIndex:0];
             [imageArray insertObject:weakSelf.chooseView.selectedOriginImage atIndex:1];
             return imageArray;
         }];
         
         [weakSelf.navigationController presentViewController:processingController animated:YES completion:^{
             weakSelf.chooseView.hidden = YES;
         }];
     }];
    
}

#pragma delegate
- (void)processImage:(cv::Mat &)image
{
    
    UIImage *nowImage = MatToUIImage(image);
    
    // 原图留底
    Mat image1;
    image1 = image;
    cvtColor(image1, image1, CV_RGB2BGR);
    self.originImage = MatToUIImage(image1);
    
    nowImage = [[FilterManager sharedFilterManager] processImage:nowImage withFilterType:FilterPtr];
    UIImageToMat(nowImage, image);
    Mat image2;
    image2 = image;
    cvtColor(image2, image2, CV_RGB2BGR);
    self.currentPhoto = MatToUIImage(image2);
    
//    switch (FilterPtr) {
//        case 2:
//        {
//            nowImage = [[FilterManager sharedFilterManager] processImage:nowImage withFilterType:FilterPtr];
//            UIImageToMat(nowImage, image);
//            Mat image1;
//            image1 = image;
//            self.currentPhoto = MatToUIImage(image1);
//        }
//            break;
//        default:
//        {
//            nowImage = [[FilterManager sharedFilterManager] processImage:nowImage withFilterType:FilterPtr];
//            UIImageToMat(nowImage, image);
//            Mat image1;
//            image1 = image;
//            cvtColor(image1, image1, CV_RGB2BGR);
//            self.currentPhoto = MatToUIImage(image1);
//        }
//            break;
//    }
    
}

@end

