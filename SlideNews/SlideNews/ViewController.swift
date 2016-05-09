//
//  ViewController.swift
//  SlideNews
//
//  Created by 蔡杨振宇 on 16/5/9.
//  Copyright © 2016年 蔡杨振宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, slideDelegate {
    var scrollView:SlideScrollView!
    var headerscrol:SlideScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = SlideScrollView.init(frame: view.frame)
        view.addSubview(scrollView)
        scrollView.initTableviews(10, dgt: self, dsource: self)
        scrollView.delegate = self
        
        headerscrol = SlideScrollView.init(frame: CGRectMake(0, 0, view.frame.width, 44))
        headerscrol.initHeaderView(10)
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
            headerscrol.swipChange(Int(num))
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

}

