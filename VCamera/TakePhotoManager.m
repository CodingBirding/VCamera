//
//  TakePhotoManager.m
//  VCamera
//
//  Created by ShenZheng on 16/9/26.
//  Copyright © 2016年 ShenZheng. All rights reserved.
//

#import "TakePhotoManager.h"

@interface TakePhotoManager()

//@property NSTimer *myTimer;

@end

@implementation TakePhotoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(TakePhotoManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.takenImages = [[NSMutableArray alloc] init];
        self.originalImages = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) setNumberOfPhotoToTake: (int)photoNumber
{
    self.photoNumber = photoNumber;
    self.numberOfPhotoHaveTaken = 0;
    [self.takenImages removeAllObjects];
    [self.originalImages removeAllObjects];
}

- (void) setOneImage: (UIImage *)image withOriginImage: (UIImage *) originImage;
{
    [self.takenImages addObject:image];
    [self.originalImages addObject:originImage];
    self.numberOfPhotoHaveTaken++;
}

+(NSMutableArray *)takenImagesArray
{
    return [TakePhotoManager sharedTakePhotoManager].takenImages;
}

+(NSMutableArray *)originImagesArray
{
    return [TakePhotoManager sharedTakePhotoManager].originalImages;

}

@end
