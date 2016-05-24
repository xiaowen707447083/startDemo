//
//  ViewController.m
//  PinCache例子
//
//  Created by G-emall on 16/5/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "ViewController.h"
#import "PINCache.h"

//
#import "statisticalManager.h"
#import "impl1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"name：%@",[PINCache sharedCache].name);
    
    NSLog(@"disByteCount：%lu",(unsigned long)[PINCache sharedCache].diskByteCount);
    
    NSLog(@"name：%@",[PINCache sharedCache].diskCache);
    
    NSLog(@"name：%@",[PINCache sharedCache].memoryCache);
    
    
    
    //
    [[PINCache sharedCache] setObject:@"这是一个写入PINCache的内容" forKey:@"mykey"];
    [[PINDiskCache sharedCache] setObject:@"这是一个写入PINDiskCache的内容" forKey:@"mykey"];
    [[PINMemoryCache sharedCache] setObject:@"这是一个写入PINMemoryCache的内容" forKey:@"mykey"];
    
    
    NSLog(@"value：%@",[[PINCache sharedCache] objectForKey:@"mykey"]);
    NSLog(@"PINDiskCache-value：%@",[[PINDiskCache sharedCache] objectForKey:@"mykey"]);
    NSLog(@"PINMemoryCache-value：%@",[[PINMemoryCache sharedCache] objectForKey:@"mykey"]);
    
    
    
    [[PINCache sharedCache] objectForKey:@"---"  block:^(PINCache *cache, NSString *key, id object) {
        if (object) {
            
            NSLog(@"有缓存，在这里做业务逻辑处理");
            return;
        }
        //没有缓存，那么去服务器加载数据，存入缓存，做业务逻辑处理
        NSLog(@"cache miss, requesting %@", @"---");
        [[PINCache sharedCache] setObject:@"呵呵" forKey:@"---"];
    }];
    
   impl1 *impl= [[impl1 alloc] init];
    
    [statisticalManager sharedManager].manager = impl;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",@"value2",@"key2", nil];
    [[statisticalManager sharedManager] clickBtn:@"heh" params:dic];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
