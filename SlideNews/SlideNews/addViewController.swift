//
//  addViewController.swift
//  SlideNews
//
//  Created by 蔡杨振宇 on 16/5/10.
//  Copyright © 2016年 蔡杨振宇. All rights reserved.
//

import UIKit
protocol sbDelegate  {
    func sendBackArray(arr:NSArray)
}
class addViewController: UIViewController {
    var arr = NSMutableArray()
    var buttonArr = NSMutableArray()
    var buttonArr1 = NSMutableArray()
    var contain:Bool!
    var startPoint:CGPoint!
    var originPoint:CGPoint!
    var fraArr = NSMutableArray()
    var tgArr = NSMutableArray()
    
    
//
    var fraArr1 = NSMutableArray()
    var tgArr1 = NSMutableArray()
    
    var delegate = sbDelegate?()
    var topView:UIView!//上层view
    var bottomView:UIView!//上层view
    var btAr:NSMutableArray = ["互联网","娱乐","社会","汽车","体育","搞笑","重口味","时尚","美女","情感"]
    func reloadTpFrame() {
        let heigh = 40 + (buttonArr.count - 1) / 3 * 40
        let heigh1 = 40 + (buttonArr1.count - 1) / 3 * 40
        self.topView.frame = CGRectMake(0, 0, view.frame.width, CGFloat(heigh))
        self.bottomView.frame = CGRectMake(0, topView.frame.height + 40, view.frame.width, CGFloat(heigh1))
        let h = 50 + topView.frame.height
        if buttonArr1.count > 0 {
        for i in 0...buttonArr1.count - 1 {
            (buttonArr1[i] as! UIButton).frame.origin.y  =  CGFloat((i / 3) * (24 + 10)) + h
        }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let heigh = 40 + (arr.count) / 3 * 40
        
        self.topView = UIView.init(frame: CGRectMake(0, 0, view.frame.width, CGFloat(heigh)))
       
        topView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(topView)
        
        let heigh1 = 40 + (btAr.count - 1) / 3 * 40
        self.bottomView = UIView.init(frame: CGRectMake(0, topView.frame.height + 40, view.frame.width, CGFloat(heigh1)))
        self.bottomView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(bottomView)
        initButtons()
        initLowBtn()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addViewController.popLast))
        // Do any additional setup after loading the view.
    }
    func popLast() {
        let arr1 = NSMutableArray()
        for item in buttonArr {
            arr1.addObject((item as! UIButton).currentTitle!)
        }
        self.delegate?.sendBackArray(NSArray.init(array: arr1))
        self.navigationController?.popViewControllerAnimated(true)
    }
    func initLowBtn() {
        for i in 0...btAr.count - 1 {
            
            let btn = UIButton(type: UIButtonType.System)
            let wid = Int(self.view.frame.width - 40) / 3
            let h = 50 + topView.frame.height
            btn.frame = CGRectMake(CGFloat((i % 3) * (wid + 10) + 10) , CGFloat((i / 3) * (24 + 10)) + h , CGFloat(wid), 30)
            btn.tag = i + 1001
            self.view.addSubview(btn)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.setTitle(btAr[i] as? String, forState: UIControlState.Normal)
            btn.userInteractionEnabled = true
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 5
            btn.addTarget(self, action: #selector(addViewController.onclick1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.buttonArr1.addObject(btn)
//            self.buttonArr.addObject(btn)
            //            self.itemArray.addObject(btn)
        }

    }
    func initButtons() {
        for i in 0...arr.count - 1 {
            
            let btn = UIButton(type: UIButtonType.System)
            let wid = Int(self.view.frame.width - 40) / 3
            btn.frame = CGRectMake(CGFloat((i % 3) * (wid + 10) + 10) , CGFloat((i / 3) * (24 + 10) + 10) , CGFloat(wid), 30)
            btn.tag = i + 1
            self.view.addSubview(btn)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.setTitle(arr[i] as? String, forState: UIControlState.Normal)
            btn.userInteractionEnabled = true
            let long = UILongPressGestureRecognizer(target: self, action: #selector(addViewController.pressed(_:)))
            btn.addGestureRecognizer(long)
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 5
            btn.addTarget(self, action: #selector(addViewController.onclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.buttonArr.addObject(btn)

//            self.itemArray.addObject(btn)
        }
    }
    
    func indexOfPoint(point:CGPoint, btn1:UIButton) ->Int {
        for index in 0...buttonArr.count - 1 {
            let btn = buttonArr.objectAtIndex(index) as! UIButton
            if btn != btn1 {
                if CGRectContainsPoint(btn.frame, point) {
                    return index
                }
            }
        }
        return -1
    }

    func pressed(sender:UIGestureRecognizer) {
        let btn = sender.view as! UIButton
       var clickTag = btn.tag
        if sender.state == UIGestureRecognizerState.Began {
            startPoint = sender.locationInView(sender.view)
            originPoint = btn.center
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                btn.transform = CGAffineTransformMakeScale(1.1, 1.1)
                btn.alpha = 0.7
            })
        }else if sender.state == UIGestureRecognizerState.Changed {
            let newPoint = sender.locationInView(sender.view)
            let deltaX = newPoint.x - startPoint.x
            let deltaY = newPoint.y - startPoint.y
            btn.center = CGPointMake(btn.center.x + deltaX, btn.center.y + deltaY)

            let index = self.indexOfPoint(btn.center, btn1: btn)
            if index < 0 {
                contain = false
            }else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    var temp = CGPointZero
                    var tgg = 0
                    
                    let button = self.buttonArr.objectAtIndex(index) as! UIButton
                    temp = button.center;
                    button.center = self.originPoint
                    btn.center = temp
                    self.buttonArr.replaceObjectAtIndex(index, withObject: btn)
                    self.buttonArr.replaceObjectAtIndex(clickTag - 1, withObject: button)
                    tgg = button.tag
                    button.tag = clickTag
                    btn.tag = tgg
                    clickTag = btn.tag
                    
                    
                    
                    self.originPoint = btn.center
                    self.contain = true
                })
            }
            
        }else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                btn.transform = CGAffineTransformIdentity
                btn.alpha = 1.0
                if self.contain == nil || self.contain == false {
                    btn.center = self.originPoint
                }
            })
        }
    }
    //下面的按钮点击
    func onclick1(sender:UIButton) {
        
        
        
        
        let wid = Int(self.view.frame.width - 40) / 3
        let button = UIButton.init(type: UIButtonType.System)
        button.frame = sender.frame
        button.tag = buttonArr.count + 1
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitle(sender.currentTitle, forState: UIControlState.Normal)
        button.userInteractionEnabled = true
        let long = UILongPressGestureRecognizer(target: self, action: #selector(addViewController.pressed(_:)))
        button.addGestureRecognizer(long)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addViewController.onclick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        buttonArr.addObject(button)
        let i = buttonArr.count - 1
        UIView.animateWithDuration(0.4, animations: {
            button.frame = CGRectMake(CGFloat((i % 3) * (wid + 10) + 10) , CGFloat((i / 3) * (24 + 10) + 10) , CGFloat(wid), 30)
        }) { (finished) in
            self.reloadTpFrame()
        }

      //删除
        
        if sender.tag - 1000 != buttonArr1.count {
            for index in sender.tag - 1001...buttonArr1.count - 2{
                let fra1 = (buttonArr1.objectAtIndex(index) as! UIButton).frame
                let tg1 = (buttonArr1.objectAtIndex(index) as! UIButton).tag
                fraArr1.addObject(NSValue(CGRect: fra1))
                tgArr1.addObject(tg1)
            }
            
         
            UIView.animateWithDuration(0.4, animations: {
                for index in 0...self.tgArr1.count - 1 {
                    print(sender.tag)
                    (self.buttonArr1.objectAtIndex(sender.tag + index - 1000) as! UIButton).frame = (self.fraArr1[index] as! NSValue).CGRectValue()
                    (self.buttonArr1.objectAtIndex(sender.tag + index - 1000) as! UIButton).tag = self.tgArr1[index] as! Int
                }
                
                }, completion: { (finished) in
                    self.reloadTpFrame()
                    
            })
            
            (buttonArr1.objectAtIndex(sender.tag - 1001) as! UIButton).removeFromSuperview()
            buttonArr1.removeObjectAtIndex(sender.tag - 1001)
            fraArr1.removeAllObjects()
            tgArr1.removeAllObjects()
        }else {
            (buttonArr1.lastObject as! UIButton).removeFromSuperview()
            buttonArr1.removeLastObject()
            reloadTpFrame()
            
        }
        
      
        
        
    }
//    上面的按钮点击
    func onclick(sender:UIButton) {
        
        if buttonArr.count > 1 {
            if sender.tag != buttonArr.count {
            for index in sender.tag - 1...buttonArr.count - 2 {
                let fra1 = (buttonArr.objectAtIndex(index) as! UIButton).frame
                let tg1 = (buttonArr.objectAtIndex(index) as! UIButton).tag
                fraArr.addObject(NSValue(CGRect: fra1))
                tgArr.addObject(tg1)
            }
        
                UIView.animateWithDuration(0.4, animations: { 
                    for index in 0...self.tgArr.count - 1 {
                        (self.buttonArr.objectAtIndex(sender.tag + index) as! UIButton).frame = (self.fraArr[index] as! NSValue).CGRectValue()
                        (self.buttonArr.objectAtIndex(sender.tag + index) as! UIButton).tag = self.tgArr[index] as! Int
                    }

                    }, completion: { (finished) in
                        self.reloadTpFrame()

                })
            
            (buttonArr.objectAtIndex(sender.tag - 1) as! UIButton).removeFromSuperview()
        
            buttonArr.removeObjectAtIndex(sender.tag - 1)
            fraArr.removeAllObjects()
            tgArr.removeAllObjects()
            }else {
                (buttonArr.lastObject as! UIButton).removeFromSuperview()
                 buttonArr.removeLastObject()
                reloadTpFrame()

            }
            
        }
        
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
