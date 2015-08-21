//
//  HomeViewController.swift
//  LanouCProject
//
//  Created by lanou on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class HomeViewController: MyBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addLeftMenu("菜单")
        
        createMyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMyView(){
        

        
        var smoreMo:SmoreModel = SmoreModel()
        smoreMo.title = "大的标题,大的标题"
        smoreMo.titleDis = "小的标题,小的标题"
        smoreMo.color = UIColor.redColor()
        
        smoreMo.imageUrl = "http://img3.cache.netease.com/photo/0003/2015-06-30/ATCDPPU800AJ0003.jpg"
        
        var dataArr:Array<SmoreModel> = [smoreMo,smoreMo,smoreMo,smoreMo,smoreMo]
        
        var smoreView = SmoreFrameView(frame: CGRectMake(0, 50, self.view.frame.size.width, 150))
        smoreView.createMyView("测试苗条哦",data: dataArr, blockItem: { (s1:String, s2:String) -> () in
            //
            println("主页面收到'\(s1)'下的'\(s2)'")
            }) { (s1:String) -> () in
            //
            println("主页面收到'\(s1)'下的more点击")
        }
        self.view.addSubview(smoreView)
        
        
        
    }
    
    
    override func onTouchLeft() {
//       
        println("点击了左边的按钮")
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
