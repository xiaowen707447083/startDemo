//
//  ZhiHuDetailController.swift
//  LanouCProject
//
//  Created by lanou on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class ZhiHuDetailController: MyBaseViewController {

    var urlStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var webView:UIWebView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        self.view.addSubview(webView)
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var htmlData:NSData = NSData(contentsOfURL:NSURL(string:self.urlStr)!)!
            
            var xpathParser:TFHpple = TFHpple(HTMLData:htmlData)
            
            var aArray:NSArray = xpathParser.searchWithXPathQuery("//div")
            
            var result:String!
            
            if aArray.count>0 {
                for var i=0;i<aArray.count;i++ {
                    var aElement:TFHppleElement = aArray[i] as TFHppleElement
                    var dic = aElement.attributes
                    if ( dic["class"] != nil ){
                        if dic["class"]as String == "main-wrap content-wrap"{
                            var width = self.view.frame.size.width
                            result = aElement.raw.stringByReplacingOccurrencesOfString("<img", withString: "<img width=\"\(width)\"")
                            //有些小图 <img class="avatar"
                            result = aElement.raw.stringByReplacingOccurrencesOfString("<img width=\"\(width)\" class=\"avatar\"", withString: "<img class=\"avatar\"")
                            //                        println(result)
                            
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //      self.requestData()//请求数据
                webView.loadHTMLString(result, baseURL: nil)
            })
        })
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
}
