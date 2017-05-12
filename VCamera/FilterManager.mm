//
//  FilterManager.m
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FilterManager.h"
#import "BaseDefines.h"
#import "SynthesizeSingleton.h"
#import <UIKit/UIKit.h>
#import "Filter_Qiangguang.h"
#import "opencv2/opencv.hpp"
#import <opencv2/videoio/cap_ios.h>
#import "opencv2/imgcodecs/ios.h"
#import "ColorTypeFilterConfig.h"
#import "FilterList.h"



using namespace std;
using namespace cv;
@interface FilterManager()



@end

@implementation FilterManager

SYNTHESIZE_SINGLETON_FOR_CLASS(FilterManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.realTimeFilterPtr = 0;
    }
    return self;
}

#pragma 滤镜计算

- (UIImage *) processImage: (UIImage *)originalImage withFilterType: (int)type
{
    UIImage *editedImage = [[UIImage alloc] init];
    switch (type) {
        case Filter_Type_Yuantu:
        {
            editedImage = originalImage;
        }
            break;
        case Filter_Type_Huaijiu:
        {
            editedImage = [self processImage:originalImage withFilterMetrix:colormatrix_huaijiu];
        }
            break;
        case Filter_Type_Heibai:
        {
            editedImage = [self processImage:originalImage withFilterMetrix:colormatrix_heibai];
        }
            break;
        case Filter_Type_Qiangguang:
        {
            editedImage = [[Filter_Qiangguang sharedFilter_Qiangguang] processImage:originalImage];
        }
            break;
        case Filter_Type_LOMO:
        {
            editedImage = [self processImage:originalImage withFilterMetrix:colormatrix_lomo];
        }
            break;
        case Filter_Type_Gete:
        {
            editedImage = [self processImage:originalImage withFilterMetrix:colormatrix_gete];
        }
            break;
        case Filter_Type_Danya:
        {
            editedImage = [[FilterManager sharedFilterManager] processImage:originalImage withFilterMetrix:colormatrix_danya];
        }
            break;
        case Filter_Type_Langman:
        {
            editedImage = [[FilterManager sharedFilterManager] processImage:originalImage withFilterMetrix:colormatrix_langman];
        }
            break;
        case Filter_Type_Landiao:
        {
            editedImage = [[FilterManager sharedFilterManager] processImage:originalImage withFilterMetrix:colormatrix_landiao];
        }
            break;
        default:
            break;
    }
    return editedImage;
}

- (UIImage *) processImage: (UIImage *)originalImage withFilterMetrix: (const float *)matrix
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

            float newR=SAFECOLOR(matrix[0]*R+matrix[1]*G+matrix[2]*B+matrix[4]);
            float newG=SAFECOLOR(matrix[0+5]*R+matrix[1+5]*G+matrix[2+5]*B+matrix[4+5]);
            float newB=SAFECOLOR(matrix[0+2*5]*R+matrix[1+2*5]*G+matrix[2+2*5]*B+matrix[4+2*5]);
            
            tem.at<Vec3b>(i,j)[0] = newB;
            tem.at<Vec3b>(i,j)[1] = newG;
            tem.at<Vec3b>(i,j)[2] = newR;
        }
    }
    
    UIImage *editedImage = MatToUIImage(tem);
    return editedImage;
}

#pragma filterList
- (NSArray *)currentFilterList
{
    NSArray *filterName = @[@"原图",@"怀旧",@"黑白",@"强光",@"LOMO",@"哥特",@"淡雅",@"浪漫",@"蓝调"];
    
    return filterName;
}

#pragma 图像参数调整

- (UIImage *) processImage: (UIImage *)originImage withCoefficient: (CGFloat)coefficient withProcessType:(int)type
{
    
    Mat originalMat;
    UIImageToMat(originImage, originalMat);
    
    int imageRow = originalMat.rows;
    int imageCol = originalMat.cols;
    
    Mat tem = originalMat;
    cvtColor(tem, tem, CV_RGB2BGR);
    
    for (int i=0; i < imageRow; i++){
        for (int j=0; j < imageCol; j++) {
            uchar R = tem.at<Vec3b>(i,j)[0];
            uchar G = tem.at<Vec3b>(i,j)[1];
            uchar B = tem.at<Vec3b>(i,j)[2];
            
            float newR;
            float newG;
            float newB;
            
            switch (type) {
                case ProcessCoefficientType_Duibi:
                {
                    
                    #define CalContrast(f, c) (f - 127.5) * c + 127.5

                    newR = SAFECOLOR(CalContrast(R, coefficient));
                    newG = SAFECOLOR(CalContrast(G, coefficient));
                    newB = SAFECOLOR(CalContrast(B, coefficient));
                }
                    break;
                case ProcessCoefficientType_Baoguang:
                {
                    newR = SAFECOLOR(R * coefficient);
                    newB = SAFECOLOR(B * coefficient);
                    newG = SAFECOLOR(G * coefficient);
                }
                    break;
                case ProcessCoefficientType_Baohe:
                {
                    int average = (R+G+B)/3;
                    double t = (double)coefficient;
                    newR = SAFECOLOR(average + t * (R - average));
                    newG = SAFECOLOR(average + t * (G - average));
                    newB = SAFECOLOR(average + t * (B - average));
                }
                    break;
                    
                default:
                    break;
            }
            
            tem.at<Vec3b>(i,j)[0] = (uchar)newB;
            tem.at<Vec3b>(i,j)[1] = (uchar)newG;
            tem.at<Vec3b>(i,j)[2] = (uchar)newR;
        }
    }
    
    UIImage *editedImage = MatToUIImage(tem);
    return editedImage;
    
}
@end
