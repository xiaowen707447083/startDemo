//
//  main.m
//  普通测试项目
//
//  Created by shenba on 16/3/31.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "Student.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    
//    Student *stu = [[Student alloc] init];
//    Student *stu2=[stu copy];
//    stu2.name=@"XZQ";
//    NSLog(@"%@",stu);
//    NSLog(@"%@",stu2);
 
    
    NSString *str = @"ddddd";
    

        int a = 0x1234;
        char b =  *(char *)&a;  //通过将int强制类型转换成char单字节，通过判断起始存储位置。即等于 取b等于a的低地址部分
        if( b == 0x12)
        {
            NSLog(@"大端");
        }else{
            NSLog(@"小端");
        }
    


    return 0;
}


