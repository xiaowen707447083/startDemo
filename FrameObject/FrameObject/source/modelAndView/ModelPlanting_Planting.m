//
//  ModelPlanting_Planting.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelPlanting_Planting.h"
#import "Con_PlantingDetail.h"

#import "Util_table_planting.h"
#import "Util_table_formula.h"

@implementation ModelPlanting_Planting

-(NSMutableArray *)dataList{
    
    if (_dataList == nil) {
        if ([_type1 isEqualToString:@"1"]) {//原料
            
            NSMutableArray *tempArr = [[[Util_table_planting alloc] init] getResultsWithDictionary:@{@"type2_id":_type2}];
            
            _dataList = [NSMutableArray array];
            for (NSDictionary *tempDic in tempArr) {
                ModelPlanting *temp = [[ModelPlanting alloc] init];
                temp.name = [tempDic valueForKey:@"name"];
                temp.mId = [[tempDic valueForKey:@"mId"] intValue];
                temp.type1_id = [[tempDic valueForKey:@"type1_id"] intValue];
                temp.type2_id = [[tempDic valueForKey:@"type2_id"] intValue];
                temp.times_hour = [[tempDic valueForKey:@"times_hour"] intValue];
                temp.times_min = [[tempDic valueForKey:@"times_min"] intValue];
                temp.tili = [[tempDic valueForKey:@"tili"] intValue];
                temp.huoli = [[tempDic valueForKey:@"huoli"] intValue];
                temp.number = [[tempDic valueForKey:@"number"] intValue];
                temp.danwei = [tempDic valueForKey:@"danwei"];
                [_dataList addObject:temp];
            }
           
        }else{
           NSMutableArray *tempArr = [[[Util_table_formula alloc] init] getResultsWithDictionary:@{@"type2_id":_type2}];
            
            _dataList = [NSMutableArray array];
            for (NSDictionary *tempDic in tempArr) {
                ModelFormula *temp = [[ModelFormula alloc] init];
                temp.name = [tempDic valueForKey:@"name"];
                temp.mid = [[tempDic valueForKey:@"mid"] intValue];
                temp.type1_id = [[tempDic valueForKey:@"type1_id"] intValue];
                temp.type2_id = [[tempDic valueForKey:@"type2_id"] intValue];

                temp.dynamic = [[tempDic valueForKey:@"dynamic"] intValue];
                temp.PhysicalStrength = [[tempDic valueForKey:@"PhysicalStrength"] intValue];
                [_dataList addObject:temp];
            }
            
        }
    }
    return _dataList;
}

//获取cell;
-(void)updateCell:(ModelPlanting *)model cell:(UITableViewCell *)cell{
    
    cell.detailTextLabel.text = model.name;
    
}
//获取高度
-(CGFloat)getCellHeight{

    return 50;
}

//调转到详情页面
-(void)turnToDetailWithModel:(ModelPlanting *)model viewController:(UIViewController *)viewController{
    
    
    if ([_type1 isEqualToString:@"1"]) {//原料
        
        Con_PlantingDetail *con = [[Con_PlantingDetail alloc] init];
        con.model = model;
        con.title = model.name;
        viewController.hidesBottomBarWhenPushed = YES;
        [viewController.navigationController pushViewController:con animated:YES];
        viewController.hidesBottomBarWhenPushed = NO;
        
        
    }else{
        //暂未实现
        
    }

    
}


@end
