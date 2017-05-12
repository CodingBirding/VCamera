//
//  BottomBarView.h
//  VCamera
//
//  Created by ShenZheng on 16/9/25.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"

@interface BottomBarView : UIView

@property (nonatomic, copy) VoidBlockType takePhotoBlock;
@property (nonatomic, copy) VoidBlockType flipBlock;
@property (nonatomic, copy) VoidBlockType albumBlock;
@end
