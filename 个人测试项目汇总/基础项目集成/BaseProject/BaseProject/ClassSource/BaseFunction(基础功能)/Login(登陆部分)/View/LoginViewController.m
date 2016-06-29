//
//  LoginViewController.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/6/21.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "LoginViewController.h"
//测试用
#import "LoginInfoTable.h"

@interface LoginViewController ()

@property(strong,nonatomic)UITextField *nameTextField;
@property(strong,nonatomic)UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMyView];
}

-(void)createMyView{
    //用户名
    _nameTextField = [[UITextField alloc] init];
    _nameTextField.text = @"2222222222";
    [self.view addSubview:_nameTextField];
    _nameTextField.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view,50)
    .rightEqualToView(self.view)
    .heightIs(40);
    _nameTextField.backgroundColor = [UIColor grayColor];
    
    //密码
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.text = @"2222222222";
    [self.view addSubview:_passwordTextField];
    _passwordTextField.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(_nameTextField,10)
    .rightEqualToView(self.view)
    .heightIs(40);
    _passwordTextField.backgroundColor = [UIColor grayColor];
    _passwordTextField.secureTextEntry = YES;
    
    //按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    loginBtn.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(_passwordTextField,15)
    .rightEqualToView(self.view)
    .heightIs(40);
    loginBtn.backgroundColor = [UIColor grayColor];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onClickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //按钮-添加
    UIButton *loginBtn_add = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn_add];
    loginBtn_add.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(loginBtn,15)
    .rightEqualToView(self.view)
    .heightIs(40);
    loginBtn_add.backgroundColor = [UIColor grayColor];
    [loginBtn_add setTitle:@"添加" forState:UIControlStateNormal];
    [loginBtn_add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn_add addTarget:self action:@selector(onClickLoginBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮-修改
    UIButton *loginBtn_update = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn_update];
    loginBtn_update.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(loginBtn_add,15)
    .rightEqualToView(self.view)
    .heightIs(40);
    loginBtn_update.backgroundColor = [UIColor grayColor];
    [loginBtn_update setTitle:@"修改" forState:UIControlStateNormal];
    [loginBtn_update setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn_update addTarget:self action:@selector(onClickLoginBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮-查找
    UIButton *loginBtn_select = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn_select];
    loginBtn_select.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(loginBtn_update,15)
    .rightEqualToView(self.view)
    .heightIs(40);
    loginBtn_select.backgroundColor = [UIColor grayColor];
    [loginBtn_select setTitle:@"查找" forState:UIControlStateNormal];
    [loginBtn_select setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn_select addTarget:self action:@selector(onClickLoginBtn3) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮-刪除
    UIButton *loginBtn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn_delete];
    loginBtn_delete.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(loginBtn_select,15)
    .rightEqualToView(self.view)
    .heightIs(40);
    loginBtn_delete.backgroundColor = [UIColor grayColor];
    [loginBtn_delete setTitle:@"刪除" forState:UIControlStateNormal];
    [loginBtn_delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn_delete addTarget:self action:@selector(onClickLoginBtn4) forControlEvents:UIControlEventTouchUpInside];
}



#pragma -mark 事件触发
-(void)onClickLoginBtn{
    
    if (![_nameTextField.text isMatchedByRegex:CHECK_USER_NAME]) {
        UIAlert_auto(nil, @"用户名不合法", 1);
        return;
        
    }
    if (![_passwordTextField.text isMatchedByRegex:CHECK_PASSWORD]) {
        UIAlert_auto(nil, @"密码不合法", 1);
        return;
    }
    

    
    
    NSString *testUrl = @"http://192.168.2.5:8082/MyJFinalApp/login";
    
    AFHTTPSessionManager *session = [[MyAFHTTPSessionManager sharedManager] getSessionManager];
    session.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传普通格式
    [session.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Content-type"];//设置请求的头

    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = _nameTextField.text;
    params[@"passWord"] = _passwordTextField.text;

    
    [session POST:testUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"注册请求成功");
        [[MyAFHTTPSessionManager sharedManager] returnToSessionManager:session];
        [TestListenUtil pushNectRequestResult:testUrl error:nil responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error1) {
        DLog(@"注册请求失败");
        [[MyAFHTTPSessionManager sharedManager] returnToSessionManager:session];
        [TestListenUtil pushNectRequestResult:testUrl error:error1 responseObject:nil];
    }];

    
    
    NSString *bundleVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    DLog(@"bundleVersionL:%@",bundleVersion);
    

}

-(void)onClickLoginBtn1{
    DLog(@"%@",NSHomeDirectory());
    
   LoginInfoTable *log = [[LoginInfoTable alloc] init];
    [log adddataBaseWithConditions:@{@"name":@"小明",@"mid":@"gw123",@"age":@"17",@"address":@"广州",@"phoneNumber":@"13610245588",@"weight":@"33.56",@"birthDay":@"2012-11-11 20:11:12"}];
    
}
-(void)onClickLoginBtn2{
    
    LoginInfoTable *log = [[LoginInfoTable alloc] init];
    [log updateDataBase:@{@"name":@"小红"} withConditions:@{@"age":@"17"}];
//    [log updateDataBase:@{@"name":@"小红"} withConditions:@{@"name":@"小明"}];
    
}
-(void)onClickLoginBtn3{
    
    LoginInfoTable *log = [[LoginInfoTable alloc] init];
//    NSMutableArray *resultArr = [log getResultsWithDictionary:@{@"name":@"小明"}];
    NSMutableArray *resultArr = [log getResultsWithDictionary:@{@"birthDay":@"<2012-11-11 20:11:14,>2012-11-11 20:11:10",@"age":@"<10"}];
    
    for (NSDictionary *obj in resultArr) {
        
        LoginInfoTable *info = [[LoginInfoTable alloc] init];
//        info.age = [[obj valueForKey:@"age"] intValue];
//        info.birthDay = [obj valueForKey:@"birthDay"];
        
        [info setValuesForKeysWithDictionary:obj];
        
        DLog(@"%@",info.birthDay);
    }
   
    
}
-(void)onClickLoginBtn4{
    
    LoginInfoTable *log = [[LoginInfoTable alloc] init];
    [log deleteDataBaseWithConditions:@{@"phoneNumber":@"13610245588"}];
    
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
