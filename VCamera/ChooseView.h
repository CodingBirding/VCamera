//
//  chooseView.h
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"

@interface ChooseView : UIView

@property (nonatomic, copy) ArrayBlockType imageArrayBlock;
@property (nonatomic, copy) ArrayBlockType originImageArrayBlock;
@property (nonatomic, copy) VoidBlockType confirmBlock;
@property (nonatomic, copy) VoidBlockType cancelBlock;
@property (nonatomic, assign) int jishu;
@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *selectedOriginImage;
@property (nonatomic, retain) NSMutableArray *originImages;

- (void)setNeedPhotoNumber: (int)photoNumbers;

@end
