//
//  FilterList.m
//  VCamera
//
//  Created by ShenZheng on 16/10/6.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "FilterList.h"
#import "FilterModel.h"
#import "ColorTypeFilterConfig.h"

@implementation FilterList

- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSArray *nameArray = @[@"黑白",@"怀旧",@"强光",@"LOMO",@"哥特",@"淡雅",@"浪漫",@"蓝调"];
        
//        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:@"", nil]
        FilterModel *heibai = [[FilterModel alloc] init];
        heibai.filterName = @"黑白";
        heibai.coverImageURL = @"";
        heibai.matrix = [NSArray arrayWithObject:@[@0.8f,  @1.6f, @0.2f, @0, @-163.9f,
                                                   @0.8f,  @1.6f, @0.2f, @0, @-163.9f,
                                                   @0.8f,  @1.6f, @0.2f, @0, @-163.9f,
                                                   @0,  @0, @0, @1.0f, @0 ]];
        
    }
    return self;
}




@end
