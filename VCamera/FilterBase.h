//
//  FilterBase.h
//  VCamera
//
//  Created by ShenZheng on 16/10/5.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FilterBase : NSObject

@property (nonatomic, assign) int ID;
@property (nonatomic, assign) NSString *name;

- (UIImage *)processImage: (UIImage *)originalImage;

@end
