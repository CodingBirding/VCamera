//
//  Filter_Qiangguang.m
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "Filter_Qiangguang.h"
#import "SynthesizeSingleton.h"
#import "opencv2/opencv.hpp"
#import <opencv2/videoio/cap_ios.h>
#import "opencv2/imgcodecs/ios.h"
using namespace std;
using namespace cv;

@implementation Filter_Qiangguang

SYNTHESIZE_SINGLETON_FOR_CLASS(Filter_Qiangguang)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = Filter_Type_Qiangguang;
        self.name = @"强光";
    }
    return self;
}

- (UIImage *)processImage: (UIImage *)originalImage
{
    Mat originalMat;
    UIImageToMat(originalImage, originalMat);
    
    int imageRow = originalMat.rows;
    int imageCol = originalMat.cols;
    
    Mat tem = originalMat;
    
    cvtColor(tem, tem, CV_RGB2BGR);
    
    for (int i=0; i < imageRow; i++){
        for (int j=0; j < imageCol; j++) {
            uchar R = tem.at<Vec3b>(i,j)[0];
            uchar G = tem.at<Vec3b>(i,j)[1];
            uchar B = tem.at<Vec3b>(i,j)[2];
            
            float newB;
            float newG;
            float newR;
            if (R > 127.5)
            {
                newR = R+(255-R)*(R-127.5)/127.5;
            }else
            {
                newR = R*R/127.5;
            }
            
            if (G > 127.5)
            {
                newG = G+(255-G)*(G-127.5)/127.5;
            }else
            {
                newG = G*G/127.5;
            }
            
            if (B > 127.5)
            {
                newB = B+(255-B)*(B-127.5)/127.5;
            }else
            {
                newB = B*B/127.5;
            }
            
            if(newB<0)
                newB=0;
            if(newB>255)
                newB=255;
            if(newG<0)
                newG=0;
            if(newG>255)
                newG=255;
            if(newR<0)
                newR=0;
            if(newR>255)
                newR=255;
            
            tem.at<Vec3b>(i,j)[0] = (uchar)newB;
            tem.at<Vec3b>(i,j)[1] = (uchar)newG;
            tem.at<Vec3b>(i,j)[2] = (uchar)newR;
        }
    }
    
    UIImage *editedImage = MatToUIImage(tem);
    return editedImage;
}

@end
