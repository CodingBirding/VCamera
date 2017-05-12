//
//  ProcessingBottomBar.h
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"

@interface ProcessingBottomBar : UIView

@property (nonatomic, copy) VoidBlockType leftBlock;
@property (nonatomic, copy) VoidBlockType rightBlock;
@property (nonatomic, copy) VoidBlockType cancelBlock;
@property (nonatomic, copy) BoolBlockType saveBlock;

@property (nonatomic, copy) VoidBlockType duibiBlock;
@property (nonatomic, copy) VoidBlockType baoguangBlock;
@property (nonatomic, copy) VoidBlockType baoheBlock;
@property (nonatomic, copy) VoidBlockType lvjingBlock;

@property (nonatomic, copy) BoolBlockType biankuangBlock;
@property (nonatomic, copy) VoidBlockType wenziBlock;
@property (nonatomic, copy) VoidBlockType xingzhuangBlock;

@property (nonatomic) BOOL doSaveOriginalPic;
@property (nonatomic) BOOL isBiankuang;

@end
