//
//  ViewController.m
//  HtmL解析demo
//
//  Created by lanou on 15/8/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@interface ViewController ()

{
    NSMutableArray *currentNewsArr;
    NSMutableArray *currentHrefArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *urlString = nil;
    
    urlString = @"http://daily.zhihu.com/story/7069271";
    
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    
//    NSData *toHtmlData = [self toUTF8:htmlData];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    
    NSArray *aArray = [xpathParser searchWithXPathQuery:@"//div"];
    
    if ([aArray count] > 0) {
        
        for (int i = 0; i < [aArray count]; i++) {
            //从<a>的第82个开始取值，共获取15个值
            TFHppleElement *aElement = [aArray objectAtIndex:i];//获取到第i个a节点下的数据
//            NSArray *aArr = [aElement children];//获取到第i个a节点下的数据
            //<a class="tbg30A" href="http://cat.intopet.com/35903.shtml" title="养护：同一个屋檐下的猫和狗" target="_blank">养护：同一个屋檐下的猫和狗</a>
            
            
            NSDictionary *dic = aElement.attributes;
            NSArray *aChild =aElement.children;
            
            if (dic != nil && [@"main-wrap content-wrap" isEqualToString:dic[@"class"]]) {
                TFHppleElement *tf =[aChild objectAtIndex:0];
//                NSLog(@"url:%@,title:%@",dic[@"href"],tf.content);
                
                NSLog(@"%@",aElement.raw);
//                  NSLog(@"%@",[aArray objectAtIndex:i]);
//                aElement
            }
            
            
            
        }
    }
    

    
}


-(void)demo{
    
    NSString *urlString = nil;
    
    urlString = @"http://cat.intopet.com/Cyclopedia/Knowledge/Index.shtml";
    
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSData *toHtmlData = [self toUTF8:htmlData];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:toHtmlData];
    
    
    NSArray *aArray = [xpathParser searchWithXPathQuery:@"//a"];
    
    if ([aArray count] > 0) {
        
        for (int i = 0; i < [aArray count]; i++) {
            //从<a>的第82个开始取值，共获取15个值
            TFHppleElement *aElement = [aArray objectAtIndex:i];//获取到第i个a节点下的数据
            //            NSArray *aArr = [aElement children];//获取到第i个a节点下的数据
            //<a class="tbg30A" href="http://cat.intopet.com/35903.shtml" title="养护：同一个屋檐下的猫和狗" target="_blank">养护：同一个屋檐下的猫和狗</a>
            
            
            NSDictionary *dic = aElement.attributes;
            NSArray *aChild =aElement.children;
            
            if (dic != nil && [@"tbg30A" isEqualToString:dic[@"class"]]) {
                TFHppleElement *tf =[aChild objectAtIndex:0];
                NSLog(@"url:%@,title:%@",dic[@"href"],tf.content);
                
                
            }
            
            
            
        }
    }

}




-(NSData *) toUTF8:(NSData *)sourceData {
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if (gbkStr == NULL) {
        return nil;
    } else {
        NSString *gbkString = (__bridge NSString *)gbkStr;
        //根据网页源代码中编码方式进行修改，此处为从gbk转换为utf8
        NSString *utf8_String = [gbkString stringByReplacingOccurrencesOfString:@"<meta charset=\"utf-8\">"
                                                                     withString:@"META http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\""];
        
//        NSString *utf8_String = [gbkString stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">"
//                                                                     withString:@"META http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\""];
        
        return [utf8_String dataUsingEncoding:NSUTF8StringEncoding];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
