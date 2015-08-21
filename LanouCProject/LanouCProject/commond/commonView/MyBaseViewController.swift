//
//  MyBaseViewController.swift
//  LanouBProject
//
//  Created by lanou on 15/8/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit
var hud:MBProgressHUD!


//protocol MyBaseViewControllerDelegate:NSObjectProtocol{
//    func openMemu()
//}
extension String {
    
    // readonly computed property
    var length: Int {
        return countElements(self)
    }
}

class MyBaseViewController: UIViewController {
    
    
    
//    var myDelegate:MyBaseViewControllerDelegate?
    
    typealias funcBlockA = (Int) -> ()//定义一个指针类型
    
    var blockMenu:funcBlockA!//定义一个block
    
    //默认菜单颜色
    var menuColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var bgColor_default = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor_default
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //异步线程更新ui,回到主线程的操作
    //    dispatch_async(dispatch_get_main_queue(), { () -> Void in
    //    })
    
    //    //单条线程
    //    //封装block实现多线程,很大程度上简化了代码
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        //子线程内部(耗时代码写在这里)
    //        [self zuseMainThreadButton];
    //        //H回到主线程
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            //主线程内容
    //            NSLog(@"计算结束");
    //        });
    //    });
    
    //swift的写法
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//    //    sleep(1)
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//    //      self.requestData()//请求数据
//        })
//    })
    
    
    
    //************************👇 重新请求按钮 👇*******************************************
    
    
    //显示刷新按钮
     func showRefrushBtn() {
        //样式跟位置
        var btn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        btn.setTitle("刷新", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.grayColor()
        btn.center = self.view.center
        btn.addTarget(self, action:Selector("ontouchRefershBtn:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func ontouchRefershBtn_befault(button:UIButton){
        button.removeFromSuperview()//把button从view中移除
        ontouchRefershBtn(button)
    }
    //刷新,点击buttion触发的操作
    func ontouchRefershBtn(button:UIButton){
        print("调用刷新方法")
    }
    
    //************************👆 重新请求按钮 👆*******************************************
    
    
    
    //************************👇 开启菜单 👇*******************************************
    
    //代理打开菜单
    func openBaseMenu(){
        
        //如果block不为空的话调用block实现打开菜单 传入当前正在显示的controller的下标
        blockMenu?(self.tabBarController!.selectedIndex+1)
    }
    
    //************************👆 开启菜单 👆*******************************************
    
    //************************👇 导航栏左键,右键 👇*******************************************
    //左边导航栏按钮
    func addLeftMenu(var title:String){
        var leftMenu:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftMenu.setTitle(title, forState: UIControlState.Normal)
        leftMenu.setTitleColor(self.menuColor, forState: UIControlState.Normal)
        leftMenu.frame = CGRectMake(0, 0, 50, 30)
        leftMenu.addTarget(self, action: Selector("onTouchLeft"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftMenu)
    }
    func onTouchLeft(){
        println("点击左键")
        self.navigationController?.popViewControllerAnimated(true)
    }
    //右边导航栏按钮
    func addRightMenu(var title:String){
        var rightMenu:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        rightMenu.setTitle(title, forState: UIControlState.Normal)
        rightMenu.setTitleColor(self.menuColor, forState: UIControlState.Normal)
        rightMenu.frame = CGRectMake(0, 0, 50, 30)
        if title.length > 2
        {
            rightMenu.frame = CGRectMake(0, 0, 80, 30)
        }
        
        rightMenu.addTarget(self, action: Selector("onTouchRight"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightMenu)
    }
    func onTouchRight(){
        println("点击右键")
    }
    
    //添加两个右边导航栏按钮
    func addTwoRightMeno(var titleLeft:String, var titleRight:String){
        
        var leftMenu:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        if titleLeft.hasSuffix(".png") {
            leftMenu.setImage(UIImage(named: titleLeft), forState: UIControlState.Normal)
        }else{
            leftMenu.setTitle(titleLeft, forState: UIControlState.Normal)
        }
        
        leftMenu.setTitleColor(self.menuColor, forState: UIControlState.Normal)
        leftMenu.frame = CGRectMake(0, 0, 50, 30)
        leftMenu.addTarget(self, action: Selector("onTouchRight_left"), forControlEvents: UIControlEvents.TouchUpInside)
        
        var rightMenu:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        rightMenu.setTitle(titleRight, forState: UIControlState.Normal)
        rightMenu.setTitleColor(self.menuColor, forState: UIControlState.Normal)
        rightMenu.frame = CGRectMake(50, 0, 50, 30)
        rightMenu.addTarget(self, action: Selector("onTouchRight_right"), forControlEvents: UIControlEvents.TouchUpInside)
        
        var buttnoView = UIView(frame: CGRectMake(0, 0, 100, 30))
        buttnoView.addSubview(leftMenu)
        buttnoView.addSubview(rightMenu)
        
        if !titleLeft.hasSuffix(".png") && titleLeft.length > 2
        {
            leftMenu.frame = CGRectMake(0, 0, 100, 30)
            rightMenu.frame = CGRectMake(90, 0, 50, 30)
            buttnoView.frame = CGRectMake(0, 0, 120, 30)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttnoView)
  
    }
    func onTouchRight_left(){
        print("点击右边第一个按钮")
    }
    func onTouchRight_right(){
        print("点击右边丢二个按钮")
    }
     //************************👆 导航栏左键,右键 👆*******************************************
    
    
    
    //************************👇 loading(加载) 👇*******************************************
    func showLoading(){
        if hud != nil
        {
            hud.removeFromSuperview()
            hud = nil
        }
        hud = MBProgressHUD(view: self.view)//初始化进度框，置于当前的View当中
        self.view.addSubview(hud)
        hud.dimBackground = false//如果设置此属性则当前的view置于后台
        hud.labelText = "请稍后" //设置对话框文字
        //显示对话框
        hud.showAnimated(true, { () -> Void in
            //对话框显示时需要执行的操作  **********************----->在这里模拟延迟操作
            print("loading")
            sleep(12)//在swift中如果bloc里面直接没其他语句只有sleep会编译不通过
            },{ () -> Void in
                if hud != nil
                {
                    hud.removeFromSuperview()
                    hud = nil
                    self.view.toast("网络不给力,请稍后再试",yOffset: 0)
                    self.outOfTime()
                }
                
        })
        
    }    
    //隐藏loading框
    func hideLoading(){
        if hud != nil
        {
            hud.removeFromSuperview()
            hud = nil
        }
    }
    //超时操作,如果子类要对超时操作作处理的话,重写这个方法
    func outOfTime(){
        print("触发超时操作")
    }
    //*****************************👆 loading(加载) 👆**************************************
    
    

     //*****************************👆 颜色 👆**************************************
    
  //*****************************👆 坐标计算 👆**************************************
    func CGRectMake_1(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect{
        var w1:CGFloat = self.view.frame.size.width/375
        var h1:CGFloat = self.view.frame.size.height/667
        
        return CGRectMake(x*w1, y*h1, width*w1, height*h1)
    }
    
}
