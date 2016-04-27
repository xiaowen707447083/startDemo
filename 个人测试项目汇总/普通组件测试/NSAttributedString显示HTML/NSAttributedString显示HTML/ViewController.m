//
//  ViewController.m
//  NSAttributedString显示HTML
//
//  Created by shenba on 16/4/27.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createMyView];
    
}

//在app中使用Webviews有时会让人非常沮丧，即使只是显示少量的HTMLneirong ,Webviews也会消耗大量的内容。现在iOS7让这些变得简单了，你可以从用少量代码在HTML文件中创建一个NSAttributedString
-(void)createMyView{
    
    //<meta charset=\"UTF-8\"> 加入这个是为了解决中文乱码问题
    NSString *html = @ "<meta charset=\"UTF-8\"> <bold>Wow!</bold> Now <em>iOS</em> can create <font size=\"4\" color=\"red\">NSAttributedString</font>   <h1>from</h1> <font size=\"7\" color=\"red\">HTMLs!</font> 请<a href = \"http://www.baidu.com\">点击百度</a>" ;
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:options documentAttributes:nil error:nil];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 340, 200)];
    [self.view addSubview:label];
    label.numberOfLines = 10;
    label.attributedText = attrString;
    
    [label sizeToFit];
    label.backgroundColor = [UIColor grayColor];
    
    
    //关于如果添加点击事件
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
