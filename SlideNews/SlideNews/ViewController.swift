//
//  ViewController.swift
//  SlideNews
//
//  Created by 蔡杨振宇 on 16/5/9.
//  Copyright © 2016年 蔡杨振宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, slideDelegate,sbDelegate {
    var scrollView:SlideScrollView!
    var headerscrol:SlideScrollView!
   
    var arr = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = SlideScrollView.init(frame: view.frame)
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        
        headerscrol = SlideScrollView.init(frame: CGRectMake(0, 0, view.frame.width, 44))
        arr = ["快报","娱乐","视频","汽车","游戏","财经","军事","体育","历史","国际"] as NSArray
         scrollView.initTableviews(arr, dgt: self, dsource: self)
        headerscrol.initHeaderView(arr)
        headerscrol.sliddelegate = self
        view.addSubview(headerscrol)
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func sendOfftag(tag: Int) {
        UIView.animateWithDuration(0.2) { 
            self.scrollView.contentOffset = CGPointMake(CGFloat(tag) * self.view.frame.width, 0)
        }
        
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let num = scrollView.contentOffset.x / view.frame.width
            if Int(num) < self.arr.count {
            headerscrol.swipChange(Int(num))
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rs")!
        cell.textLabel?.text = tableView.tag.description
        return cell
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    func sendBackArray(arr: NSArray) {
        scrollView.removeTables()
        headerscrol.removeButtons()
        self.arr = arr
        scrollView.initTableviews(arr, dgt: self, dsource: self)
        headerscrol.initHeaderView(arr)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add" {
        (segue.destinationViewController as! addViewController).arr = NSMutableArray.init(array: self.arr)
        (segue.destinationViewController as! addViewController).delegate = self
        }
    }

}

