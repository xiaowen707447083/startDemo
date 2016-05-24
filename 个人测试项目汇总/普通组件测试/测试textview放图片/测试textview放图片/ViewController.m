//
//  ViewController.m
//  测试textview放图片
//
//  Created by G-emall on 16/5/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extension.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMyView];
    // Do any additional setup after loading the view, typically from a nib.
}

//根据正则表达是把符合条件的替换为目标图片
- (void)changeResult:(NSAttributedString *)imgStr attrString:(NSMutableAttributedString *)attrString pattern:(NSString *)pattern{
    
    NSArray *resultArr =   [attrString.string machesWithPattern:pattern];
    NSUInteger lengthDetail = 0;
    for (NSTextCheckingResult *result in resultArr) {
        
//        NSLog(@"result.range.location:%ld,result.range.length:%ld",result.range.location,result.range.length);
        
        NSUInteger length = result.range.length;
        NSRange newRange = NSMakeRange(result.range.location-lengthDetail, result.range.length);
        [attrString replaceCharactersInRange:newRange withAttributedString:imgStr];
        lengthDetail += length - imgStr.length;
        
    }
}


//根据正则表达是把符合条件的替换为目标字符串
- (NSString *)changeResultStr:(NSString *)str attrString:(NSString *)string pattern:(NSString *)pattern {
    NSArray *resultArr =   [string machesWithPattern:pattern];
    
    NSUInteger lengthDetail = 0;
    for (NSTextCheckingResult *result in resultArr) {
        
        NSUInteger length = result.range.length;
        NSRange newRange = NSMakeRange(result.range.location-lengthDetail, result.range.length);
        string = [string stringByReplacingCharactersInRange:newRange withString:str];
        lengthDetail += length - str.length;
        
    }
    
    return string;
}


-(void)createMyView{
    NSString *html = @ "<meta charset=\"UTF-8\"> <bold>Wow!点击</bold> Now <em>iOS</em> can create <font size=\"4\" color=\"red\">NSAttributedString</font>   <h1>from</h1> <font size=\"7\" color=\"red\">HTMLs!</font><img src=\"http://vi3.ku6img.com/data1/p2/ku6video/2012/10/11/20/1355060715235_32514807_32514807/104.jpg\" /> 请<a href = \"http://www.baidu.com\">点击百度</a> <img src=\"http://vi3.ku6img.com/data1/p2/ku6video/2012/10/11/20/1355060715235_32514807_32514807/104.jpg\" />" ;
    
    
    NSString *target_str = @"_image_image__";
    //如果将图片链接替换成自己想要的东西
    html = [self changeResultStr:target_str attrString:html pattern:@"<img[^>]*/>"];
    
    NSLog(@"替换过好的html为：%@",html);
    
    
    //html富文本格式化
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:options documentAttributes:nil error:nil];
    
    //图片部分
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"Order@2x"];
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    //匹配表情文字
    [self changeResult:imgStr attrString:attrString pattern:target_str];
    
    
//    [attrString replaceCharactersInRange:NSMakeRange(13, 0) withAttributedString:imgStr];
    
    UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 340, 500)];
    [self.view addSubview:label];
    label.delegate = self;
    label.attributedText = attrString;
    
    [label sizeToFit];
    label.backgroundColor = [UIColor grayColor];
    
    NSLog(@"\n\n\n%@",[self getHTML:label.attributedText]);
    
    NSAttributedString *strgood = label.attributedText;

    
    NSArray *arr =   [strgood accessibilityElements];
    NSLog(@"count:%ld",arr.count);
}

- (NSString *)getHTML:(NSAttributedString *)attri {
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length) documentAttributes:exportParams error:nil];
    return [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"开始改变range.location:%ld,range.length:%ld,改变的内容：%@",range.location,range.length,text);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
