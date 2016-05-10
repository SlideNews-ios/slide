//
//  SlideScrollView.swift
//  SlideNews
//
//  Created by 蔡杨振宇 on 16/5/9.
//  Copyright © 2016年 蔡杨振宇. All rights reserved.
//

import UIKit
protocol slideDelegate {
    func sendOfftag(tag:Int)
}
class SlideScrollView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var buttonArr = NSMutableArray()
    var sliddelegate = slideDelegate?()
    var line1:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        line1 = UIView.init(frame: CGRectMake(0, self.frame.height - 3, 60, 3))
        line1.backgroundColor = UIColor.redColor()
        self.addSubview(line1)
    }
    func initTableviews(num:CGFloat, dgt:UITableViewDelegate, dsource:UITableViewDataSource) {
        self.contentSize = CGSizeMake((num) * self.frame.width, 0)
        self.pagingEnabled = true
        for index in 0...Int(num - 1) {
            
            let rect = CGRectMake(CGFloat(index) * self.frame.width, 0, self.frame.width, self.frame.height)
            let tableView = UITableView.init(frame: rect, style: UITableViewStyle.Grouped)
            tableView.tag = Int(index + 1)
            tableView.backgroundColor = UIColor.lightGrayColor()
            tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "rs")
            tableView.delegate = dgt
            tableView.dataSource = dsource
            self.addSubview(tableView)
     
        }
        
    }
    func initHeaderView(arr:NSArray) {
         self.contentSize = CGSizeMake(CGFloat(arr.count) * 60, 0)
         self.pagingEnabled = false
        for index in 0...arr.count - 1 {
            let btn = UIButton.init(type: UIButtonType.System)
            if index == 0 {
                btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            }
            btn.tag = index + 100
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            btn.frame = CGRectMake(CGFloat(index) * 60, 0, 60, self.frame.height)
            btn.setTitle(arr[index] as? String, forState: UIControlState.Normal)
            btn.addTarget(self, action: #selector(SlideScrollView.offset(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            buttonArr.addObject(btn)
            self.addSubview(btn)
        }
        
    }
    func offset(sender:UIButton) {
       
        for item in buttonArr {
            item.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
         sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.sliddelegate?.sendOfftag(sender.tag - 100)
        if CGFloat(sender.tag + 1 - 100) * 60 > self.frame.width + self.contentOffset.x{
            self.contentOffset.x = ((CGFloat(sender.tag + 1) - 100) * 60 - self.frame.width)
            
        }
        if CGFloat(sender.tag - 100) * 60 < self.contentOffset.x{
            self.contentOffset.x = CGFloat(sender.tag - 100) * 60
         
        }
        line1.frame = CGRectMake(sender.frame.origin.x, self.frame.height - 3, 60, 3)
    }
    func swipChange(num:Int) {
        let btn = self.viewWithTag(num + 100) as! UIButton
        for item in buttonArr {
            item.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)

        if CGFloat(num + 1) * 60 > self.frame.width + self.contentOffset.x{
            self.contentOffset.x = ((CGFloat(num + 1)) * 60 - self.frame.width)
        }
        if CGFloat(num) * 60 < self.contentOffset.x{
            self.contentOffset.x = CGFloat(num) * 60
        
        }
        line1.frame = CGRectMake(btn.frame.origin.x, self.frame.height - 3, 60, 3)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
