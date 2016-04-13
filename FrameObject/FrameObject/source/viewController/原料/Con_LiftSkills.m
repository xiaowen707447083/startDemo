//
//  Con_LiftSkills.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "Con_LiftSkills.h"
#import "ModelAttribute_LiftSkills.h"

@interface Con_LiftSkills ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)ModelAttribute_LiftSkills *mv;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tb;


@end

@implementation Con_LiftSkills

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createMyViewController{
    _mv = [[ModelAttribute_LiftSkills alloc] init];
    
    if ([self.title isEqualToString:@"原料"]) {
        _mv.type1 = @"1";
        
    }else{
        _mv.type1 = @"2";
       
    }
    _dataArr = _mv.dataList;
    
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWindowwidth, MainWindowHeight)];
    _tb.delegate = self;
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------- tableview delegate --------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_mv getCellHeight];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myTbIdentifile = @"cell";
    //根据标志获取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTbIdentifile];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myTbIdentifile];
    }
    [_mv updateCell:[_dataArr objectAtIndex:indexPath.row] cell:cell];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [_dataArr objectAtIndex:indexPath.row];
    [_mv turnToDetailWithModel:model viewController:self];
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
