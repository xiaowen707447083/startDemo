//
//  DownLoadTool.h
//  UI18_UICollectionView
//
//  Created by lanou on 15/7/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DownLoadToolDelegate <NSObject>

-(void)sendDataFromTool:(NSData *)data;

@end


@interface DownLoadTool : NSObject

/**
 *  同步不带中文的请求
 *
 *  @param strUrl <#strUrl description#>
 */
-(void)downLoadData:(NSString *)strUrl;

@property(nonatomic,weak)id<DownLoadToolDelegate>myDelegate;


@end
