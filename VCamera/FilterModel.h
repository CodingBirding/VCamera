//
//  FilterModel.h
//  VCamera
//
//  Created by ShenZheng on 16/10/6.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property (nonatomic, copy) NSString *coverImageURL;
@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, retain) NSArray *matrix;

@end
