//
//  SmoreFrameView.swift
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class SmoreFrameView: UIView {

    typealias funcBlockA = (String,String) -> ()//定义一个指针类型
    typealias funcBlockB = (String) -> ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        createMyView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var dataArr:Array<SmoreModel>!
    var scrollerView:UIScrollView!
    var topTitleText:String!
    
    var itemBlock:funcBlockA?
    var moreBlock:funcBlockB?
    
    func createMyView(title:String,data:Array<SmoreModel>,blockItem:funcBlockA,blockMore:funcBlockB){
        
        dataArr = data
        topTitleText = title
        itemBlock = blockItem
        moreBlock = blockMore
        
        
        self.backgroundColor = UIColor.whiteColor()//白色背景
        
        var topView:UIView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, 50))
        var topTitle:UILabel = UILabel(frame: CGRectMake(10, 10, 100, 45))
        topTitle.text = topTitleText
        topTitle.font = UIFont.systemFontOfSize(16)
        topTitle.textAlignment = NSTextAlignment.Left
        topTitle.textColor = UIColor.blackColor()
        topView.addSubview(topTitle)
        
        var topRight:UILabel = UILabel(frame: CGRectMake(self.frame.width - 70, 10, 60, 45))
        topRight.text = "更多  >"
        topRight.textColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
        topRight.textAlignment = NSTextAlignment.Center
        topRight.font = UIFont.systemFontOfSize(14)
        
     

        
        
        topView.addSubview(topRight)
        self.addSubview(topView)
        
        //添加点击事件
        topRight.userInteractionEnabled = true
        var tap1 = UITapGestureRecognizer(target: self, action: Selector("ontouchMore"))
        tap1.numberOfTapsRequired = 1
        topRight.addGestureRecognizer(tap1)
        
        var high:CGFloat = self.frame.height - 60
        var width:CGFloat = high * 3/2
        var width1:CGFloat = 10
        
        //scrollerView布局
        scrollerView = UIScrollView(frame: CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50))
        scrollerView.backgroundColor = UIColor.whiteColor()
        scrollerView.contentSize = CGSizeMake((width + 10.0) * CGFloat(dataArr.count) + 10, high)
        scrollerView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollerView)
        
        for var i:Int = 0;i<dataArr.count;i++ {
            var indexX:CGFloat = CGFloat(i)*width+(CGFloat(i)+1)*width1
            var tempView:UIView = UIView(frame: CGRectMake(indexX, 0, width, high))
            scrollerView.addSubview(tempView)
            
            var tempSmore:SmoreModel = dataArr[i]
            if (tempSmore.imageUrl? != nil) {//如果图片链接为空
                var imgView = UIImageView(frame: CGRectMake(0, 0, width, high))
                imgView.sd_setImageWithURL(NSURL(string: tempSmore.imageUrl!))
                tempView.addSubview(imgView)
                
                
                //覆盖层
                var tempView2:UIView = UIView(frame: CGRectMake(indexX, 0, width, high))
                tempView2.backgroundColor = UIColor.grayColor()
                tempView2.alpha = 0.3
                scrollerView.addSubview(tempView2)
            }else {
                tempView.backgroundColor = tempSmore.color //背景色
            }
            
            //文字框
            var tempView1:UIView = UIView(frame: CGRectMake(indexX, 0, width, high))
            tempView1.backgroundColor = UIColor.clearColor()
            tempView1.alpha = 1
            scrollerView.addSubview(tempView1)
            
            var label1:UILabel = UILabel(frame: CGRectMake(0, high/2 - 25, width, 25))
            label1.textAlignment = NSTextAlignment.Center
            label1.textColor = UIColor.whiteColor()
            label1.font = UIFont.boldSystemFontOfSize(16)
            label1.text = tempSmore.title
            tempView1.addSubview(label1)
            
            var label2:UILabel = UILabel(frame: CGRectMake(0, high/2 + 5, width, 20))
            label2.textAlignment = NSTextAlignment.Center
            label2.textColor = UIColor.whiteColor()
            label2.font = UIFont.systemFontOfSize(14)
            label2.text = tempSmore.titleDis
            tempView1.addSubview(label2)
            
            //添加点击事件
            var tap = SmoreUITapGestureRecognizer(target: self, action: Selector("ontouchItem:"))
            tap.numberOfTapsRequired = 1
            tap.myTag = i
            tap.itemTitle = tempSmore.title
            tempView1.addGestureRecognizer(tap)
            
        }

    }
    
    func ontouchItem(tap:SmoreUITapGestureRecognizer){
        println("你点击了'\(topTitleText)'下的'\(tap.itemTitle)'")
        itemBlock?(topTitleText,tap.itemTitle)
    }
    
    func ontouchMore(){
        println("你点击了'\(topTitleText)'的更多")
        moreBlock?(topTitleText)
    }

}

class SmoreUITapGestureRecognizer: UITapGestureRecognizer {
    var myTag = 0;   //标志
    var itemTitle = "" //item的标题
}


class SmoreModel:NSObject {
    var title:String!
    var titleDis:String!
    var imageUrl:String?
    var color:UIColor?
}