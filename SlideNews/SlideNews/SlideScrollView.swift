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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
    }
    func initTableviews(num:CGFloat, dgt:UITableViewDelegate, dsource:UITableViewDataSource) {
        self.contentSize = CGSizeMake((num) * self.frame.width, 0)
        self.pagingEnabled = true
        for index in 0...Int(num - 1) {
            
            let rect = CGRectMake(CGFloat(index) * self.frame.width, 0, self.frame.width, self.frame.height)
            let tableView = UITableView.init(frame: rect, style: UITableViewStyle.Grouped)
            tableView.tag = Int(index + 1)
            let rd = CGFloat(arc4random() % 255) / 255
            tableView.backgroundColor = UIColor.init(red: rd, green: rd, blue: rd, alpha: 1)
            tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "rs")
            tableView.delegate = dgt
            tableView.dataSource = dsource
            self.addSubview(tableView)
     
        }
        
    }
    func initHeaderView(num:CGFloat) {
         self.contentSize = CGSizeMake((num) * 60, 0)
         self.pagingEnabled = false
        for index in 0...Int(num - 1) {
            let btn = UIButton.init(type: UIButtonType.System)
            if index == 0 {
                btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            }
            btn.tag = index + 100
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            btn.frame = CGRectMake(CGFloat(index) * 60, 0, 60, self.frame.height)
            btn.setTitle((index + 1).description + "0000", forState: UIControlState.Normal)
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

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
