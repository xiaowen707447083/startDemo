//
//  TimeViewController.swift
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class TimeModel:NSObject {
    var name:String!
    var messageType:Int = 0
    var imageUrl:String?
    var message:String!
}

class TimeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tab:UITableView!
    var dataArr:Array<TimeModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //数据加载
        dataArr = Array<TimeModel>()
        
        var time1 = TimeModel()
        time1.name = "小明"
        time1.messageType = 1
        time1.message = "我真是日了狗了,我真是日了狗了,我真是日了狗了,我真是日了狗了,我真是日了狗了,我真是日了狗了,我真是日了狗了,我真是日了狗了,😊🐶"
        
        
        dataArr.append(time1)
        dataArr.append(time1)
        dataArr.append(time1)
        dataArr.append(time1)
        dataArr.append(time1)
        
        
        tab = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height - 100))
        tab.delegate = self
        tab.dataSource = self
        tab.registerClass(LeftTableViewCell.self, forCellReuseIdentifier: "cell")
        tab.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tab)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //高度计算
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
         var tempTimeModel = dataArr[indexPath.row]
        var hight = UILabel.getLabelHeight(15, labelWidth: self.view.frame.size.width - 100, content: tempTimeModel.message)
        
        return hight + 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var tableCell: LeftTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as LeftTableViewCell

        var tempTimeModel = dataArr[indexPath.row]

        tableCell.nameLabel.text = tempTimeModel.name
        tableCell.contentLabel.text = tempTimeModel.message
        tableCell.selectionStyle = UITableViewCellSelectionStyle.None
       
        //动态适配高度
        tableCell.checkHight()
 
        return tableCell
    }
    
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return dataArr.count
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
