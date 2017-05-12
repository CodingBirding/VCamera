//
//  ImageProcessingViewController.h
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"
@interface ImageProcessingViewController : UIViewController

@property (nonatomic, copy) returnImageArrayBlockType imageBlock;
@property (nonatomic, retain) UIImage *myImage;



@end
