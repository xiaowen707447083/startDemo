//
//  ModelPlanting_PlantingDetail.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ModelPlanting_PlantingDetail.h"


@implementation ModelPlanting_PlantingDetail


-(NSString *)tf_tili_text{
    return [NSString stringWithFormat:@"体力消耗:%d",_model.tili];
}

-(NSString *)tf_huoli_text{
    return [NSString stringWithFormat:@"活力消耗:%d",_model.huoli];
}

-(NSString *)tf_duihuan_text{
    return [NSString stringWithFormat:@"兑换消耗:%@*%d",_model.danwei,_model.number];
}

-(NSString *)tf_time_text{
    NSDate *date = [NSDate date];
    NSString *tempStr = [XWDateUtil strWithDate:date withForMet:@"当前时间 ->MM月dd日 HH时:mm分"];
    if (_model.times_hour==0) {
        return [NSString stringWithFormat:@"%@ + 成熟所需时间:%d分",tempStr,_model.times_min];
    }else{
        if (_model.times_min==0) {
             return [NSString stringWithFormat:@"%@ + 成熟所需时间:%d分",tempStr,_model.times_min];
        }else{
             return [NSString stringWithFormat:@"%@ + 成熟所需时间:%d小时%d分",tempStr,_model.times_hour,_model.times_min];
        }
    }
    
}


-(NSString *)tf_time_nest{
    NSDate *date = [NSDate date];
    return [XWDateUtil getTimeAfterDay:0 hours:_model.times_hour min:_model.times_min ss:0 fromDate:date withForMet:@"收获时间 ->MM月dd日 HH时:mm分"];
}

//获取所以的配方
-(NSMutableArray *)getPeifangAll{
    NSMutableArray *resultArr = [NSMutableArray array];
    
    ModelFormula *formula = [[ModelFormula alloc] init];
    formula.name = @"这是一个测试的配方";
    formula.dynamic = 500;
    formula.PhysicalStrength = 500;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"元宝"];
     [dic setObject:@"1" forKey:@"元宝1"];
     [dic setObject:@"1" forKey:@"元宝2"];
    formula.materials = dic;
    
    [resultArr addObject:formula];
    [resultArr addObject:formula];
    return resultArr;
    
}

-(void)updateBottomView:(ModelFormula *)fo view:(UIScrollView *)scrollerView{
    if(fo == nil){
        return;
    }
    //移除所以的view
    NSArray *tempArr =  scrollerView.subviews;
    for (UIView *view in tempArr) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat width = scrollerView.frame.size.width;
    
    //名字
    UILabel *lable1 = [[UILabel alloc] init];
    [scrollerView addSubview:lable1];
    lable1.sd_layout
    .leftSpaceToView(scrollerView, 10)
    .heightIs(20)
    .topSpaceToView(scrollerView, 10);
    [lable1 setSingleLineAutoResizeWithMaxWidth:width-20];
    lable1.text = [NSString stringWithFormat:@"%@",fo.name];
    //体力
    UILabel *lable2 = [[UILabel alloc] init];
    [scrollerView addSubview:lable2];
    lable2.sd_layout
    .leftSpaceToView(scrollerView, 10)
    .heightIs(20)
    .topSpaceToView(lable1, 10);
    [lable2 setSingleLineAutoResizeWithMaxWidth:width-20];
    lable2.text = [NSString stringWithFormat:@"体力消耗:%d",fo.PhysicalStrength];
    
    //活力
    UILabel *lable3 = [[UILabel alloc] init];
    [scrollerView addSubview:lable3];
    lable3.sd_layout
    .leftSpaceToView(scrollerView, 10)
    .heightIs(20)
    .topSpaceToView(lable2, 10);
    [lable3 setSingleLineAutoResizeWithMaxWidth:width-20];
    lable3.text = [NSString stringWithFormat:@"活力消耗:%d",fo.dynamic];
    
    //材料
    NSString *cailiaoStr = @"";
    NSArray *Arr = [fo.materials allKeys];
    for (int i=0; i<Arr.count; i++) {
        NSString *temst = Arr[i];
        if (i==0) {
            cailiaoStr = [NSString stringWithFormat:@"%@%@*%@",cailiaoStr,temst,[fo.materials valueForKey:temst]];
        }else{
            cailiaoStr = [NSString stringWithFormat:@"%@,%@*%@",cailiaoStr,temst,[fo.materials valueForKey:temst]];
        }
    }
    UILabel *lable4 = [[UILabel alloc] init];
    [scrollerView addSubview:lable4];
    lable4.sd_layout
    .leftSpaceToView(scrollerView, 10)
    .rightSpaceToView(scrollerView,10)
    .topSpaceToView(lable3, 10)
    .autoHeightRatio(0);
    
    lable4.text = [NSString stringWithFormat:@"材料:%@",cailiaoStr];
    
    
    
}


@end
