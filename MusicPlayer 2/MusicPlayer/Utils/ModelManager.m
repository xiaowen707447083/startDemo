//
//  ModelManager.m
//  MusicPlayer
//
//  Created by Duke on 15/6/1.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "ModelManager.h"
@interface ModelManager ()

@property (nonatomic, retain) NSMutableArray *datasource;
/**
 *  获取远端数据
 */
- (void)_acquireData;

@end
@implementation ModelManager

- (void)_acquireData {
    NSArray *contents = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"]];
    //先清空datasource
    [self.datasource removeAllObjects];
    
    for (NSDictionary *dict in contents) {
        MusicInfo *music = [MusicInfo musicInfoWithDictionary:dict];
        [self.datasource addObject:music];
    }
    
    //发起通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDataDidFinishAcquire" object:nil];
}

//lazy loading
- (NSMutableArray *)datasource {
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

+ (instancetype)sharedManger {
    static ModelManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ModelManager alloc] init];
//        [manager _acquireData];
    });
    return manager;
}

- (void)acquireData {
    [self _acquireData];
}

- (NSInteger)countOfModels {
    return self.datasource.count;
}

- (id)modelAtIndex:(NSInteger)index {
    return self.datasource[index];
}


@end
