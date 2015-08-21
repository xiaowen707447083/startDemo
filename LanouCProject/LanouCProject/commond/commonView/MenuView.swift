//
//  MenuView.swift
//  LanouBProject
//
//  Created by lanou on 15/8/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class MenuView: UIView {

    var oldSelect:Int = 1
    
    typealias funcBlockMenuView = (Int,Int) -> ()//定义一个指针类型
    var blockMenuView:funcBlockMenuView!//定义一个block
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createMyView();//初始化view
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //以上两个为必须的实现方法
    
    var leftView:UIView!
    var rightView:UIView!
    var isShowAnimous:Bool = false
    
    func createMyView(){
        self.hidden = true //设置为隐藏状态
        self.backgroundColor = UIColor.clearColor()//透明背景色
        
        var fx = self.frame.size.width
        var fy = self.frame.size.height
        
        //设置背景
        var bg_img1 = UIImage(rect_type: UIImage(named: "menubg"), width: fx, height: fy ,x_1:0, x_2:0.5, y_1:0, y_2:1)
        var bg_img2 = UIImage(rect_type: UIImage(named: "menubg"), width: fx, height: fy ,x_1:0.5, x_2:0.5, y_1:0, y_2:1)
        
        
        leftView = UIView(frame: CGRectMake(-fx/2, 0, fx/2, fy))
        rightView = UIView(frame: CGRectMake(fx, 0, fx/2, fy))
        
        var bgview1 = UIImageView(image: bg_img1)
        bgview1.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)
        var bgview2 = UIImageView(image: bg_img2)
        bgview2.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)
       
        leftView.addSubview(bgview1)
        rightView.addSubview(bgview2)
        
        //下面的方式图片会平铺
//        leftView.backgroundColor = UIColor(patternImage: bg_img1)
//        rightView.backgroundColor = UIColor(patternImage: bg_img2)
        

        self.addSubview(leftView)
        self.addSubview(rightView)
        
        //按钮
        var leftBtn = ["百科","图片鉴赏","那些事"]
        var rightBtn = ["周边","品种","关于"]
        
        var widthBtn:CGFloat = 100;
        var widthImageView:CGFloat = widthBtn - 25;
        var indexx:CGFloat = (fx - 2*widthBtn)/3
        var indexy = (fy - 2*indexx - 3*widthBtn)/2;
        var textFont:CGFloat = 17
        
        
        for var i=0;i<leftBtn.count;i++
        {
            var tempy = indexy + CGFloat(i)*(widthBtn+indexx)
            var btnView = UIView(frame: CGRectMake(indexx, tempy, widthBtn, widthBtn))
            btnView.backgroundColor = UIColor.clearColor()
            
            //添加图片按钮
            var tempImageview = UIImageView(image: UIImage.circleImageWithName("left_menu_\(i)", borderWidth: 3, borderColor: UIColor.yellowColor()))
            tempImageview.frame = CGRectMake((widthBtn - widthImageView)/2, 0, widthImageView, widthImageView)
            btnView.addSubview(tempImageview)
            
            var label = UILabel(frame: CGRectMake((widthBtn-widthImageView)/2, widthBtn-25, widthImageView, 25))
            label.font = UIFont.systemFontOfSize(textFont)
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(leftBtn[i])"
            label.textColor = UIColor.blackColor()
            btnView.addSubview(label)
            
            
            //点击事件.
            var tap = MyTapGestureRecognizer(target: self, action: Selector("ontouchBtnView:"))
            tap.numberOfTapsRequired = 1
            tap.myTag = i*2 + 1
            btnView.addGestureRecognizer(tap)
            
            leftView.addSubview(btnView)
        }
        
        for var i=0;i<rightBtn.count;i++
        {
            var tempy = indexy + CGFloat(i)*(widthBtn+indexx)
            var btnView = UIView(frame: CGRectMake(indexx/2, tempy, widthBtn, widthBtn))
            btnView.backgroundColor = UIColor.clearColor()
            
            //添加图片按钮
            var tempImageview = UIImageView(image: UIImage.circleImageWithName("right_menu_\(i)", borderWidth: 3, borderColor: UIColor.yellowColor()))
            tempImageview.frame = CGRectMake((widthBtn - widthImageView)/2, 0, widthImageView, widthImageView)
            btnView.addSubview(tempImageview)
            
//            btnView.userInteractionEnabled = true//用户交互
            var label = UILabel(frame: CGRectMake((widthBtn-widthImageView)/2, widthBtn-25, widthImageView, 25))
            label.font = UIFont.systemFontOfSize(textFont)
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(rightBtn[i])"
            label.textColor = UIColor.blackColor()
            btnView.addSubview(label)
            
            //点击事件
            var tap = MyTapGestureRecognizer(target: self, action: Selector("ontouchBtnView:"))
            tap.numberOfTapsRequired = 1
            tap.myTag = i*2 + 2
            btnView.addGestureRecognizer(tap)
            rightView.addSubview(btnView)
        }
        
    }
    
    
    
    //点击btn的方法
    func ontouchBtnView(tap:MyTapGestureRecognizer){
//        print("当前点击为第\(tap.myTag)个buttonView")
        blockMenuView?(self.oldSelect,tap.myTag)//如果block存在的话会调用
        
        hide()//隐藏菜单
    }
    
    //显示菜单的方法
    func show(oldSelect:Int){
        if !self.isShowAnimous
        {
            self.oldSelect = oldSelect//设置点击前的位置
            self.isShowAnimous = true//设置动画显示状态
            self.hidden = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                //
                self.leftView.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
                self.rightView.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
                }) { (b:Bool) -> Void in
                    //
                    self.isShowAnimous = false//设置动画显示状态
                    print("打开")
            }
        }
    }
    //隐藏菜单的方法
    func hide(){
   
        if !self.isShowAnimous
        {
            self.isShowAnimous = true//设置动画显示状态
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                //
                self.leftView.frame = CGRectMake(-self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
                self.rightView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width/2, self.frame.size.height);
                }) { (b:Bool) -> Void in
                    //
                    self.hidden = true
                    self.isShowAnimous = false//设置动画显示状态
                    print("关闭")
            }
        }
       
    }
    
    //重新点击view的实现
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hide()
    }
    
    //自定义点击类
    class MyTapGestureRecognizer:UITapGestureRecognizer {
        var myTag:Int = 0 //点击事件的标志
    }

    

}
