//
//  ImageProcessingViewController.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "ImageProcessingViewController.h"
#import "ProcessingBottomBar.h"
#import "ProcessToolDetailView.h"
#import "VCameraManager.h"
#import "WenziView.h"
#import "ShapeView.h"

#import "DetailView.h"


#import "opencv2/opencv.hpp"
#import <opencv2/videoio/cap_ios.h>
#import "opencv2/imgcodecs/ios.h"

using namespace std;
using namespace cv;

@interface ImageProcessingViewController ()

@property (nonatomic, retain) ProcessingBottomBar *bottomBar;
@property (nonatomic, retain) UIView *bgView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *origineImage;
@property (nonatomic, retain) UIImage *tempImage;
@property (nonatomic, retain) UIImage *tempImage2;
@property (nonatomic, retain) UIView *toolDetailBGView;
@property (nonatomic, retain) ProcessToolDetailView *toolDetailView;
@property (nonatomic, retain) DetailView *itemDetailView;

@property (nonatomic, retain) WenziView *wenziView;
@property (nonatomic, retain) ShapeView *shapeView;
@property (nonatomic, retain) NSMutableArray *tiezhiArray;

@end

@implementation ImageProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tiezhiArray = [[NSMutableArray alloc] init];
    
    UILongPressGestureRecognizer *longpressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(huanyuan:)];
    [self.view addGestureRecognizer:longpressGesture];
    
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(tanchu)];
    edgeGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGesture];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UITapGestureRecognizer *viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shouhui)];
    [self.view addGestureRecognizer:viewGesture];
    
    self.bottomBar = [[ProcessingBottomBar alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-BottomBarHeight, 3*SCREEN_WIDTH, BottomBarHeight)];
    [self.view addSubview:self.bottomBar];
    
    WEAKSELF
    [self.bottomBar setCancelBlock:^
    {
        [weakSelf dismissViewControllerAnimated:YES completion:^{

        }];
    }];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), SCREEN_HIGHT - BottomBarHeight)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
    
    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (CGRectGetHeight(self.view.frame) - BottomBarHeight)*3/4, CGRectGetHeight(self.view.frame) - BottomBarHeight)];
//    [self.imageView setCenter:CGPointMake(self.view.center.x, self.imageView.center.y)];
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT - BottomBarHeight)];
    
    //block传值把之前的拍的照片传进来
    
    if (self.imageBlock)
    {
        UIImage *yuanImage = self.imageBlock()[0];
        UIImage *yuanoriginImage = self.imageBlock()[1];
        NSLog(@"%f, %f", yuanImage.size.width, yuanImage.size.height);
        CGImageRef cgImage = CGImageCreateWithImageInRect([yuanImage CGImage], CGRectMake((yuanImage.size.width-640*SCREEN_WIDTH/(SCREEN_HIGHT-BottomBarHeight))/2.0f, 0, 640*SCREEN_WIDTH/(SCREEN_HIGHT-BottomBarHeight), 640));
        
        CGImageRef cgOriginImage = CGImageCreateWithImageInRect([yuanoriginImage CGImage], CGRectMake((yuanImage.size.width-640*SCREEN_WIDTH/(SCREEN_HIGHT-BottomBarHeight))/2.0f, 0, 640*SCREEN_WIDTH/(SCREEN_HIGHT-BottomBarHeight), 640));
        
        self.imageView.image = [UIImage imageWithCGImage:cgImage];
        self.origineImage = [UIImage imageWithCGImage:cgOriginImage];
        self.tempImage = [UIImage imageWithCGImage:cgOriginImage];
        self.tempImage2 = self.imageView.image;
        
        
    }
    
    [self.bgView addSubview:self.imageView];
    
    
    
    
    //设置工具栏
    self.toolDetailBGView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.bottomBar.frame), SCREEN_WIDTH, 60)];
    self.toolDetailBGView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:self.toolDetailBGView];
    
    
    [self.bottomBar setLeftBlock:^
     {
         [weakSelf shouhui];
     }];
    
    [self.bottomBar setRightBlock:^
     {
         [weakSelf shouhui];
     }];
    
#pragma 图像处理的block
    [self.bottomBar setDuibiBlock:^
    {
        //更新tempView进行其他属性调整
        weakSelf.tempImage = weakSelf.imageView.image;
        for (UIView *view in weakSelf.toolDetailBGView.subviews) {
            if ([view isKindOfClass:[ProcessToolDetailView class]]||[view isKindOfClass:[DetailView class]]) {
                view.hidden = YES;
            
            }
        }
        
        weakSelf.toolDetailView = [weakSelf.view viewWithTag:ProcessToolDetailView_tag];
        if (weakSelf.toolDetailView)
        {
            weakSelf.toolDetailView.hidden = NO;
        }else
        {
            weakSelf.toolDetailView = [[ProcessToolDetailView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(weakSelf.toolDetailBGView.frame), CGRectGetHeight(weakSelf.toolDetailBGView.frame)) withType:ProcessType_Duibi];
            [weakSelf.toolDetailBGView addSubview:weakSelf.toolDetailView];
            weakSelf.toolDetailView.tag = ProcessToolDetailView_tag;
            weakSelf.toolDetailView.hidden = NO;
            
            [weakSelf.toolDetailView setDuibiBlcok:^(CGFloat coe)
            {
                weakSelf.imageView.image = [[FilterManager sharedFilterManager] processImage:weakSelf.tempImage withCoefficient:coe withProcessType:ProcessCoefficientType_Duibi];
                NSLog(@"值改变");
                //处理完之后复原其他处理的slider到1
                [weakSelf resetSliderWithType:ProcessType_Duibi];
                weakSelf.tempImage2 = weakSelf.imageView.image;
            }];
            
        }

        
        
        [UIView animateWithDuration:0.3 animations:^{
           
            weakSelf.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(weakSelf.bottomBar.frame)-weakSelf.toolDetailBGView.frame.size.height, weakSelf.toolDetailBGView.frame.size.width, weakSelf.toolDetailBGView.frame.size.height);
            
        }];
        
    }];
    
    [self.bottomBar setBaoguangBlock:^
     {
         //更新tempView进行其他属性调整
         weakSelf.tempImage = weakSelf.imageView.image;
         for (UIView *view in weakSelf.toolDetailBGView.subviews) {
             if ([view isKindOfClass:[ProcessToolDetailView class]]||[view isKindOfClass:[DetailView class]]) {
                 view.hidden = YES;
             }
         }
         
         weakSelf.toolDetailView = [weakSelf.view viewWithTag:ProcessToolDetailView_tag+1];
         if (weakSelf.toolDetailView)
         {
             weakSelf.toolDetailView.hidden = NO;
         }else
         {
             weakSelf.toolDetailView = [[ProcessToolDetailView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(weakSelf.toolDetailBGView.frame), CGRectGetHeight(weakSelf.toolDetailBGView.frame)) withType:ProcessType_Baoguang];
             [weakSelf.toolDetailBGView addSubview:weakSelf.toolDetailView];
             weakSelf.toolDetailView.tag = ProcessToolDetailView_tag+1;
             
             [weakSelf.toolDetailView setBaoguangBlock:^(CGFloat coe)
              {
                  weakSelf.imageView.image = [[FilterManager sharedFilterManager] processImage:weakSelf.tempImage withCoefficient:coe withProcessType:ProcessCoefficientType_Baoguang];
                  NSLog(@"%f", coe);
                  //处理完之后复原其他处理的slider到1
                  [weakSelf resetSliderWithType:ProcessType_Baoguang];
                  weakSelf.tempImage2 = weakSelf.imageView.image;
              }];
         }
         
         [UIView animateWithDuration:0.3 animations:^{
             
             weakSelf.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(weakSelf.bottomBar.frame)-weakSelf.toolDetailBGView.frame.size.height, weakSelf.toolDetailBGView.frame.size.width, weakSelf.toolDetailBGView.frame.size.height);
         }];
         
     }];
    
    [self.bottomBar setBaoheBlock:^
     {
         //更新tempView进行其他属性调整
         weakSelf.tempImage = weakSelf.imageView.image;
         for (UIView *view in weakSelf.toolDetailBGView.subviews) {
             if ([view isKindOfClass:[ProcessToolDetailView class]]||[view isKindOfClass:[DetailView class]]) {
                 view.hidden = YES;
             }
         }
         
         weakSelf.toolDetailView = [weakSelf.view viewWithTag:ProcessToolDetailView_tag+2];
         
         if (weakSelf.toolDetailView)
         {
             weakSelf.toolDetailView.hidden = NO;
         }else
         {
             weakSelf.toolDetailView = [[ProcessToolDetailView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(weakSelf.toolDetailBGView.frame), CGRectGetHeight(weakSelf.toolDetailBGView.frame)) withType:ProcessType_Baohe];
             [weakSelf.toolDetailBGView addSubview:weakSelf.toolDetailView];
             weakSelf.toolDetailView.tag = ProcessToolDetailView_tag+2;
             [weakSelf.toolDetailView setBaoheBlock:^(CGFloat coe)
              {
                  weakSelf.imageView.image = [[FilterManager sharedFilterManager] processImage:weakSelf.tempImage withCoefficient:coe withProcessType:ProcessCoefficientType_Baohe];
                  NSLog(@"%f", coe);
                  //处理完之后复原其他处理的slider到1
                  [weakSelf resetSliderWithType:ProcessType_Baohe];
                  weakSelf.tempImage2 = weakSelf.imageView.image;

              }];
         }
         
         [UIView animateWithDuration:0.3 animations:^{
             
             weakSelf.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(weakSelf.bottomBar.frame)-weakSelf.toolDetailBGView.frame.size.height, weakSelf.toolDetailBGView.frame.size.width, weakSelf.toolDetailBGView.frame.size.height);
             
         }];
         
     }];
    
    [self.bottomBar setLvjingBlock:^()
     {
         
         for (UIView *view in weakSelf.toolDetailBGView.subviews) {
             if ([view isKindOfClass:[ProcessToolDetailView class]]||[view isKindOfClass:[DetailView class]]) {
                 view.hidden = YES;
             }
         }
         
         weakSelf.toolDetailView = [weakSelf.view viewWithTag:ProcessToolDetailView_tag+3];
         if (weakSelf.toolDetailView)
         {
             weakSelf.toolDetailView.hidden = NO;
         }else
         {
             weakSelf.toolDetailView = [[ProcessToolDetailView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(weakSelf.toolDetailBGView.frame), CGRectGetHeight(weakSelf.toolDetailBGView.frame)) withType:ProcessType_Lvjing];
             [weakSelf.toolDetailBGView addSubview:weakSelf.toolDetailView];
             weakSelf.toolDetailView.tag = ProcessToolDetailView_tag+3;
         }
         
         [weakSelf.toolDetailView.scrollView setTapCover:^()
         {
             UIImage *temImage = [[UIImage alloc] init];
             //处理完之后复原其他处理的slider到1
             [weakSelf resetSliderWithType:-1];
             switch (FilterPtr) {
                 case 1:
                 {
                     temImage = [[FilterManager sharedFilterManager] processImage:weakSelf.origineImage withFilterType:FilterPtr];
                     Mat image1;
                     UIImageToMat(temImage, image1);
                     cvtColor(image1, image1, CV_RGB2BGR);
                     weakSelf.imageView.image = MatToUIImage(image1);
                     weakSelf.tempImage2 = MatToUIImage(image1);

                 }
                     break;
                 case 2:
                 {
                     temImage = [[FilterManager sharedFilterManager] processImage:weakSelf.origineImage withFilterType:Filter_Type_Heibai];
                     weakSelf.imageView.image = temImage;
                     weakSelf.tempImage2 = temImage;

                 }
                     break;
                 default:
                 {
                     temImage = [[FilterManager sharedFilterManager] processImage:weakSelf.origineImage withFilterType:FilterPtr];
                     weakSelf.imageView.image = temImage;
                     
                     weakSelf.tempImage2 = temImage;


                     
                 }
                     break;
             }
             
             
             
         }];
         
         
         [UIView animateWithDuration:0.3 animations:^{
             
             weakSelf.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(weakSelf.bottomBar.frame)-weakSelf.toolDetailBGView.frame.size.height, weakSelf.toolDetailBGView.frame.size.width, weakSelf.toolDetailBGView.frame.size.height);
             
         }];
     }];
    
#pragma 贴图的处理block
    [self.bottomBar setBiankuangBlock:^(BOOL isBiankuang)
     {
         CGFloat bili = 0.9;
         
         [UIView animateWithDuration:0.3 animations:^{
             if (isBiankuang) {
                 weakSelf.imageView.transform = CGAffineTransformScale(weakSelf.imageView.transform,1.f/bili ,1.f/bili);
             }else
             {
                 weakSelf.imageView.transform = CGAffineTransformScale(weakSelf.imageView.transform, bili, bili);
             }

         }];
         
         
     }];
    
    [self.bottomBar setWenziBlock:^()
     {
         weakSelf.wenziView = [[WenziView alloc] initWithFrame:CGRectMake(0, 0, 150, 70)];
         [weakSelf.bgView addSubview:weakSelf.wenziView];
         weakSelf.wenziView.center = CGPointMake(weakSelf.bgView.center.x, weakSelf.bgView.center.y);
         weakSelf.wenziView.Vctl = weakSelf;
     }];
    
/**以后另处理**/
    UIImage *tiezhiImage10  = [UIImage imageNamed:@"tiezhi_aixin"];
    UIImage *tiezhiImage1  = [UIImage imageNamed:@"tiezhi_foot"];
    UIImage *tiezhiImage2  = [UIImage imageNamed:@"tiezhi_huo"];
    UIImage *tiezhiImage3  = [UIImage imageNamed:@"tiezhi_jirou"];
    UIImage *tiezhiImage4  = [UIImage imageNamed:@"tiezhi_taiyang"];
    UIImage *tiezhiImage5  = [UIImage imageNamed:@"tiezhi_xue"];
    UIImage *tiezhiImage6  = [UIImage imageNamed:@"tiezhi_yaowan"];
    UIImage *tiezhiImage7  = [UIImage imageNamed:@"tiezhi_yun"];
    UIImage *tiezhiImage8  = [UIImage imageNamed:@"tiezhi_zan"];
    UIImage *tiezhiImage9  = [UIImage imageNamed:@"tiezhi_zhongguo"];
    UIImage *tiezhiImage0 = [UIImage imageNamed:@"tiezhi_zuanshi"];

    [self.tiezhiArray addObject:tiezhiImage0];
    [self.tiezhiArray addObject:tiezhiImage1];
    [self.tiezhiArray addObject:tiezhiImage2];
    [self.tiezhiArray addObject:tiezhiImage3];
    [self.tiezhiArray addObject:tiezhiImage4];
    [self.tiezhiArray addObject:tiezhiImage5];
    [self.tiezhiArray addObject:tiezhiImage6];
    [self.tiezhiArray addObject:tiezhiImage7];
    [self.tiezhiArray addObject:tiezhiImage8];
    [self.tiezhiArray addObject:tiezhiImage9];
    [self.tiezhiArray addObject:tiezhiImage10];

    [self.bottomBar setXingzhuangBlock:^()
     {
         //贴纸
         
         
         //设置贴纸数列
         for (UIView *view in weakSelf.toolDetailBGView.subviews) {
             if ([view isKindOfClass:[ProcessToolDetailView class]]||[view isKindOfClass:[DetailView class]]) {
                 view.hidden = YES;
             }
         }
         
         weakSelf.itemDetailView = [weakSelf.view viewWithTag:ProcessToolDetailView_tag+4];
         if (weakSelf.itemDetailView)
         {
             weakSelf.itemDetailView.hidden = NO;
         }else
         {
             weakSelf.itemDetailView = [[DetailView alloc] initWithFrame:CGRectMake(0, 2.5, CGRectGetWidth(weakSelf.toolDetailBGView.frame), CGRectGetHeight(weakSelf.toolDetailBGView.frame)) withItemArray:weakSelf.tiezhiArray];
             [weakSelf.toolDetailBGView addSubview:weakSelf.itemDetailView];
             weakSelf.itemDetailView.tag = ProcessToolDetailView_tag+4;
         }
         
         [weakSelf.itemDetailView setTapItem:^()
          {
              weakSelf.shapeView = [[ShapeView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
              [weakSelf.bgView addSubview:weakSelf.shapeView];
              weakSelf.shapeView.center = CGPointMake(weakSelf.bgView.center.x, weakSelf.bgView.center.y);
              weakSelf.shapeView.imageView.image = weakSelf.tiezhiArray[weakSelf.itemDetailView.currentPtr];
              weakSelf.shapeView.Vctl = weakSelf;
              
          }];
         
         [UIView animateWithDuration:0.3 animations:^{
             
             weakSelf.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(weakSelf.bottomBar.frame)-weakSelf.toolDetailBGView.frame.size.height, weakSelf.toolDetailBGView.frame.size.width, weakSelf.toolDetailBGView.frame.size.height);
             
         }];
         
     }];
    
#pragma 保存图片
    
    [self.bottomBar setSaveBlock:^(bool doSaveOriginPic)
     {
         if (doSaveOriginPic)
         {
             UIImageWriteToSavedPhotosAlbum(weakSelf.origineImage, weakSelf, nil, nil);
         }
         
         UIGraphicsBeginImageContextWithOptions(weakSelf.bgView.bounds.size, YES, 1);
         [weakSelf.bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
         
         UIImage *zuihoucunzhao = UIGraphicsGetImageFromCurrentImageContext();
         UIImageWriteToSavedPhotosAlbum(zuihoucunzhao, weakSelf, nil, nil);
         
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功保存到相册" message:nil preferredStyle:UIAlertControllerStyleAlert];
         
         [alertController addAction:[UIAlertAction actionWithTitle:@"再拍一张" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
         {
             [weakSelf dismissViewControllerAnimated:YES completion:^{
                 
             }];
         }]];
         
         [alertController addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
         {
             NSArray *activityItem = @[zuihoucunzhao];
             UIActivityViewController *shareViewcontroller = [[UIActivityViewController alloc] initWithActivityItems:activityItem applicationActivities:nil];
             
             shareViewcontroller.excludedActivityTypes = @[UIActivityTypeMail,UIActivityTypePrint];
             [weakSelf presentViewController:shareViewcontroller animated:YES completion:^{

             }];
             
         }]];
         
         [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             
         }]];
         
         [weakSelf presentViewController:alertController animated:YES completion:^{
             
         }];
         
         NSLog(@"成功保存照片");
     }];
    
    
    
    
    [self.view bringSubviewToFront:self.bottomBar];
    
}



- (void) shouhui
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.toolDetailBGView.frame = CGRectMake(0, CGRectGetMinY(self.bottomBar.frame), self.toolDetailBGView.frame.size.width, self.toolDetailBGView.frame.size.height);
        
    }];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    [self.wenziView refresh];
    [self.shapeView finishEdit];
    
}

- (void) resetSliderWithType: (int)type
{
    for (UIView*view in self.toolDetailBGView.subviews) {
        if ([view isKindOfClass:[ProcessToolDetailView class]]) {
            
            ProcessToolDetailView *detailView = view;
            if (detailView.type != type)
            {
                [detailView reset];
            }
        }
    }
}

- (void) tanchu
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) huanyuan:(UIGestureRecognizer *)sender
{

    self.imageView.image = self.origineImage;
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        self.imageView.image = self.tempImage2;
    }
}

@end
