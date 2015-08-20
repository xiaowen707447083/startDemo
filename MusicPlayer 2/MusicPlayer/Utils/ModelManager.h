//
//  ModelManager.h
//  MusicPlayer
//
//  Created by Duke on 15/6/1.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicInfo.h"

@interface ModelManager : NSObject

+ (instancetype)sharedManger;

- (void)acquireData;

/**
 *  model对象的个数
 *
 */
- (NSInteger)countOfModels;
- (id)modelAtIndex:(NSInteger)index;


@end
