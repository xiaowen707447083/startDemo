//
//  HomeSearch_SelectViewController.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/15.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "HomeSearch_SelectViewController.h"
#import "UIView+SDAutoLayout.h"

@interface HomeSearch_SelectViewController ()

@end

@implementation HomeSearch_SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"筛选";
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createMyView];
}



-(void)createMyView{
    
  NSArray *arr =  @[@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"},@{@"brand_pic":@"url",@"brand_sort":@"130",@"id":@"417",@"name":@"荷兰牛栏",@"show_type":@"1"}];
    
    [self getViewBrandWithY:0 name:@"品牌" arr:arr];
    
}


//获取品牌的view
-(UIView *)getViewBrandWithY:(CGFloat)y name:(NSString *)name arr:(NSArray *)arr{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //名字
    UILabel *nameLable = [[UILabel alloc] init];
    [view addSubview:nameLable];
    nameLable.text = name;
    [nameLable sizeToFit];
    
    nameLable.sd_layout.topSpaceToView(view,20)
    .leftSpaceToView(view,10);
    
    //更多
    if ([arr isKindOfClass:[NSArray class]]) {
        if (arr.count>8) {
            
            UIButton *moreBtn = [[UIButton alloc] init];
            [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
            [view addSubview:moreBtn];
            moreBtn.sd_layout.rightSpaceToView(view,10)
            .topEqualToView(nameLable);
            [moreBtn addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchDragInside];
            
            
        }
    }
    
    //横线添加
    UIView *lineView = [[UIView alloc] init];
    [view addSubview:lineView];
    lineView.sd_layout.topSpaceToView(nameLable,20)
    .leftSpaceToView(view,10)
    .rightEqualToView(view);
    lineView.backgroundColor = [UIColor redColor];
    
    //间隔计算
    CGFloat img_width = (view.frame.size.width-5*10)/4;
    CGFloat img_height = img_width/2;

    CGFloat image_y1 = lineView.frame.size.height+lineView.frame.origin.y+10;
    CGFloat image_y2 = image_y1 + img_height + 10;
    
    for (int i=0; i<8&&i<arr.count; i++) {
        
        NSDictionary *tempDic = arr[i];
        if ([tempDic isKindOfClass:[NSDictionary class]]) {
            
            UIImageView *tempImageView = [[UIImageView alloc] init];
            tempImageView.tag = i;
            tempImageView.image = [UIImage imageNamed:@"home_search"];
            tempImageView.userInteractionEnabled = YES;
            tempImageView.contentMode = UIViewContentModeScaleAspectFit;
            
            if (i<4) {//第一排
                tempImageView.frame = CGRectMake(10+i*(10+img_width), image_y1, img_width, img_height);
            }else{
                tempImageView.frame = CGRectMake(10+(i-4)*(10+img_width), image_y2, img_width, img_height);
            }
        }
    }
    
    return view;
    
}


#pragma -mark -------------action-------------
-(void)clickMore{
    NSLog(@"你点击了更多");
}


//获取分类的view


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
