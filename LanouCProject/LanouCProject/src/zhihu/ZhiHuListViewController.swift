//
//  ZhiHuListViewController.swift
//  LanouCProject
//
//  Created by lanou on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class ZhiHuModel {
    var title:String!
    var imgUrl:String!
    var gotoUrl:String!
    var describe:String!
}

class ZhiHuListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArr:Array<ZhiHuModel>!
    var tb:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = Array<ZhiHuModel>()
        tb = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height))
        tb.delegate = self
        tb.dataSource = self
        tb.registerClass(ZhiHuTableViewCell.self, forCellReuseIdentifier: "cell")
        tb.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tb)
        
        
        
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                self.initData()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //      self.requestData()//请求数据
                    self.tb.reloadData()
                })
            })

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func initData(){
        //初始化数据
        
        var htmlData:NSData = NSData(contentsOfURL:NSURL(string:"http://daily.zhihu.com/")!)!
        
        var xpathParser:TFHpple = TFHpple(HTMLData:htmlData)
        
        var aArray:NSArray = xpathParser.searchWithXPathQuery("//div")
        
        
//        <div class="main-content-wrap">
        if aArray.count>0 {
            for var i=0;i<aArray.count;i++ {
                var aElement:TFHppleElement = aArray[i] as TFHppleElement
                var dic = aElement.attributes
                if (dic != nil){
                    if dic["class"]as String == "box"{
//                        webView.loadHTMLString(aElement.raw, baseURL: nil)
                        
                        var model = ZhiHuModel()
                        
                        var chird:NSArray = aElement.children
                        var aElement1:TFHppleElement = chird[0] as TFHppleElement
                        var dic1 = aElement1.attributes
//                        println(dic1["href"])
                        model.gotoUrl = dic1["href"] as String
                        
                        var chird1:NSArray = aElement1.children
                        var aElement2:TFHppleElement = chird1[0] as TFHppleElement
                        var dic2 = aElement2.attributes
//                        println(dic2["src"])
                         model.imgUrl = dic2["src"] as String
                        
                        var aElement3:TFHppleElement = chird1[1] as TFHppleElement
                       
//                        println(aElement3.content)
                        model.title = aElement3.content
                        
//                        println(aElement1.raw)
                        
                        dataArr.append(model)
                    }
                }
            }
        }
        
//        tb.reloadData()
        
        
        
    }
    
    
    //高度计算
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
//        var tempTimeModel = dataArr[indexPath.row]
//        var hight = UILabel.getLabelHeight(15, labelWidth: self.view.frame.size.width - 100, content: tempTimeModel.message)
//        
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var tableCell: ZhiHuTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as ZhiHuTableViewCell
        
        var tempTimeModel:ZhiHuModel = dataArr[indexPath.row]
        tableCell.contentLabel?.text = tempTimeModel.title//
        tableCell.imgView?.sd_setImageWithURL(NSURL(string: tempTimeModel.imgUrl),placeholderImage:UIImage(named: "loading_error.jpg"))
        
        return tableCell
    }
    
    
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        //
//        var tempTimeModel = dataArr[indexPath.row]
//        
//        var goto = ZhiHuDetailController()
//        goto.urlStr = tempTimeModel.gotoUrl
//        self.navigationController?.pushViewController(goto, animated: true)
//        
//        
//    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var tempTimeModel = dataArr[indexPath.row]
        
        var goto = ZhiHuDetailController()
        goto.urlStr = tempTimeModel.gotoUrl
        self.navigationController?.pushViewController(goto, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return dataArr.count
    }
    
    
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
