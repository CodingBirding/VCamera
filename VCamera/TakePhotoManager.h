//
//  TakePhotoManager.h
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "BaseDefines.h"

@interface TakePhotoManager : NSObject

@property (nonatomic, copy) ArrayBlockType imagesBlock;
@property (nonatomic, retain) NSMutableArray *takenImages;
@property (nonatomic, retain) NSMutableArray *originalImages;
@property (nonatomic, assign) int photoNumber;
@property (nonatomic, assign) int numberOfPhotoHaveTaken;

- (void) setNumberOfPhotoToTake: (int)photoNumber;

- (void) setOneImage: (UIImage *)image withOriginImage: (UIImage *) originImage;
+ (instancetype) sharedTakePhotoManager;
+(NSMutableArray *)takenImagesArray;
+(NSMutableArray *)originImagesArray;

@end
