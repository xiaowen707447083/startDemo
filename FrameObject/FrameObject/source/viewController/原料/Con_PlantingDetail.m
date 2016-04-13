//
//  Con_PlantingDetail.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "Con_PlantingDetail.h"

@interface Con_PlantingDetail ()<UIActionSheetDelegate>
{
    UIScrollView *scrollView;
}
@property(nonatomic,strong)ModelPlanting_PlantingDetail *mv;


@property(nonatomic,strong)UILabel *tf_tili;
@property(nonatomic,strong)UILabel *tf_huoli;
@property(nonatomic,strong)UILabel *tf_duihuan;

@property(nonatomic,strong)UILabel *tf_shijian;
@property(nonatomic,strong)UILabel *tf_shijian2;

@property(nonatomic,strong)UIScrollView *peiFangScrollView;

@end

@implementation Con_PlantingDetail

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark --------action-----------
-(void)onclickRight{
    
    NSMutableArray *arr = [_mv getPeifangAll];

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Dynamic UIActionSheet"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    
    for ( ModelFormula *formul in arr) {
         [sheet addButtonWithTitle:formul.name];
    }
   
    [sheet showFromRect:self.view.bounds inView:self.view animated:YES];

}

-(void)createMyViewController{
    
    //添加右键菜单
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部配方" style:UIBarButtonItemStyleDone target:self action:@selector(onclickRight)];
    
    _mv = [[ModelPlanting_PlantingDetail alloc] init];
    _mv.model = _model;
    
     scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    _tf_tili = [[UILabel alloc] init];
    _tf_tili.backgroundColor = [UIColor yellowColor];
    _tf_tili.text = _mv.tf_tili_text;
    
    _tf_huoli = [[UILabel alloc] init];
    _tf_huoli.backgroundColor = [UIColor yellowColor];
    _tf_huoli.text = _mv.tf_huoli_text;
    
    _tf_duihuan = [[UILabel alloc] init];
    _tf_duihuan.backgroundColor = [UIColor yellowColor];
    _tf_duihuan.text = _mv.tf_duihuan_text;
    
    _tf_shijian = [[UILabel alloc] init];
    _tf_shijian.backgroundColor = [UIColor yellowColor];
    _tf_shijian.text = _mv.tf_time_text;
    
    _tf_shijian2 = [[UILabel alloc] init];
    _tf_shijian2.backgroundColor = [UIColor yellowColor];
    _tf_shijian2.text = _mv.tf_time_nest;
    
    _tf_tili.font = [UIFont systemFontOfSize:15];
    _tf_huoli.font = [UIFont systemFontOfSize:15];
    _tf_duihuan.font = [UIFont systemFontOfSize:15];
    _tf_shijian.font = [UIFont systemFontOfSize:11];
    _tf_shijian2.font = [UIFont systemFontOfSize:15];
    
    [scrollView sd_addSubviews:@[self.tf_tili, self.tf_huoli, self.tf_duihuan, self.tf_shijian, self.tf_shijian2]];
    scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    _tf_tili.sd_layout
    .leftSpaceToView(scrollView, 50)
    .heightIs(20)
    .topSpaceToView(scrollView, 10);
    [_tf_tili setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    _tf_huoli.sd_layout
    .leftSpaceToView(scrollView, 50)
    .heightIs(20)
    .topSpaceToView(_tf_tili, 10);
    [_tf_huoli setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    _tf_duihuan.sd_layout
    .leftSpaceToView(scrollView, 50)
    .heightIs(20)
    .topSpaceToView(_tf_huoli, 10);
    [_tf_duihuan setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    _tf_shijian.sd_layout
    .leftSpaceToView(scrollView, 10)
    .heightIs(20)
    .topSpaceToView(_tf_duihuan, 30);
    [_tf_shijian setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    _tf_shijian2.sd_layout
    .leftSpaceToView(scrollView, 10)
    .heightIs(20)
    .topSpaceToView(_tf_shijian, 10);
    [_tf_shijian2 setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    [self addBottomView];
    
}

-(void)addBottomView{
    
    UILabel *tempLable = [[UILabel alloc] init];
    tempLable.text = @"配方:";
    [scrollView addSubview:tempLable];
    
    tempLable.sd_layout
    .leftSpaceToView(scrollView, 50)
    .heightIs(20)
    .topSpaceToView(_tf_shijian2, 30);
    [tempLable setSingleLineAutoResizeWithMaxWidth:MainWindowwidth-20];
    
    
    UIView *tempView = [[UIView alloc] init];
    [scrollView addSubview:tempView];
    tempView.sd_layout
    .widthIs(MainWindowwidth-50)
    .leftSpaceToView(scrollView,25)
    .topSpaceToView(tempLable,20)
    .bottomSpaceToView(scrollView,200);
    
    
    //根据配方进行分类
    _peiFangScrollView = [[UIScrollView alloc] init];
    [tempView addSubview:_peiFangScrollView];
    _peiFangScrollView.backgroundColor = [UIColor grayColor];
    _peiFangScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    
    NSMutableArray *arr = [_mv getPeifangAll];
    [_mv updateBottomView:arr[0] view:_peiFangScrollView];
}


#pragma mark ---------- actionsheet delegate ------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        return;
    }
    
    NSMutableArray *arr = [_mv getPeifangAll];
    [_mv updateBottomView:arr[buttonIndex-1] view:_peiFangScrollView];
    
}


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
