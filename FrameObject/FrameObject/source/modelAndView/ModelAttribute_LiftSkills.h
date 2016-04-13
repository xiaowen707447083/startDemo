//
//  Planting_LiftSkills.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ModelAttribute_LiftSkills : NSObject

//列表
@property(strong,nonatomic)NSMutableArray *dataList;
@property(strong,nonatomic)NSMutableArray *dataList1;
@property(strong,nonatomic)NSString *type1;

//获取cell;
-(void)updateCell:(NSObject *)model cell:(UITableViewCell *)cell;
//获取高度
-(CGFloat)getCellHeight;

//调转到详情页面
-(void)turnToDetailWithModel:(NSObject *)model viewController:(UIViewController *)viewController;

@end
