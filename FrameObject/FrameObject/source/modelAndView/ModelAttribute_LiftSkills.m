//
//  Planting_LiftSkills.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelAttribute_LiftSkills.h"
#import "Con_Planting.h"

@implementation ModelAttribute_LiftSkills


-(NSMutableArray *)dataList{
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
        
        ModelAttribute *attri = [[ModelAttribute alloc] init];
        attri.name = @"种植";
        [_dataList addObject:attri];
        
        
        
    }
    
    return _dataList;
}

//获取cell;
-(void)updateCell:(ModelAttribute *)model cell:(UITableViewCell *)cell{
    
    cell.detailTextLabel.text = model.name;
    
}
//获取高度
-(CGFloat)getCellHeight{
    
    
    return 50;
}

//调转到详情页面
-(void)turnToDetailWithModel:(ModelAttribute *)model viewController:(UIViewController *)viewController{
    
    Con_Planting *con = [[Con_Planting alloc] init];
    con.title = [NSString stringWithFormat:@"[%@]详细",model.name];
    [viewController.navigationController pushViewController:con animated:YES];
    
}

@end
