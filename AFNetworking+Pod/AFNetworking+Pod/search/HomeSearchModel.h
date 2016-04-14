//
//  HomeSearchModel.h
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Key_Word;
@interface HomeSearchModel : NSObject


@property (nonatomic, strong) NSArray<Key_Word *> *key_word;


@end
@interface Key_Word : NSObject

@property (nonatomic, copy) NSString *kw_name;

@property (nonatomic, copy) NSString *is_recommend;

@end

