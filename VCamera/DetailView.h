//
//  DetailView.h
//  VCamera
//
//  Created by ShenZheng on 16/10/9.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefines.h"

@interface DetailView : UIView

@property (nonatomic) int currentPtr;
@property (nonatomic, retain) NSArray *items;

@property (nonatomic, copy) VoidBlockType tapItem;

- (instancetype)initWithFrame:(CGRect)frame withItemArray: (NSArray *)itemArray;

@end
