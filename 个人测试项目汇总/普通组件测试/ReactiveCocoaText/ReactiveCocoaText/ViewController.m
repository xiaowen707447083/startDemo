//
//  ViewController.m
//  ReactiveCocoaText
//
//  Created by xiaowen.chen on 16/5/27.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <ReactiveCocoa/ReactiveCocoa-Swift.h>


@interface ViewController ()

@property(nonatomic,strong)UIButton *signInButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITextField *tex = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    tex.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tex];
    
    
    self.signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signInButton.frame = CGRectMake(50, 150, 100, 30);
    [self.signInButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:self.signInButton];
    
    //响应式编程
    
    
    
    
    [tex.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
 /**************************************************************/
    [[tex.rac_textSignal
     filter:^BOOL(id value){
         NSString*text = value;
         return text.length < 2;
     }]
    subscribeNext:^(id x) {
        NSLog(@"小于2？%@",x);
    }];
    
    //等价于
//    [[tex.rac_textSignal
//      filter:^BOOL(NSString *text){
//          return text.length < 2;
//      }]
//     subscribeNext:^(id x) {
//         NSLog(@"小于2？%@",x);
//     }];

 /**************************************************************/
    [tex.rac_newTextChannel subscribeNext:^(id x) {
        NSLog(@"这个是什么鬼%@",x);
    }];
    
    
    // 关于弱引用跟强引用的想法：如果是本身系统调用到block这采用弱引用的方式，map里面的，subcribenext用强引用？
    //    @weakify(self)
    //    [[self.searchText.rac_textSignal
    //      map:^id(NSString *text) {
    //          return [self isValidSearchText:text] ?
    //          [UIColor whiteColor] : [UIColor yellowColor];
    //      }]
    //     subscribeNext:^(UIColor *color) {
    //         @strongify(self)
    //         self.searchText.backgroundColor = color;
    //     }];﻿
    
    //跟进文本长度是否大于3来改变textview的颜色
//    RACSignal *validUserName = [tex.rac_newTextChannel map:^id(NSString *value) {
//        return value.length > 3 ? [UIColor redColor] : [UIColor grayColor];
//    }];
//
//    RAC(tex,backgroundColor) = validUserName;
    
    RACSignal *validUserName = [tex.rac_newTextChannel map:^id(NSString *value) {
        return @(value.length > 3 ? 1 : 0);
    }];
    
    
    RAC(tex, backgroundColor) =
    [validUserName
     map:^id(NSNumber *passwordValid){
         return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
     }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validUserName]
                      reduce:^id(NSNumber*usernameValid){
                          return @([usernameValid boolValue]);
                      }];
//    RACSignal *signUpActiveSignal =
//    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
//                      reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
//                          return @([usernameValid boolValue]&&[passwordValid boolValue]);
//                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.signInButton.enabled =[signupActive boolValue];
    }];
    
    
    
     /**************************************************************/
    
    [[self.signInButton
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         NSLog(@"button clicked");
     }];
    
    //登陆部分
    [[[self.signInButton
       rac_signalForControlEvents:UIControlEventTouchUpInside]
      flattenMap:^id(id x){//flattenMap 信号中的信号用map拿不到结果数据
          return[self signInSignal];
      }]
     subscribeNext:^(id singnResult){
//         NSLog(@"Sign in result: %@", x);
         BOOL success =[singnResult boolValue];
         if(success){
             NSLog(@"登陆成功调整");
         }
     }];
}


- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        //做一些操作，比如是网络登陆
//        [self.signInService
//         signInWithUsername:self.usernameTextField.text
//         password:self.passwordTextField.text
//         complete:^(BOOL success){
             [subscriber sendNext:@"yes"];
             [subscriber sendCompleted];
//         }];
        return nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
