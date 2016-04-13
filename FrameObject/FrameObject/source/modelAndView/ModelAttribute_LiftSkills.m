//
//  Planting_LiftSkills.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelAttribute_LiftSkills.h"
#import "Con_Planting.h"
#import "Util_table_type2.h"

@implementation ModelAttribute_LiftSkills


-(NSMutableArray *)dataList{
    //原料
    if (_dataList == nil) {
        _dataList = [[[Util_table_type2 alloc] init] getResultsWithDictionary:@{@"type1_id":_type1}];

        
    }
    
    return _dataList;
}




//获取cell;
-(void)updateCell:(NSObject *)model cell:(UITableViewCell *)cell{
    
    cell.detailTextLabel.text = [model valueForKey:@"name"];
    
}
//获取高度
-(CGFloat)getCellHeight{
    
    
    return 50;
}

//调转到详情页面
-(void)turnToDetailWithModel:(NSObject *)model viewController:(UIViewController *)viewController{
    
    Con_Planting *con = [[Con_Planting alloc] init];
    con.type1 = _type1;
    con.type2 = [model valueForKey:@"mid"];
    con.title = [NSString stringWithFormat:@"[%@]详细",[model valueForKey:@"name"]];
    viewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:con animated:YES];
    viewController.hidesBottomBarWhenPushed = NO;
}

@end
