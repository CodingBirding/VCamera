//
//  AttachBaseView.h
//  VCamera
//
//  Created by ShenZheng on 16/10/8.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"

@interface AttachBaseView : UIView
@property (nonatomic, retain) UIView *biankuangView;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, retain) UIViewController *Vctl;
@property (nonatomic, retain) UIImageView *deletImageView;

@end
