//
//  ModelPlanting_Planting.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelPlanting_Planting.h"
#import "Con_PlantingDetail.h"

@implementation ModelPlanting_Planting

-(NSMutableArray *)dataList{
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
        
        ModelPlanting *attri = [[ModelPlanting alloc] init];
        attri.name = @"小麦";
        attri.tili = 500;
        attri.huoli = 600;
        attri.danwei = @"薇草";
        attri.number = 3;
        attri.times_hour = 3;
        attri.times_min = 2;
        
        [_dataList addObject:attri];
        
        
        ModelPlanting *attri1 = [[ModelPlanting alloc] init];
        attri1.name = @"金矿";
        [_dataList addObject:attri1];
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
    Con_PlantingDetail *con = [[Con_PlantingDetail alloc] init];
    con.model = model;
    con.title = model.name;
    [viewController.navigationController pushViewController:con animated:YES];
}


@end
